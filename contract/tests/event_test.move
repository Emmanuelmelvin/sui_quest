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
fun create_event_and_add_quest(){
    let mut ctx = &mut tx_context::dummy();
    //let mut register = create_register(ctx);

    let mut event_test = create_event(ctx);

    event::add_quest(
        &mut event_test,
        b"".to_string(),
        5,
        1000001,
        b"".to_string(),
        ctx,
    );

    let _: &vector<Quest> =  event::get_quest_from_events(&event_test);

    event::delete(
        event_test,
        ctx,
    );

}

#[test]
fun create_event_and_edit_quest(){
    let mut ctx = &mut tx_context::dummy();

    let mut event_test = create_event(ctx);
       event::add_quest(
        &mut event_test,
        b"".to_string(),
        5,
        1000001,
        b"".to_string(),
        ctx,
    );

    event::start_quest(
        &mut event_test,
        0,
        00000000001,
        ctx,
    );

    assert!(event::check_if_quest_has_started(&event_test, 0));

      event::delete(
        event_test,
        ctx,
    );
}


