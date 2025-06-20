module sui_quest::quest_progress;

public struct QuestProgress has store, drop {
    correct_answers: u8,
    total_questions:u8,
    completed: bool
}
 
public (package) fun new (
    correct_answers: u8,
    total_questions: u8
): QuestProgress {
    QuestProgress {
        correct_answers,
        total_questions,
        completed: correct_answers == total_questions,
    }
}
