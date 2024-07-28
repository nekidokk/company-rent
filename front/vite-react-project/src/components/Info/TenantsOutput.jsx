import './TenantsOutput.css' 


export default function TenantsOutput({text}){
    return(
        <div className='output-container-ten'>

            <output>{text}</output>
        </div>
    )
}