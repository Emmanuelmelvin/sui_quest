#[test_only]
module sui_quest::sui_event_test;

use sui_quest::event;
use sui_quest::event::Event;
use sui_quest::event_register;
use sui_quest::event_register::EventRegister;
use sui_quest::quest::Quest;

const EEventRegisterNotFound: u64 = 110;

#[test_only]
fun create_register(ctx: &mut tx_context::TxContext): EventRegister {
    event_register::create_mock_register(ctx)
}

#[test_only]
fun create_event(ctx: &mut tx_context::TxContext): Event {
    // Create a mock event with an empty name and metadata ID
    event::create_mock_event(
        b"".to_string(),
        b"".to_string(),
        ctx,
    )
}

#[test]
fun manipulate_event() {
    let mut ctx = &mut tx_context::dummy();
    let mut event = create_event(ctx);

    event::add_quest_to_event(
        &mut event,
        b"".to_string(),
        5,
        100001,
        b"".to_string(),
        ctx
    );

    let mut register = create_register(ctx);
    // Use accessor to get event id instead of destructuring
    let event_id = event::id(&event);

    event_register::add_to_register(&mut register, event_id);

    event::end_event(
        &mut event,
        ctx
    );

    // Consume register to avoid unused value error (no drop ability)
    event_register::destroy(register);
}

