module sui_quest::completion;

use sui_quest::quest_progress::QuestProgress;


public struct Completion  has key {
    id: UID,
    event_id: ID,
    user: address,
    start_time: u64,
    end_time: u64,
    quest: vector<QuestProgress>
}

