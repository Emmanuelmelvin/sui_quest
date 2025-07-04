module sui_quest::event_register;

use sui_quest::event::{Self, Event};
use sui::event as push;

public struct EventRegister has key, store {
    id: UID,
    events: vector<Event>,
    count: u64,
}

public struct EventRegisterCreationEvent has drop, copy {
    id: ID,
    creator: address,
}

public struct EVENT_REGISTER has drop {}

fun init(otw: EVENT_REGISTER, ctx: &mut TxContext) {
    let event_register = create(ctx);

    push::emit(
        EventRegisterCreationEvent {
            id: object::id(&event_register),
            creator: ctx.sender(),
        }
    );
    transfer::public_share_object(event_register);

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
    let EventRegister { id, mut events , count: _} = register;

    while(!events.is_empty()){
        let event = events.pop_back();
        event.delete();
    };

    events.destroy_empty();
    id.delete();
}