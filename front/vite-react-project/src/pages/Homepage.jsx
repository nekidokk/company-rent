import ApartmentField from '../components/ApartmentField/ApartmentField.jsx'
import AddApartment from '../components/AddApartment/AddApartment.jsx'
import { useState, useEffect } from 'react'
export default function Homepage(){

    const [apartments, setApartments] = useState([]);
    const [isLoading, setIsLoading] = useState(false);
    // useEffect( ()=> {
    //   fetch('http://127.0.0.1:8000/apartments')
    //   .then(response => response.json())
    //   .then(data => setApartments(data))
    //   .catch(error => console.error('error fetching apartments', error));
    // }, [])


    useEffect(() => {
      const fetchApartments = async () => {
        setIsLoading(true)
        try {
          const response = await fetch('http://127.0.0.1:8000/apartments');
          const data = await response.json();
          setApartments(data);
          
          
        } catch (error) {
          console.error('Error fetching apartments', error);
        }finally{
          setIsLoading(false)
        }
      };
      fetchApartments();
      
    }, []);  


    const handleAddApartment = () => {
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
    };

    const handleDeleteApartment = (apartmentId) => {
      setApartments(prevApartments => prevApartments.filter(apartment => apartment.id !== apartmentId));
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
    };
    
    return(
        <div className='main-content'>
        <div className='apartment-field-container'>
            {isLoading && <p className='message'>Loading data...</p>}
            {apartments.length > 0 ? (
                apartments.map( apartment => (
                  <ApartmentField key={apartment.id} apartment={apartment} onDelete={handleDeleteApartment}/>
                ))
                
            ) : (
              !isLoading && <p className='message'>Add apartment</p>
            )}
          
        </div>
        <AddApartment  onAddApartment={handleAddApartment}/>
      </div>
    )
}