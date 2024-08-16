from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List
import psycopg2
from models import Apartment
from fastapi.middleware.cors import CORSMiddleware



app = FastAPI()

conn = psycopg2.connect(
    dbname = "rent",
    user = "postgres",
    password = "rootroot",
    host = "localhost",
    port = "5432"
)

cursor = conn.cursor()

##эндпоинд для добавления квартиры из AddApartment
@app.post("/apartments/")
async def create_apartment(apartment: Apartment):
    try:
        cursor.execute("BEGIN;")

        # Check if locality already exists
        cursor.execute("SELECT id FROM locality WHERE name = %s AND locality_type_id = (SELECT id FROM locality_type WHERE name = %s);", (apartment.locality_name, apartment.locality_type))
        locality = cursor.fetchone()
        if locality:
            locality_id = locality[0]
        else:
            cursor.execute("INSERT INTO locality (name, locality_type_id) VALUES (%s, (SELECT id FROM locality_type WHERE name = %s)) RETURNING id;", (apartment.locality_name, apartment.locality_type))
            locality_id = cursor.fetchone()[0]

        # Check if street already exists
        cursor.execute("SELECT id FROM street WHERE name = %s AND street_type_id = (SELECT id FROM street_type WHERE name = %s);", (apartment.street_name, apartment.street_type))
        street = cursor.fetchone()
        if street:
            street_id = street[0]
        else:
            cursor.execute("INSERT INTO street (name, street_type_id) VALUES (%s, (SELECT id FROM street_type WHERE name = %s)) RETURNING id;", (apartment.street_name, apartment.street_type))
            street_id = cursor.fetchone()[0]

        # Check if address already exists
        cursor.execute("SELECT id FROM adress WHERE home_number = %s AND street_id = %s AND locality_id = %s;", (apartment.home_number, street_id, locality_id))
        adress = cursor.fetchone()
        if adress:
            adress_id = adress[0]
        else:
            cursor.execute("INSERT INTO adress (home_number, street_id, locality_id) VALUES (%s, %s, %s) RETURNING id;", (apartment.home_number, street_id, locality_id))
            adress_id = cursor.fetchone()[0]

        # Insert apartment
        query = """
        INSERT INTO apartment (square, basement_coefficient, technical_imp_coeff, adress_id, basement_square)
        VALUES (%s, %s, %s, %s, %s)
        RETURNING id;
        """
        cursor.execute(query, (apartment.square, apartment.basement_coefficient, apartment.technical_imp_coeff, adress_id, apartment.basement_square))
        conn.commit()
        new_apartment_id = cursor.fetchone()[0]
        return {"id": new_apartment_id,
                "locality_type": apartment.locality_type,
                "locality_name": apartment.locality_name,
                "street_type": apartment.street_type,
                "street_name": apartment.street_name,
                "home_number": apartment.home_number,
                "basement_coefficient": apartment.basement_coefficient,
                "technical_imp_coeff": apartment.technical_imp_coeff,
                "square": apartment.square,
                "basement_square": apartment.basement_square}
    

    except Exception as e:
        conn.rollback()  # Откат транзакции при ошибке
        raise HTTPException(status_code=500, detail=str(e))


# Эндпоинт для получения списка всех квартир
@app.get("/apartments/")
async def get_all_apartments():
    try:
        query = """
        SELECT home_number, street.name, street_type.short_name, loc.name, loc_type.short_name, a.square, a.id
        FROM public.adress
        JOIN public.street ON street_id = street.id
        JOIN public.street_type ON street_type.id = street_type_id
        JOIN public.locality loc ON loc.id = locality_id
        JOIN public.locality_type loc_type ON loc_type.id = locality_type_id
        JOIN public.apartment a ON a.adress_id = adress.id
        WHERE adress.id IN (SELECT adress_id FROM public.apartment)
        EXCEPT
        SELECT home_number, street.name, street_type.short_name, loc.name, loc_type.short_name, a.square, a.id
        FROM public.adress
        JOIN public.street ON street_id = street.id
        JOIN public.street_type ON street_type.id = street_type_id
        JOIN public.locality loc ON loc.id = locality_id
        JOIN public.locality_type loc_type ON loc_type.id = locality_type_id
        JOIN public.apartment a ON a.adress_id = adress.id
        WHERE adress.id IN (SELECT adress_id FROM public.apartment)
        AND a.id IN (SELECT apartment_id FROM public.agreement);

        
        
        """
        cursor.execute(query)
        apartments = cursor.fetchall()
        return apartments
    except Exception as e:
        conn.rollback()  # Откат транзакции при ошибке
        raise HTTPException(status_code=500, detail=str(e))


