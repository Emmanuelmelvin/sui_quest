module sui_quest::event_manager;

use sui_quest::quest::{Self, Quest};
use sui_quest::event_register::{Self, EventRegister};
use sui_quest::completion::{Self,Completion};
use sui_quest::event::{Self, Event};

use std::string::String;


const EEventHasEnded: u64 = 103;
const ENotAuthorized: u64 = 104;



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
public entry fun enter_quest (
    event: &mut Event,
    quest_index: u64,
    start_time:  u64,
    ctx: &mut TxContext,
){
    assert!(!event::has_ended(event), EEventHasEnded);
    
    let mut quest = event.get_quest(quest_index);

    quest::enter(
        &mut quest,
        ctx,
    );

    completion::new(
        start_time,
        ctx,
    );

}


#[test_only]
public fun create_mock_event(
    name: String,
    metadata_id: String,
    ctx: &mut TxContext
): Event {
    Event {
        id: object::new(ctx),
        name: name,
        quests: vector::empty<Quest>(),
        orgarnizers: tx_context::sender(ctx),
        metadata_id: metadata_id,
        has_ended: false
    }
}


#[test_only]
public fun get_quest_from_events(
    event: &Event
): &vector<Quest> {
    &event.quests
}

#[test_only]
public fun get_quest_count_in_event(
   event: &Event
): u64{
    event.quests.length()
}

#[test_only]
public fun check_if_quest_has_started(
    event: &Event,
    quest_index:u64
):  bool {
    if(quest::check_if_quest_has_started(&event.quests[quest_index])){
        true
    }else{
        false
    }
}