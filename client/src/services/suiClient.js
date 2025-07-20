import {
    useSuiClientQuery,
    useCurrentAccount
} from '@mysten/dapp-kit';

import { EVENT_REGISTER_OBJECT_ID } from '../../../constant.js'
import { formatRegisterObject } from './eventServices.js';
const getCurrentAccount = () => {
    return useCurrentAccount();
}

export const useUserNFTs = () => {
    const account = getCurrentAccount()
    if (account) {
        const { data, isPending, isError, error, refetch } = useSuiClientQuery(
            'getOwnedObjects',
            { owner: account.address },
            {
                gcTime: 10000,
            },
        );
        return {
            requestSent: true,
            message: "Request Successful",
            responseObject: {
                data,
                isPending,
                isError,
                error,
                refetch
            }
        };
    }
    return {
        requestSent: false,
        message: "No account found!",
        responseObject: null
    };
}

export const useEventRegister = () => {
    const account = useCurrentAccount();
    const query = useSuiClientQuery(
        'getObject',
        {
            id: EVENT_REGISTER_OBJECT_ID,
            options: {
                showContent: true,
                showOwner: true,
                showType: true,
                showPreviousTransaction: false,
                showDisplay: false,
                showStorageRebate: false,
            },
        }
    );

    if (account) {
        const { data, isPending, isError, error, refetch } = query;
       const eventsFromRegister = formatRegisterObject(data);
        return {
            requestSent: true,
            message: "Request Successful",
            responseObject: {
                data: eventsFromRegister,
                isPending,
                isError,
                error,
                refetch
            }
        };
    }
    return {
        requestSent: false,
        message: "No account found!",
        responseObject: null
    };
}
