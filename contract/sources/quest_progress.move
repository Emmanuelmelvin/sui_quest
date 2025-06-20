module sui_quest::quest_progress;

public struct QuestProgress has store, drop {
    quest_index: u64,
    attempts: u8,
    correct_answers: u8,
    total_questions:u8,
    completed: bool
}
 
