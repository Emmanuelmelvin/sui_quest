
module sui_quest::quest;
    use std::string::String;

    //constants used for error handling
    const EQuestHasStarted: u64 = 100;
    const EQuestNotFound: u64 = 101;
    const EQuestHasNoValidTask: u64 = 102;
    const EUserEnteredQuestAlready: u64 = 120;

    public struct Quest has copy, store, drop {
        name: String,
        task_count: u8,
        start_time: u64,
        duration_sec: u64,
        is_started: bool,
        metadata_id: String,
        users_entered: vector<address>,
    }

    public (package) fun new(
        name: String,
        task_count: u8,
        duration_sec: u64,
        metadata_id: String,
    ): Quest {
        // Ensure that the task count is within a reasonable range
        assert!(task_count > 0 && task_count <= 10, EQuestHasNoValidTask);
        // Ensure that the duration is positive
        assert!(duration_sec > 0, EQuestNotFound);

        // Create a new Quest object
        Quest {
            name: name,
            task_count: task_count,
            start_time: 0,
            duration_sec: duration_sec,
            is_started: false,
            metadata_id: metadata_id,
            users_entered: vector::empty()
        }
    }

    public (package) fun start(
        quest: &mut Quest,
        start_time: u64
    ) {
        assert!(!quest.is_started, EQuestHasStarted);
        quest.start_time = start_time;
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

    public fun destroy(q: Quest) {
        // Explicitly destroy fields if needed, or just let q go out of scope if fields have drop.
    }

    public(package) fun enter(
        quest: &mut Quest,
        ctx: &mut TxContext,
    ){
        let len = quest.users_entered.length();
        let i = 0;

        while(i < len){
            if(ctx.sender() == quest.users_entered[i]){
                abort EUserEnteredQuestAlready;
            }else{
                //add user to the list of users that entered the quest
                quest.users_entered.push_back(ctx.sender());
            }
        }
        
    }

    public (package) fun task_count(
        quest: &Quest
    ): u8 {
        quest.task_count
    }

    public (package) fun get_name(
        quest: &Quest
    ): &String{
        &quest.name
    }

    #[test_only]
    public  fun check_if_quest_has_started(
        quest: vector<Quest>,
        quest_index: u64,
    ): bool  {
        if(quest[quest_index].is_started){
            true
        }else{
            false
        }
        
    }




