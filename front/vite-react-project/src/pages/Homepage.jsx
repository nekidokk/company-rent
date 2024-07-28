import ApartmentField from '../components/ApartmentField/ApartmentField.jsx'
import AddApartment from '../components/AddApartment/AddApartment.jsx'
import { useState, useEffect } from 'react'
export default function Homepage(){

    const [apartments, setApartments] = useState([]);
    // useEffect( ()=> {
    //   fetch('http://127.0.0.1:8000/apartments')
    //   .then(response => response.json())
    //   .then(data => setApartments(data))
    //   .catch(error => console.error('error fetching apartments', error));
    // }, [])
    useEffect(() => {
      const fetchApartments = async () => {
        try {
          const response = await fetch('http://127.0.0.1:8000/apartments');
          const data = await response.json();
          setApartments(data);
        } catch (error) {
          console.error('Error fetching apartments', error);
        }
      };
  
      fetchApartments();
    }, []);  


    const handleAddApartment = (newApartment) => {
      // Add new apartment to the list
      setApartments(prevApartments => [...prevApartments, newApartment]);
      
    };

    const handleDeleteApartment = (apartmentId) => {
      setApartments(prevApartments => prevApartments.filter(apartment => apartment.id !== apartmentId));
    };

    return(
        <div className='main-content'>
        <div className='apartment-field-container'>
            {apartments.length > 0 ? (
                apartments.map( apartment => (
                  <ApartmentField key={apartment.id} apartment={apartment} onDelete={handleDeleteApartment}/>
                ))
            ) : (
              <p>loading apartments...</p>
            )}
          
        </div>
        <AddApartment  onAddApartment={handleAddApartment}/>
      </div>
    )
}