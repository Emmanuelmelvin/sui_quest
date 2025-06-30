import {
  ConnectButton,
  useWallet,
  addressEllipsis,
} from "@suiet/wallet-kit";
import '../styles/event.css'; // fixed filename


const mockEvents = [
  {
    id: 1,
    name: "SuiQuest Hackathon",
    description: "A beginner-friendly hackathon to explore blockchain.",
    quests: 5,
    participants: 120,
    nftReward: "Hackathon NFT",
  },
  {
    id: 2,
    name: "NFT Art Challenge",
    description: "Create and mint your first NFT artwork.",
    quests: 3,
    participants: 80,
    nftReward: "Art Creator NFT",
  },
  // ...add more mock events as needed...
];

const Events = () => {
  const wallet = useWallet();

  return (
    <div className="App">
      <header>
        <h1>SuiQuest Events</h1>
        <div>
          <ConnectButton />
          {wallet.status === "connected" && (
            <div className="wallet-info">
              {addressEllipsis(wallet.account?.address)}
            </div>
          )}
        </div>
      </header>

      <main className="events-main">
        <section className="events-section-header">
          <h2>My Events</h2>
          <button className="create-event-btn">
            + Create Event
          </button>
        </section>

        <div className="events-grid">
          {mockEvents.map(event => (
            <div key={event.id} className="event-card">
              <div>
                <h3>{event.name}</h3>
                <p>{event.description}</p>
              </div>
              <div className="event-card-footer">
                <div className="event-meta">
                  <span>{event.quests} Quests</span>
                  <span>{event.participants} Participants</span>
                </div>
                <div className="nft-reward">
                  {event.nftReward}
                </div>
              </div>
            </div>
          ))}
        </div>
      </main>
    </div>
  );
};

export default Events