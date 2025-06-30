import { WalletProvider } from "@suiet/wallet-kit";
import { Route, Routes} from "react-router-dom";
import Event from '../src/pages/Events.jsx';

function App() {

  return (
    <WalletProvider>
    <Routes>
      <Route path='/events' element={<Event/>}/>
    </Routes>
    </WalletProvider>
  )
}

export default App
