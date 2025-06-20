module sui_quest::completion;

use sui_quest::quest_progress::QuestProgress;

public struct Completion has key {
    id: UID,
    start_time: u64,
    end_time: u64,
    quest: vector<QuestProgress>
}


public (package) fun new(
    start_time: u64,
    ctx: &mut TxContext
) {
    let new_quest_completion = Completion{
        id: object::new(ctx),
        start_time,
        end_time: 0,
        quest: vector<QuestProgress>[],
    };

    transfer::transfer(new_quest_completion, ctx.sender());

}
