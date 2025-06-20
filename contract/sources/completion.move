module sui_quest::completion;

use sui_quest::quest_progress::{Self, QuestProgress};

use sui::table::{Self, Table};

public struct Completion has key {
    id: UID,
    start_time: u64,
    end_time: u64,
    quest: Table<u64, QuestProgress>,
}


public (package) fun new(
    start_time: u64,
    correct_answers: u8,
    total_questions: u8,
    quest_index: u64,
    end_time: u64,
    ctx: &mut TxContext
) {
    let mut quest_bag = table::new<u64, QuestProgress>(ctx);

    quest_bag.add(
        quest_index,
        quest_progress::new(
            correct_answers,
            total_questions,
        )
    );

    let new_quest_completion = Completion{
        id: object::new(ctx),
        start_time,
        end_time,
        quest: quest_bag,
    };

    transfer::transfer(new_quest_completion, ctx.sender());

}


