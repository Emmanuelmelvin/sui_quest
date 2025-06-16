module sui_quest::event;

use sui_quest::quest::{Self, Quest};
use sui::event;

const EEventHasEnded: u64 = 103;
const ENotAuthorized:u64 = 104;

public Struct Event has copy, drop, store  {
    name: String,
    quests: vector<Quest>
    orgarnizers: address,
    metadata_id: String,
    has_ended: false
}

public entry fun create_event(
    name: String,
    metadata_id,
    ctx: &mut TxContext
): Event {

   let new_event = Event {
        name,
        quests: vector<Quest>::empty(),
        orgarnizers: ctx.sender(),
        metadata_id,
        event_ended: false

    };

    event::emit(
        &new_event,
        ctx
    )
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

public entry fun edit_quest(
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