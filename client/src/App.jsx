import { WalletProvider } from "@suiet/wallet-kit";
import { Route, Routes} from "react-router-dom";
import Event from '../src/pages/Events.jsx';
import CreateEvent from '../src/pages/CreateEvent.jsx';
import Layout from "./components/Layout.jsx";
import '../src/styles/layout.css';
import '../src/styles/event.css';

function App() {

  return (
    <WalletProvider>
    <Routes>
      <Route element={<Layout/>}>
      <Route path='/' element={<Event/>}/>
      <Route path="/create-event" element={<CreateEvent/>}/>
      </Route>
    </Routes>
    </WalletProvider>
  )
}

export default App
