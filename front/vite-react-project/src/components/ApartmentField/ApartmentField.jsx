import "./ApartmentField.css"

export default function ApartmentField({apartment, onDelete}){

    const handleDelete = async () => {
        try {
            console.log("Deleting apartment with ID:", apartment[6]); // Добавляем эту строку для вывода ID квартиры в консоль
            const response = await fetch(`http://127.0.0.1:8000/apartments/${apartment[6]}`, {
                method: 'DELETE',
            });
            if (!response.ok) {
                throw new Error('Failed to delete apartment');
            }
            onDelete(apartment[6]); // Вызываем функцию onDelete для удаления помещения из списка
        } catch (error) {
            console.error('Error deleting apartment:', error);
        }
    };

    return(
       
            
            <div className="apartment-info">
                <h1>{apartment[4]} {apartment[3]}, {apartment[2]} {apartment[1]}, д. {apartment[0]}</h1>
                <p>Square: {apartment[5]} кв.м.</p>
                <p>ID: {apartment[6]}</p>
                <button onClick={handleDelete}>delete</button>
            </div>

        

        
    )
}