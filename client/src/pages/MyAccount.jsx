import { useUserNFTs } from "../services/suiClient";


const MyAccount = () => {
	const ctx = useUserNFTs();

	if(ctx.requestSent){
		const { isPending, isError, error, data} = ctx.responseObject;
		if (isPending) {
			return <div>Loading...</div>;
		}
		if (isError) {
			return <div>Error: {error.message}</div>;
		}
		return <pre>{JSON.stringify(data, null, 2)}</pre>;
	}

	return <div>{ctx.message}</div>
}

export default MyAccount