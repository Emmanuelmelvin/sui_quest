/*
/// Module: sui_quest
module sui_quest::sui_quest;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

module sui_quest::quest {
   
    use std::string::String;

    //constants used for error handling
    const EQuestHasStarted: u64 = 100;
    const EQuestNotFound: u64 = 101;
    const EQuestHasNoValidTask: u64 = 102;

    public struct Quest has store {
        name: String,
        task_count: u8,
        start_time: u64,
        duration_sec: u64,
        is_started: bool,
        metadata_id: String,
        event_id: UID,
        users_entered: vector<address>,
        users_winners: vector<address>
    }

    public (package) fun new(
        name: String,
        task_count: u8,
        duration_sec: u64,
        metadata_id: String,
        event_id
    ): Quest {
        // Ensure that the task count is within a reasonable range
        assert!(task_count > 0 && task_count <= 10, EQuestHasNoValidTask);
        // Ensure that the duration is positive
        assert!(duration_sec > 0, EQuestNotFound);

        // Create a new Quest object
         Quest {
            name,
            event_id,
            task_count,
            start_time: 0,
            duration_sec,
            is_started: false,
            metadata_id,
            users_entered: vector::empty(),
            users_winners: vector::empty()
        }
    }

    public (package) fun start(
        quest: &mut Quest,
        start_time: u64
    ) {
        assert!(!quest.is_started, EQuestHasStarted);
        quest.start_time = start_time;
        // Set the start time of the quest to the current time
        // This is done using the clock::now function, which returns the current time in seconds.
        quest.is_started = true;
    }

    public (package) fun edit(
        name: String,
        task_count: u8,
        duration_sec: u64,
        quest: &mut Quest
    ) {
        assert!(!quest.is_started, EQuestHasStarted);
        quest.name = name;
        quest.task_count = task_count;
        quest.duration_sec = duration_sec;
    }
}


