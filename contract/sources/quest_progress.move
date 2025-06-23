module sui_quest::quest_progress;

public struct QuestProgress has store, drop {
    start_time:u64,
    end_time: u64,
    correct_answers: u8,
    total_questions:u8,
    completed: bool
}
 
public (package) fun new (
    start_time: u64,
    end_time: u64,
    correct_answers: u8,
    total_questions: u8
): QuestProgress {
    QuestProgress {
        start_time,
        end_time,
        correct_answers,
        total_questions,
        completed: correct_answers == total_questions,
    }
}
