import "./Modal.css"


export default function Modal({onClose}){
    return(
        <div className="modal-overlay">
            <div className="modal">
                <form>
                <button className="close-button" onClick={onClose}>✖</button>
                <h2>Sign in</h2>
                <label>Username: 
                </label>
                <input type="text" name="username"></input>
                <label>Password: 
                </label>
                <input type="text" name="password"></input>
                <button className="submit-button">Submit</button>
                <p className="link-to-reg">Don't have account? <a>Register</a></p>
                </form>
                
            </div>
        </div>
    )
}