import { Route, Routes} from "react-router-dom";
import Event from '../src/pages/Events.jsx';
import CreateEvent from '../src/pages/CreateEvent.jsx';
import NotFound from '../src/pages/NotFound.jsx'
import Layout from "./components/Layout.jsx";
import '../src/styles/event.css';
import '../src/styles/layout.css';
import '../src/styles/footer.css';

function App() {

  return (
  <>
    <Routes>
      <Route element={<Layout/>}>
      <Route index element={<Event/>}/>
      <Route path="create" element={<CreateEvent/>}/>
      <Route path="*" element={<NotFound/>}/>
      </Route>
    </Routes>
  </>
  )
}

export default App
