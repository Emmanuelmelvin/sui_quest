import { 
  ConnectButton, 
  useConnectWallet, 
  useWallets,
  useAccounts,
  useSuiClientContext
} from "@mysten/dapp-kit";
import { useNavigate } from "react-router-dom";
import '../styles/event.css'

import { useEventRegister } from "../services/suiClient";
import { useEffect } from "react";
import RegisterDisplay from "../components/RegisterDisplay";


 const Events = () => {
  
  const accounts = useAccounts();
  const wallets = useWallets();
	const { mutate: connect } = useConnectWallet();
  const ctx = useSuiClientContext();

  const register = useEventRegister();

  const navigate = useNavigate()

  useEffect(()=> {
    console.log(register)
  },[ctx])


  return (
    <div>
    <div className="wrapper">
    <div>
      Connect your wallet
    </div>
    <ConnectButton/>
    <div>
      <div>
			{Object.keys(ctx.networks).map((network) => (
				<button key={network} onClick={() => ctx.selectNetwork(network)}>
					{`select ${network}`}
				</button>
			))}
		</div>
    </div>
    </div>
			<h2>Available accounts:</h2>
			{accounts.length === 0 && <div>No accounts detected</div>}
			<ul>
				{accounts.map((account) => (
					<li key={account.address}>{account.address}</li>
				))}
			</ul>
      <h3>Connect to these available wallets</h3>
				{wallets.map((wallet) => (
					<li key={wallet.name}>
						<button
							onClick={() => {
								connect(
									{ wallet },
									{
										onSuccess: () => console.log('connected'),
									},
								);
							}}
						>
							Connect to {wallet.name}
						</button>
					</li>
				))}
        <br/>
        <h3>Event Register</h3>
        <RegisterDisplay register={register} />
        <br/>
        <div>
          Go to my Accounts
          <br/>
          <button
          onClick={()=>{navigate('account')}}
          >
            My Accounts
          </button>
          <button
          onClick={()=>{navigate('create')}}>
            Create Event
            </button>
          </div>
    </div>
  );
};

export default Events;
