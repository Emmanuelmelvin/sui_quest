import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import App from './App.jsx'
import "@suiet/wallet-kit/style.css";
import '@mysten/dapp-kit/dist/index.css';

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <BrowserRouter>
            <App/>
    </BrowserRouter>

  </StrictMode>
)
