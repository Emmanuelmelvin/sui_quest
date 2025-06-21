module sui_quest::completion;

use sui_quest::quest_progress::{Self, QuestProgress};
use std::ascii::string;

use std::string::String;
use sui::table::{Self, Table};

use sui::url;

public struct Completion has key, store {
    id: UID,
    start_time: u64,
    end_time: u64,
    event_name: String,
    quest: Table<u64, QuestProgress>,
}


public (package) fun create(
    start_time: u64,
    correct_answers: u8,
    total_questions: u8,
    quest_index: u64,
    end_time: u64,
    event_name: String,
    ctx: &mut TxContext
): Completion {

    let mut quest_bag = table::new<u64, QuestProgress>(ctx);

    quest_bag.add(
        quest_index,
        quest_progress::new(
            correct_answers,
            total_questions,
        )
    );

     Completion{
        id: object::new(ctx),
        start_time,
        end_time,
        event_name,
        quest: quest_bag,
    }
    }


