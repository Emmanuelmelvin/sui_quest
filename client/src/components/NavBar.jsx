import { useState } from "react";
import { Link, useLocation } from "react-router-dom";
import {
  ConnectButton,
  useWallet,
  addressEllipsis,
} from "@suiet/wallet-kit";
import '../styles/event.css';

const NavBar = () => {
  const location = useLocation();
  const [search, setSearch] = useState("");
    const wallet = useWallet();

  const handleSearch = (e) => {
    e.preventDefault();
    // Implement search logic here if needed
  };

  return (
    <nav className="navbar">
        <div className="navbar-logo">
          <Link to="/">SuiQuest</Link>
        </div>

        <form className="navbar-search" onSubmit={handleSearch}>
          <input
            type="text"
            placeholder="Search events..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
          <button type="submit">Search</button>
        </form>
        <div className="nav-links"> 
            <Link
              to="/"
              className={location.pathname === "/" ? "active" : ""}
            >
              Explore...
            </Link>


            <Link
              to="/create"
              className={location.pathname === "/create" ? "active" : ""}
            >
              Create Event
            </Link>
          </div>
      <ConnectButton/>
    </nav>
  );
};

export default NavBar;