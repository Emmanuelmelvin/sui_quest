module sui_quest::event_manager;

use sui_quest::quest::{Self, Quest};
use sui_quest::event_register::{Self, EventRegister};
use sui_quest::completion_manager;
use sui_quest::event::{Self, Event};
use sui_quest::participation_nft::ParticipationNft;
use sui_quest::winners_nft;

use std::string::String;


const EEventHasEnded: u64 = 103;
const ENotAuthorized: u64 = 104;
const ETaskCountMismatch: u64 = 111;
const EEventHasNotEnded: u64 = 300;



public entry fun new(
    name: String,
    metadata_id: String,
    register: &mut EventRegister,
    ctx: &mut TxContext
) {
   
    register.add(
        event::new(
            name,
            metadata_id,
            ctx),
        );

}


public entry fun end(
    event: &mut Event,
    ctx: &mut TxContext
) {
    assert!(!event::has_ended(event), EEventHasEnded);
    assert!(event::organizers(event) == tx_context::sender(ctx), ENotAuthorized);
    event.end();
    // event::emit(*event); // REMOVE: Event does not have copy+drop
}
 
public entry fun delete(
    event: Event,
    ctx: &mut TxContext
) {
       event.delete();
}

public entry fun add_quest(
    event: &mut Event,
    name: String,
    task_count: u8,
    duration_sec: u64,
    metadata_id: String,
    ctx: &mut TxContext
) {
    let new_quest = quest::new(
        name,
        task_count,
        duration_sec,
        metadata_id,
    );
    assert!(!event::has_ended(event), EEventHasEnded);
    assert!(event::organizers(event) == tx_context::sender(ctx), ENotAuthorized);
    event.add_quest(new_quest);
   }


public entry fun remove_quest(
    event: &mut Event,
    quest_index: u64,
    ctx: &mut TxContext
) {
    assert!(!event::has_ended(event), EEventHasEnded);
    assert!(event::organizers(event) == tx_context::sender(ctx), ENotAuthorized);
    
    event.remove_quest(quest_index);
   }

public entry fun edit_quest(
    event: &mut Event,
    name: String,
    task_count: u8,
    duration_sec: u64,
    quest_index: u64,
    ctx: &mut TxContext
) {
    assert!(!event::has_ended(event), EEventHasEnded);
    assert!(event::organizers(event) == tx_context::sender(ctx), ENotAuthorized);
    event.edit_quest(
       name,
       task_count,
       duration_sec,
       quest_index, 
    );
}

public entry fun start_quest(
    event: &mut Event,
    quest_index: u64,
    start_time: u64,
    ctx: &mut TxContext
) {
    assert!(!event::has_ended(event), EEventHasEnded);
    assert!(event::organizers(event) == tx_context::sender(ctx), ENotAuthorized);
    event.start_quest(
        quest_index,
        start_time
    );
}

//user functions
public entry fun submit_quest (
    has_participation_nft: bool,
    participation_nft: &mut ParticipationNft,
    event: &mut Event,
    quest_index: u64,
    start_time:  u64,
    end_time: u64,
    correct_answers: u8,
    total_questions: u8,
    ctx: &mut TxContext,
){
    assert!(!event::has_ended(event), EEventHasEnded);
    let mut quest = event.get_quest(quest_index);
    assert!(quest.task_count() == total_questions, );

    quest::enter(
        &mut quest,
        ctx,
    );

    if(!has_participation_nft){
    completion_manager::new(
        start_time,
        correct_answers,
        total_questions,
        quest_index,
        end_time,
        *event.get_name(),
        *quest.get_name(),
        ctx,
    );
    } else {
        completion_manager::edit(
            participation_nft,
            start_time,
            correct_answers,
            total_questions,
            quest_index,
            end_time,
            *event.get_name(),
            *quest.get_name(),
        );
    }

}

public entry fun distribute_reward(
    event: &mut Event,
    rank: u64,
    address: address,
    ctx: &mut TxContext
) {
    assert!(event::has_ended(event), EEventHasNotEnded);
    assert!(event::organizers(event) == tx_context::sender(ctx), ENotAuthorized);

    winners_nft::mint_to_sender(
        address,
        rank,
        ctx
    );

}


// #[test_only]
// public fun get_quest_from_events(
//     event: &Event
// ): &vector<Quest> {
//     &event.quests
// }

// #[test_only]
// public fun get_quest_count_in_event(
//    event: &Event
// ): u64{
//     event.quests.length()
// }

// #[test_only]
// public fun check_if_quest_has_started(
//     event: &Event,
//     quest_index:u64
// ):  bool {
//     if(event.quest.check_if_quest_has_started(quest_index)){
//         true
//     }else{
//         false
//     }
// }