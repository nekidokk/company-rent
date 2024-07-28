from pydantic import BaseModel 


class Apartment(BaseModel):
    
    locality_type: str
    locality_name: str
    street_type: str
    street_name: str
    home_number: str 
    basement_coefficient: float
    technical_imp_coeff: float
    square: float
    basement_square: float
    

class Adress(BaseModel):
    id: int
    home_number: str
    street_id: int
    locality_id: int

class Street(BaseModel):
    id: int
    name: str
    street_type_id: int

class StreetType(BaseModel):
    id: int
    name: str
    short_name: str

class Locality(BaseModel):
    id: int
    name: str
    locality_type_id: int

class LocalityType(BaseModel):
    id: int
    name: str
    short_name: str

class Agreement(BaseModel):
    id: int
    date_of_start: str
    date_of_conclusion: str
    month_rent: float
    tenant_phys_id: int
    tenant_leg_id: int
    apartment_id: int
    base_rate_id: int
    company_id: int

class BaseRate(BaseModel):
    id: int
    date: str
    rate_for_one: float

class PhysicalEntity(BaseModel):
    id: int
    surname: str
    name: str
    middle_name: str
    inn: str
    passport_series: str
    passport_number: str
    passport_date: str
    passport_issued_by: str
    adress_id: int

class LegalEntity(BaseModel):
    id: int
    name: str
    inn: str
    license_date: str
    adress_id: int

class Company(BaseModel):
    id: int
    name: str
    short_name: str
    phone: str
    mail: str
    adress_id: int