import "./Modal.css"

export default function ModalReg(onClose){
    return(
        <div className="modal-overlay">
            <div className="modal">
                <form>
                <button className="close-button" onClick={onClose}>✖</button>
                <h2>Register</h2>
                <label>Username: 
                </label>
                <input type="text" name="username"></input>
                <label>Password: 
                </label>
                <input type="text" name="password"></input>
                <button className="submit-button">Submit</button>
                </form>
                
            </div>
        </div>
    )
}