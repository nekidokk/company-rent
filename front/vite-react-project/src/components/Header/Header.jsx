import "./Header.scss" 
import Modal from "../Modal/Modal"
import { useState } from "react"
import ModalReg from "../Modal/ModalReg"
import { NavLink } from "react-router-dom"

export default function Header() {

    const [isModalOpen, setIsModalOpen] = useState(false)

    const [isModalRegOpen, setIsModalRegOpen] = useState(false)

    return(
        <div>

        <header className="header">
            <div>
                <h1 className="company-name">COMPANY RENT</h1>
            </div>
            <div className="link-container">
                <NavLink to="/">Home</NavLink>
                <NavLink to="/info">Check info</NavLink>

            </div>
            {/*<div className="buttons">
                <button onClick={() => {setIsModalOpen(true)}}  >Sign in</button>
                <button onClick={() => {setIsModalRegOpen(true)}}>Register</button>
            </div>*/}
        </header>
        {/*
        {isModalOpen && <Modal onClose={() => {setIsModalOpen(false)}}/>}
        {isModalRegOpen && <ModalReg onClose={() => {setIsModalRegOpen(false)}}/>}
        */}
        </div>
    )
}