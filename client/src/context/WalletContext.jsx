
import React, { createContext, useContext } from 'react';
import { useWallet } from '@suiet/wallet-kit';

const WalletContext = createContext();

export const WalletProvider = ({ children }) => {
  const {
    connected,
    address,
    signAndExecuteTransactionBlock,
    connect,
    disconnect,
    select,
    wallet,
  } = useWallet();

  const isConnected = connected && !!address;

  return (
    <WalletContext.Provider
      value={{
        isConnected,
        address,
        signAndExecuteTransactionBlock,
        connect,
        disconnect,
        select,
        wallet,
      }}
    >
      {children}
    </WalletContext.Provider>
  );
};

// Custom hook for components to consume
export const useWalletContext = () => useContext(WalletContext);
