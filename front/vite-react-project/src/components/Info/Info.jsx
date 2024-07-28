import './Info.css'
import TenantsOutput from './TenantsOutput'
import FreeApartmentsOutput from './FreeApartmentsOutput'
import { useState } from 'react'
export default function Info(){
    
    const [selectedDate, setSelectedDate] = useState('')
    const [totalPaymentAmount, setTotalPaymentAmount] = useState(0)
    const [tenants, setTenants] = useState([])
    const [freeApartments, setFreeApartments] = useState([])

    const handleFindClick = async () => {
        try{
            const response_payment = await fetch(`http://127.0.0.1:8000/date/${selectedDate}`)
            if (!response_payment.ok){
                throw new Error('network response was not ok - payment')
            }
            const data1 = await response_payment.json()
            setTotalPaymentAmount(data1.total_payment_amount)
        } catch(error1){
            console.log("error on handlefindclick fetching data - payment: ", error1)
        }

        try{
            const response_tenants = await fetch(`http://127.0.0.1:8000/tenants/${selectedDate}`)
            if(!response_tenants.ok){
                throw new Error('network response was not ok - tenants')
            }
            const data2 = await response_tenants.json()
            setTenants(data2)
        } catch(error2){
            console.log("error on handlefindclick fetching data - tenants: ", error2)
        }

        try{
            const response_free_apartments = await fetch(`http://127.0.0.1:8000/free_apartments/${selectedDate}`)
            if (!response_free_apartments.ok){
                throw new Error('network response was not ok - free apartments')
            }
            const data3 = await response_free_apartments.json()
            setFreeApartments(data3)
        } catch(error3){
            console.log("error on handlefindclick fetching data - free apartments: ", error3)
        }
    } 



    return(
        <div className='info-main-container'>
            <div className='left-container'>
                <div className='choose-month'>
                    <label >Choose date: </label>
                    <input  type='date' value={selectedDate} onChange={(e)=> setSelectedDate(e.target.value)} />
                    <button onClick={handleFindClick}>Find</button>
                    
                </div>
                <div className='total-payment-amount'>
                    <label >Total payment amount: </label>
                    <output className='payment-output'>{totalPaymentAmount} ₽</output>
                    
                </div>
                <div className='tentants'>
                    <label >Tenants (type, name, address):  </label>
                    {tenants.map( (tenant, index) => (
                        <TenantsOutput text={`${index+1}) ${tenant[0]}, ${tenant[1]}, ${tenant[2]}, ${tenant[3]}, ${tenant[4]}, ${tenant[5]}, ${tenant[6]} `} key={index}/>
                    ))}
                </div>
            </div>
            <div className='right-container'>
                <div className='free-apartments'>
                    <label >Free apartments:</label>
                    {freeApartments.map( (free_apartment, index) =>(
                        <FreeApartmentsOutput text={`${index+1}) ${free_apartment[4]} ${free_apartment[3]}, ${free_apartment[2]} ${free_apartment[1]}, д. ${free_apartment[0]}`} key={index}/>
                    ))}
                </div>
            </div>
        </div>
    )
}