module sui_quest::scenerio_test;

use sui_quest::event_manager;
use sui_quest::event_register::{Self, EventRegister};


#[test]
fun create_event_add_quest_and_interact_with_quest(){
    use sui::test_scenario;

    let event_owner = @0x100;
    let user = @0x1001;
    let register_store = @0x111;

    let mut scenerio = test_scenario::begin(event_owner);
    let mut store = test_scenario::begin(register_store);

    {

    let ctx = &mut tx_context::dummy();
    let register = event_register::create(ctx);
    transfer::public_transfer(register, register_store);

    };

    scenerio.next_tx(event_owner);
    {

        let mut register = store.take_from_sender<EventRegister>();
        event_manager::new(
            b"".to_string(),
            b"".to_string(),
            &mut register,
            scenerio.ctx()
        );

        let mut i = 5;
        while(i > 0){
        event_manager::add_quest(
            register.get_event(0),
            b"New event".to_string(),
            5,
            1000000,
            b"".to_string(),
            scenerio.ctx()
        );
        i = i + 1;
        };

    register.delete();
    };
    scenerio.end();
    store.end();
}

