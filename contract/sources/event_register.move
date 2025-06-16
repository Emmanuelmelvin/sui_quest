module sui_quest::event_register;

use sui_quest::event::Event;

const EEventNotFound: u64 = 105;

public struct EventRegister has key {
    id: UID,
    events: vector<Event>,
    count: u64
}


/// function runs just once to create an EventRegister to store all Events.
fun init (ctx: &mut TxContext){
    let event_register: EventRegister = EventRegister {
        id: object::new(ctx),
        events: vector<Event>[],
        count: 0
    }

    transfer::share_object(event_register);
}

public (package) fun add_to_register(
    register: &mut EventRegister,
    event: &Event
    ){
        vector::push_back(&mut register.events, event);
        register.count = register.count + 1;
}

public (package) fun remove_from_register(
    register: &mut EventRegister,
    event_index: u64
) {
    vector::remove(&mut register.events, event_index);
    register.count = register.count - 1;
}

public (package) fun get_event_from_register(
    register: &EventRegister,
    event_index: u64
): &Event {
    if (event_index >= register.count) {
        abort EEventNotFound;
    };
    vector::borrow(&register.events, event_index)
}