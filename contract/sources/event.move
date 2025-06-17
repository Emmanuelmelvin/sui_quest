module sui_quest::event;

use sui_quest::quest::{Self, Quest};
use sui_quest::event_register;
use sui_quest::event_register::EventRegister;
use sui::object::UID;
use sui::event;
use sui::tx_context::TxContext;
use std::string::String;

const EEventHasEnded: u64 = 103;
const ENotAuthorized: u64 = 104;

public struct Event has store, key {
    id: UID,
    name: String,
    quests: vector<Quest>,
    orgarnizers: address,
    metadata_id: String,
    has_ended: bool
}

public fun id(event: &Event): &UID {
    &event.id
}

public entry fun new(
    name: String,
    metadata_id: String,
    event_register: &mut EventRegister,
    ctx: &mut TxContext
) {
    let new_event = Event {
        id: object::new(ctx),
        name: name,
        quests: vector::empty<Quest>(),
        orgarnizers: tx_context::sender(ctx),
        metadata_id: metadata_id,
        has_ended: false
    };

    let Event {id, name: _, quests: _, orgarnizers: _, metadata_id: _, has_ended: _} = new_event;
    event_register::add_to_register(event_register, id);
    // event::emit(new_event); // REMOVE: Event does not have copy+drop
}


public entry fun end_event(
    event: &mut Event,
    ctx: &mut TxContext
) {
    assert!(!event.has_ended, EEventHasEnded);
    assert!(event.orgarnizers == tx_context::sender(ctx), ENotAuthorized);
    event.has_ended = true;
    // event::emit(*event); // REMOVE: Event does not have copy+drop
}

public entry fun delete_event(
    event_register: &mut EventRegister,
    event: &Event,
    ctx: &mut TxContext
) {
    assert!(!event.has_ended, EEventHasEnded);
    assert!(event.orgarnizers == tx_context::sender(ctx), ENotAuthorized);
    event_register::remove_from_register(event_register, &event.id);
    // Optionally emit a deletion event here if needed
}

public entry fun add_quest_to_event(
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
    assert!(!event.has_ended, EEventHasEnded);
    assert!(event.orgarnizers == tx_context::sender(ctx), ENotAuthorized);
    vector::push_back(&mut event.quests, new_quest);
}


public entry fun remove_quest_from_event(
    event: &mut Event,
    quest_index: u64,
    ctx: &mut TxContext
) {
    assert!(!event.has_ended, EEventHasEnded);
    assert!(event.orgarnizers == tx_context::sender(ctx), ENotAuthorized);
    let removed_quest = vector::remove(&mut event.quests, quest_index);
    quest::destroy(removed_quest); // Explicitly destroy removed quest
}

public entry fun edit_quest_in_event(
    event: &mut Event,
    name: String,
    task_count: u8,
    duration_sec: u64,
    quest_index: u64,
    ctx: &mut TxContext
) {
    assert!(!event.has_ended, EEventHasEnded);
    assert!(event.orgarnizers == tx_context::sender(ctx), ENotAuthorized);
    let quest_to_edit = vector::borrow_mut(&mut event.quests, quest_index);
    quest::edit(
        name,
        task_count,
        duration_sec,
        quest_to_edit
    );
}

public entry fun start_quest_in_event(
    event: &mut Event,
    quest_index: u64,
    start_time: u64,
    ctx: &mut TxContext
) {
    assert!(!event.has_ended, EEventHasEnded);
    assert!(event.orgarnizers == tx_context::sender(ctx), ENotAuthorized);
    let quest_to_start = vector::borrow_mut(&mut event.quests, quest_index);
    quest::start(
        quest_to_start,
        start_time
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
public fun get_quest_count_in_event(
   event: &Event
): u64{
    event.quests.length()
}