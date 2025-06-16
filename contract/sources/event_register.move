module sui_quest::event_register;

use sui::object;
use sui::object::UID;

const EEventNotFound: u64 = 105;

public struct EventRegister has key {
    id: UID,
    events: vector<UID>, // Store only event IDs
    count: u64,
}

fun init(ctx: &mut TxContext) {
    let event_register = EventRegister {
        id: object::new(ctx),
        events: vector[],
        count: 0,
    };
    transfer::share_object(event_register);
}

public (package) fun add_to_register(
    register: &mut EventRegister,
    event_id: UID,
) {
    vector::push_back(&mut register.events, event_id);
    register.count = register.count + 1;
}

public (package) fun remove_from_register(
    register: &mut EventRegister,
    event_id: &UID,
) {
    let len = vector::length(&register.events);
    let mut i = 0;
    while (i < len) {
        let id_ref = vector::borrow(&register.events, i);
        if (id_ref == event_id) {
            let removed = vector::remove(&mut register.events, i);
            object::delete(removed);
            register.count = register.count - 1;
        };
        i = i + 1;
    };
    abort EEventNotFound;
}