# Эндпоинт для удаления квартиры
@app.delete("/apartments/{apartment_id}")
async def delete_apartment(apartment_id: int):
    try:
        
        # Удаляем записи из таблицы adress, связанные с apartment_id
        cursor.execute("DELETE FROM adress WHERE id IN (SELECT adress_id FROM apartment WHERE id = %s)", (apartment_id,))

        # Удаляем записи из таблицы apartment
        cursor.execute("DELETE FROM apartment WHERE id = %s", (apartment_id,))
        
        conn.commit()  # Подтверждаем транзакцию
        return {"message": "Apartment and related data deleted successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Эндпоинт для получения информации о конкретной квартире
@app.get("/apartments/{apartment_id}")
async def get_apartment(apartment_id: int):
    query = """
    SELECT * FROM apartment WHERE id = %s;
    """
    cursor.execute(query, (apartment_id,))
    apartment = cursor.fetchone()
    if apartment is None:
        raise HTTPException(status_code=404, detail="Apartment not found")
    return apartment

# Эндпоинт для получения информации о сумме платежа
@app.get("/date/{date}")
async def get_total_payment(date: str):
    try:
        query = """
        SELECT 
        SUM(month_rent) AS total_payment_amount
        FROM 
        public.agreement
        WHERE 
        date_of_start <= %s -- Specify your date here
        AND date_of_conclusion >= '2024-05-01'; -- Assuming the current month is May 2024
        """
        cursor.execute(query,(date,))
        total_payment = cursor.fetchone()
        if total_payment is None or total_payment[0] is None:
            total_payment_amount = 0
        else:
            total_payment_amount = total_payment[0]
        return {"total_payment_amount": total_payment_amount}
    except Exception as e:
        conn.rollback()  # Rollback transaction on error
        raise HTTPException(status_code=500, detail=str(e)) 

# Эндпоинт для получения списка арендаторов
@app.get("/tenants/{date}")
async def get_tenants(date:str):
    try:
        query = """
        SELECT
        CASE
        WHEN a.tenant_phys_id IS NOT NULL THEN 'Physical'
        WHEN a.tenant_leg_id IS NOT NULL THEN 'Legal'
        ELSE 'Unknown'
        END AS tenant_type,
        CASE
        WHEN a.tenant_phys_id IS NOT NULL THEN CONCAT(pe.surname, ' ', pe.name, ' ', pe.middle_name)
        WHEN a.tenant_leg_id IS NOT NULL THEN le.name
        ELSE 'Unknown'
        END AS tenant_name,
	    loct.short_name,
	    loc.name,
	    stt.short_name,
	    st.name,
	    home_number
        FROM
        public.agreement a
        left join public.physical_entity pe on tenant_phys_id = pe.id  
        left join public.legal_entity le on tenant_leg_id = le.id
        left join public.apartment apart on apartment_id = apart.id 
        left join public.adress adr on apart.adress_id = adr.id
        left join public.street st on st.id = street_id
        left join public.street_type stt on stt.id = street_type_id
        left join public.locality loc on adr.locality_id = loc.id
        left join public.locality_type loct on loc.locality_type_id = loct.id

        WHERE
        %s >= a.date_of_start; -- Specify the current date here
        """
        cursor.execute(query, (date,))
        tenants = cursor.fetchall()
        return tenants
    except Exception as e:
        conn.rollback()  # Rollback transaction on error
        raise HTTPException(status_code=500, detail=str(e))

# Эндпоинт для получения списка свободных помещений
@app.get("/free_apartments/{date}")
async def get_free_apartments(date:str):
    try:
        query = """
        SELECT 
        home_number, street.name, street_type.short_name, loc.name, loc_type.short_name
        FROM 
        public.apartment a
        left join public.adress on adress.id = a.adress_id 
        left join public.street on street_id = street.id
        left join public.street_type on street_type.id = street_type_id
        left join public.locality loc on loc.id = locality_id
        left join public.locality_type loc_type on loc_type.id = locality_type_id
        WHERE   
        a.id NOT IN (
        SELECT agr.apartment_id
        FROM public.agreement agr
        WHERE agr.date_of_start < %s -- Specify your date here
        );
        """
        cursor.execute(query, (date,))
        free_apartments = cursor.fetchall()
        return free_apartments
    except Exception as e:
        conn.rollback()  # Rollback transaction on error
        raise HTTPException(status_code=500, detail=str(e))


# Настройка CORS
origins = [
    "http://localhost:3000",  # React dev server
    "http://127.0.0.1:8000",  # Another common way to access localhost
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)