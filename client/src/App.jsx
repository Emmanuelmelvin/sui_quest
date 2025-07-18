import { useState } from "react";
import { Route, Routes } from "react-router-dom";
import Event from '../src/pages/Events.jsx';
import CreateEvent from '../src/pages/CreateEvent.jsx';
import NotFound from '../src/pages/NotFound.jsx'
import Layout from "./components/Layout.jsx";
import MyAccount from "./pages/MyAccount.jsx";
import { PACKAGE_ID } from "../../constant.js";


import { createNetworkConfig, SuiClientProvider, WalletProvider } from '@mysten/dapp-kit';
import { getFullnodeUrl } from '@mysten/sui/client';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';


// Config options for the networks you want to connect to
const { networkConfig } = createNetworkConfig({
  localnet: { url: getFullnodeUrl('localnet') },
  mainnet: { url: getFullnodeUrl('mainnet') },
  devnet: { 
    url: getFullnodeUrl('devnet'),
    variables: {
			myMovePackageId: PACKAGE_ID,
		},
   }
});

const queryClient = new QueryClient();

function App() {
const [activeNetwork, setActiveNetwork] = useState('devnet');

  return (
    <QueryClientProvider client={queryClient}>
      <SuiClientProvider 
      onNetworkChange={(network) => {
				setActiveNetwork(network);
			}}
      networks={networkConfig} 
      network='devnet'>
        <WalletProvider>
          <AppRoutes />
          {
            activeNetwork
          }
        </WalletProvider>
      </SuiClientProvider>
    </QueryClientProvider>
  )
}

function AppRoutes() {

  return (

    <Routes>
      <Route element={<Layout />}>
        <Route index element={<Event />} />
        <Route path="create" element={<CreateEvent />} />
        <Route path="*" element={<NotFound />} />
        <Route path="account" element={<MyAccount/>}/>
      </Route>
    </Routes>

  )
}

export default App
