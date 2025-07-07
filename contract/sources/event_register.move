module sui_quest::event_register;

use sui_quest::event::{Self, Event};
use sui::event as push;

public struct EventRegister has key, store {
    id: UID,
    events: vector<EventMeta>,
    count: u64,
}

public struct EventMeta has store, drop {
    id: ID,
    owner: address
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
        events: vector<EventMeta>[],
        count: 0,
    }

}

public (package) fun add(
    register: &mut EventRegister,
    event: Event,
) {
    vector::push_back(&mut register.events,
        EventMeta {
            id: object::id(&event),
            owner: event.owner()
        }
     );
    register.count = register.count + 1;
    transfer::public_share_object(event);

}

public (package) fun get_event_with_index (
    register: &mut EventRegister,
    index: u64
): &mut EventMeta {
    &mut register.events[index]
}


// public (package) fun get_event_with_address(
//     register: &mut EventRegister,
//     event_id: UID
// ): &mut Event {
//     let events = &mut register.events;
//     let len = vector::length(events);
//     let mut i = 0;
//     while (i < len) {
//         let event_ref = vector::borrow_mut(events, i);
//         if (event_ref.id() == event_id) {
//             return event_ref;
//         };
//         i = i + 1;
//     };
//    }


public fun delete(
    register: EventRegister
){
    let EventRegister { id, events:  _ , count: _} = register;
    id.delete();
}