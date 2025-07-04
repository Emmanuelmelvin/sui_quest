import NavBar from './Layout.jsx';
import Footer from './Footer.jsx';
import { Outlet } from 'react-router-dom';

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