import { useState } from "react";

const NavBar = () => {
  const [search, setSearch] = useState("");

  const handleSearch = (e) => {
    e.preventDefault();

  };

  return (
    <nav className="navbar">
      <div className="navbar-container">
        <div className="navbar-logo">
          <a href="/">SuiQuest</a>
        </div>
        <ul className="nav-links">
          <li><a href="/">Home</a></li>
          <li><a href="/events">Events</a></li>
          <li><a href="/create-event">Create Event</a></li>
        </ul>
        <form className="navbar-search" onSubmit={handleSearch}>
          <input
            type="text"
            placeholder="Search events..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
          <button type="submit">🔍</button>
        </form>
      </div>
    </nav>
  );
};

export default NavBar;