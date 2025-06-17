module sui_quest::event_register;

use sui::object;
use sui::object::UID;

public struct EventRegister has key {
    id: UID,
    events: vector<UID>, // Store only event IDs
    count: u64,
}

public struct EVENT_REGISTER has drop {}

fun init(otw: EVENT_REGISTER, ctx: &mut TxContext) {
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


#[test_only]
public fun create_mock_register(ctx: &mut TxContext): EventRegister {
    EventRegister{
        id: object::new(ctx),
        events: vector[],
        count: 0
    }
}

