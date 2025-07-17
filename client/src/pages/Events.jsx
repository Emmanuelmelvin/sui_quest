 import { ConnectButton } from "@mysten/dapp-kit";
 import { useSuiClient, useSuiClientContext  } from "@mysten/dapp-kit";
import '../styles/event.css'
import { useEffect } from "react";


 const Events = () => {

  const client = useSuiClient()
  const ctx = useSuiClientContext()

  useEffect(()=> {
    console.log(client)
  })

  return (
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
  );
};

export default Events;
