module sui_quest::scenerio_test;

use sui_quest::event_manager;
use sui_quest::event_register::{Self, EventRegister};
use sui_quest::participation_nft::ParticipationNft;
use sui_quest::winners_nft::WinnersNft;


#[test]
fun create_event_add_quest_and_interact_with_quest(){
    use sui::test_scenario;

    let event_owner = @0x100;
    let user = @0x1001;

    let mut scenerio = test_scenario::begin(event_owner);

    {
    let ctx = &mut tx_context::dummy();
    let register = event_register::create(ctx);
    transfer::public_transfer(register, event_owner);


    };

    scenerio.next_tx(event_owner);
    {

    let mut register = scenerio.take_from_sender<EventRegister>();

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
        i = i - 1;
        };

        event_manager::remove_quest(
            register.get_event(0),
            1,
            scenerio.ctx(),
        );

//start quest 1 in event
        event_manager::start_quest(
            register.get_event(0),
            1,
            100000000,
            scenerio.ctx()
        );
//start quest 2 in event
          event_manager::start_quest(
            register.get_event(0),
            2,
            100000000,
            scenerio.ctx()
        );
        assert!(register.get_event(0).quest_count() == 4);

        transfer::public_transfer(register, user);
    };

    scenerio.next_tx(user);
    let mut register = scenerio.take_from_sender<EventRegister>();

    {
        event_manager::submit_quest_without_nft(
            register.get_event(0),
            1,
            10000000,
            100000111,
            3,
            5,
            scenerio.ctx()
        );


    };

    scenerio.next_tx(user);
    {
        let mut nft = scenerio.take_from_sender<ParticipationNft>();
        event_manager::submit_quest_with_nft(
            &mut nft,
            register.get_event(0),
            2,
            100000,
            100022,
            5,
            5,
            scenerio.ctx(),
        );

        scenerio.return_to_sender(nft);
    };

       scenerio.next_tx(event_owner);
    {
      event_manager::distribute_reward(
        register.get_event(0),
        1,
        user,
        scenerio.ctx()
      );

    };

      scenerio.next_tx(user);
    {
         let mut nft = scenerio.take_from_sender<WinnersNft>();
         scenerio.return_to_sender(nft);
    };

    register.delete();
    scenerio.end();
}

