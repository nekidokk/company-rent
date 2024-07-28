import "./AddApartment.css"
import { useState } from "react"
export default function AddApartment ({onAddApartment}){

    const[formData, setFormData] = useState({
        locality_type: '',
        locality_name: '',
        street_type: '',
        street_name: '',
        home_number: '',
        basement_coefficient: '',
        technical_imp_coeff: '',
        square: '',
        basement_square: ''
    })

    const handleChange = (e) => {
        setFormData({
            ...formData,
            [e.target.name]: e.target.value
        });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const response = await fetch('http://127.0.0.1:8000/apartments/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });
            if (response.ok) {
                const newApartment = await response.json();
                
                onAddApartment(newApartment);
                // Handle success, maybe reset the form or give user feedback
                setFormData({
                    locality_type: '',
                    locality_name: '',
                    street_type: '',
                    street_name: '',
                    home_number: '',
                    basement_coefficient: '',
                    technical_imp_coeff: '',
                    square: '',
                    basement_square: ''
                });
                
            } else {
                // Handle errors
                const errorData = await response.json();
                console.error("Error adding apartment:", errorData);
                alert("Failed to add apartment");
            }
          
        } catch (error) {
            console.error("Error adding apartment:", error);
            alert("Error adding apartment");
        }
    };

    return(
        <div >
            <form className="AddForm" onSubmit={handleSubmit}>

            <h2>Add an apartment</h2>
            <input placeholder="locality type (Город/Поселок...)" name="locality_type" value={formData.locality_type} onChange={handleChange}></input>
            <input placeholder="name of locality" name="locality_name" value={formData.locality_name} onChange={handleChange}></input>
            <input placeholder="street type (Улица/Проспект...)" name="street_type" value={formData.street_type} onChange={handleChange}></input>
            <input placeholder="name of street" name="street_name" value={formData.street_name} onChange={handleChange}></input>
            <input placeholder="home number" name="home_number" value={formData.home_number} onChange={handleChange}></input>
            <input placeholder="basement coefficient (0/1)" name="basement_coefficient" value={formData.basement_coefficient} onChange={handleChange}></input>
            <input placeholder="technical improvement coefficient (0/1)" name="technical_imp_coeff" value={formData.technical_imp_coeff} onChange={handleChange}></input>
            <input placeholder="square" name="square" value={formData.square} onChange={handleChange}></input>
            <input placeholder="basement square" name="basement_square" value={formData.basement_square} onChange={handleChange}></input>
            <button type="submit" >add</button>
            </form>
        </div>
    )
}
