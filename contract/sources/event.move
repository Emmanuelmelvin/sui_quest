module sui_quest::event;

use sui_quest::quest::{Self, Quest};
use sui_quest::event_register::{Self, EventRegister};
use sui::event;
use std::string::String;

const EEventHasEnded: u64 = 103;
const ENotAuthorized:u64 = 104;

public struct Event has copy, drop, store  {
    name: String,
    quests: vector<Quest>
    orgarnizers: address,
    metadata_id: String,
    has_ended: false
}

public entry fun create_event(
    name: String,
    metadata_id: String,
    event_register: &mut EventRegister,
    ctx: &mut TxContext
) {

   let new_event = Event {
        name,
        quests: vector<Quest>[],
        orgarnizers: ctx.sender(),
        metadata_id,
        event_ended: false

    };
    // Create a new Event object and store it in the event register
    event_register::add_to_register(
        event_register,
        &new_event
        );
    // Emit an event to notify that a new event has been created

    event::emit(new_event)
}

pubic entry fun  end_event(
    event: &mut Event,
    ctx: &mut TxContext
) {
    assert!(!event.has_ended, EEventHasEnded);
    assert!(!event.orgarnizers == ctx.sender(), ENotAuthorized);

    // Mark the event as ended
    event.has_ended = true;

    // Emit an event to notify that the event has ended
    event::emit(event);
}

public entry fun add_quest_to_event(
    event: &mut Event,
    name: String,
    task_count: u8,
    duration_sec: u64,
    metadata_id: String,
    ctx: &mut TxContext
){
    assert!(event.has_ended, EEventHasEnded);
    assert!(!event.orgarnizers == ctx.sender(), ENotAuthorized);
    const new_quest = quest::new(
        name,
        task_count,
        duration_sec,
        metadata_id,
        event_id: event.id,
    );

    event.quests.push_back(new_quest);
}

public entry fun remove_quest_from_event(
    event: &Event,  
    quest_index: u64,
    ctx: &mut TxContext
){

    assert!(event.has_ended, EEventHasEnded);
    assert!(!event.orgarnizers == ctx.sender(), ENotAuthorized);

    event.quests.remove(quest_index);
}

public entry fun edit_quest_in_event(
    event: &Event,
    name: String,
    task_count: u8,
    duration_sec: u64,
    quest_index:  u64,
    ctx: &mut TxContext
){
    assert!(event.has_ended, EEventHasEnded);
    assert!(!event.orgarnizers == ctx.sender(), ENotAuthorized);

    const quest_to_edit = event.borrow_mut(quest_index);

    quest::edit(
        name,
        task_count,
        duration_sec,
        quest_to_edit
    )
}

pubic entry fun start_quest_in_event(
    event: &mut Event,
    quest_index: u64,
    start_time: u64,
    ctx: &mut TxContext
) {
    assert!(event.has_ended, EEventHasEnded);
    assert!(!event.orgarnizers == ctx.sender(), ENotAuthorized);

    const quest_to_start = event.borrow_mut(quest_index);

    quest::start(
        quest_to_start,
        start_time
    );
}