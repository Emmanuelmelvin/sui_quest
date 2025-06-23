module sui_quest::completion;

use sui_quest::quest_progress::{Self, QuestProgress};
use std::ascii::string;

use std::string::String;
use sui::table::{Self, Table};

use sui::url;

const EQuestAttemptedAlready: u64 = 210;

public struct Completion has key, store {
    id: UID,
    event_name: String,
    quests: Table<u64, QuestProgress>,
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
            start_time,
            end_time,
            correct_answers,
            total_questions,
        )
    );

     Completion{
        id: object::new(ctx),
        event_name,
        quests: quest_bag,
    }
    }

    public (package) fun add(
        completion: &mut Completion,
         start_time: u64,
         correct_answers: u8,
         total_questions: u8,
         quest_index: u64,
         end_time: u64,
         event_name: String,
    ){
    
    assert!(completion.quest.contains(quest_index), EQuestAttemptedAlready);

    completion.quests.add(
        quest_index,
        quest_progress::new(
            start_time,
            end_time,
            correct_answers,
            total_questions,
        )
    );
    }


