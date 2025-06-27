module sui_quest::event_register;

use sui_quest::event::{Self, Event};

public struct EventRegister has key, store {
    id: UID,
    events: vector<Event>,
    count: u64,
}

public struct EVENT_REGISTER has drop {}

fun init(otw: EVENT_REGISTER, ctx: &mut TxContext) {
    transfer::public_share_object(create(ctx));

}

public (package) fun create(ctx: &mut TxContext
):EventRegister {
    EventRegister {
        id: object::new(ctx),
        events: vector<Event>[],
        count: 0,
    }
}

public (package) fun add(
    register: &mut EventRegister,
    event: Event,
) {
    vector::push_back(&mut register.events, event);
    register.count = register.count + 1;
}

public (package) fun get_event (
    register: &mut EventRegister,
    index: u64
): &mut Event {
    &mut register.events[index]
}


public fun delete(
    register: EventRegister
){
    let EventRegister { id, events , count: _} = register;
    id.delete();
}