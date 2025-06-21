module sui_quest::event_register;

use sui_quest::event::Event;

public struct EventRegister has key, store {
    id: UID,
    events: vector<Event>,
    count: u64,
}

public struct EVENT_REGISTER has drop {}

fun init(otw: EVENT_REGISTER, ctx: &mut TxContext) {
    transfer::public_share_object(create(ctx));

}

fun create(ctx: &mut TxContext
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


#[test_only]
public fun create_mock_register(ctx: &mut TxContext): EventRegister<T> {
    EventRegister{
        id: object::new(ctx),
        events: vector<Event>[],
        count: 0
    }
}
