import './FreeApartmentsOutput.css' 

export default function FreeApartmentsOutput({text}){
    return(
        <div className='output-container-ap'>

            <output>{text}</output>
        </div>
    )
}