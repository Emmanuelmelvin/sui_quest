
import { useSuiClient } from "@mysten/dapp-kit";


export const formatRegisterObject = async (register) => {
    const client = useSuiClient();
    const events = register.data.content.fields.events;

    const fetchedEvents = await Promise.all(
        events.map(async (event) => {
            try {
                const result = await client.getObject({
                    id: event.fields.id,
                    options: {
                        showContent: true,
                        showOwner: true,
                        showType: true,
                        showPreviousTransaction: false,
                        showDisplay: false,
                        showStorageRebate: false,
                    },
                });
                return result;
            } catch (err) {
                console.error("Failed to fetch event", event.fields.id, err);
                return null;
            }
        })
    );
    return fetchedEvents
};


