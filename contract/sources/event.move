module sui_quest::event;

use sui_quest::quest::{Self, Quest};

use std::string::String;


public struct Event has store, key {
    id: UID,
    name: String,
    quests: vector<Quest>,
    organizers: address,
    metadata_id: String,
    has_ended: bool
}

public fun id(event: &Event): &UID {
    &event.id
}

public(package) fun new(
    name: String,
    metadata_id: String,
    ctx: &mut TxContext,
    ): Event{
     Event {
        id: object::new(ctx),
        name: name,
        quests: vector::empty<Quest>(),
        organizers: tx_context::sender(ctx),
        metadata_id: metadata_id,
        has_ended: false
    }
}

public (package) fun end(
    event: &mut Event
){
    event.has_ended = true;
}

public (package) fun quests(
    event: &mut Event
): vector<Quest>{
    event.quests
}

public (package) fun get_quest(
    event:  &Event,
    quest_index: u64,
): Quest{
    event.quests[quest_index]
}

public (package) fun get_name(
    event: &Event
): &String{
    &event.name
}

public (package) fun has_ended(
    event: &mut Event
): bool {
    if(event.has_ended){
        true
    }else {
        false
    }
}

public (package) fun organizers(
    event: &mut Event
): address {
    event.organizers
}

public(package) fun delete(
    event: Event
){
    let Event {
    id, 
    name: _, 
    quests: _, 
    organizers: _, 
    metadata_id: _, 
    has_ended: _
    } = event;

    id.delete();
}

public (package) fun add_quest(
    event: &mut Event,
    quest: Quest
){
     vector::push_back(&mut event.quests, quest);

} 

public (package) fun remove_quest(
    event: &mut Event,
    quest_index: u64
){
    let removed_quest = vector::remove(&mut event.quests, quest_index);
    quest::destroy(removed_quest); // Explicitly destroy removed quest

}

public (package) fun edit_quest(
    event: &mut Event,
    name: String,
    task_count: u8,
    duration_sec: u64,
    quest_index: u64,
){
    let quest_to_edit = vector::borrow_mut(&mut event.quests, quest_index);
    quest::edit(
        name,
        task_count,
        duration_sec,
        quest_to_edit
    );
}

public (package) fun start_quest(
    event: &mut Event,
    quest_index: u64,
    start_time: u64
){
    let quest_to_start = vector::borrow_mut(&mut event.quests, quest_index);
    quest::start(
        quest_to_start,
        start_time
    );
}