import NavBar from './Layout.jsx';
import Footer from './Footer.jsx';
import { Outlet } from 'react-router-dom';
import '../styles/layout.css';

const Layout = () => {
  return (
    <div>
        <NavBar/>
        <div
        className='layout'
        >
            <Outlet/>
        </div>
        <Footer/>
    </div>
  )
}

export default Layout