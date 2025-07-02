
const NavBar = () => {
  return (
    <div>
        <nav className="navbar">
            <ul className="nav-links">
            <li><a href="/">Home</a></li>
            <li><a href="/events">Events</a></li>
            <li><a href="/create-event">Create Event</a></li>
            </ul>
        </nav>
    </div>
  );
}

export default NavBar