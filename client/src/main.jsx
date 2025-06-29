import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import {WalletProvider} from '@suiet/wallet-kit';
import './index.css'
import App from './App.jsx'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <BrowserRouter>
    <WalletProvider>
    <App />
    </WalletProvider>
    </BrowserRouter>
  </StrictMode>,
)
