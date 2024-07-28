//import { useState } from 'react'
import './App.css'
import Header from './components/Header/Header.jsx'
import ApartmentField from './components/ApartmentField/ApartmentField.jsx'
import AddApartment from './components/AddApartment/AddApartment.jsx'
import Info from './components/Info/Info.jsx'
import {Routes, Route} from 'react-router-dom'
import Homepage from './pages/Homepage.jsx'
import Infopage from './pages/Infopage.jsx'


function App() {
 

  return (
    
      <div>
        <Header/>
        
        <Routes>
          <Route path="/" element={<Homepage/>} /> 
          <Route path="/info" element={<Infopage/>} /> 
        </Routes>
      </div>
      
    )
}

export default App
