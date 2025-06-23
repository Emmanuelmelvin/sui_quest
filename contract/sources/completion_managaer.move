module sui_quest::completion_manager;
use sui_quest::mint;
use sui_quest::completion;
use sui_quest::participation_nft::{ Self, ParticipationNft};

use std::string::String;

public fun new(
    start_time: u64,
    correct_answers: u8,
    total_questions: u8,
    quest_index: u64,
    end_time: u64,
    event_name: String,
    quest_name: String,
    ctx: &mut TxContext
) {
    let new_completion  = completion::create(
        start_time,
        correct_answers,
        total_questions,
        quest_index,
        end_time,
        event_name,
        ctx,
    );


      mint::participation(
        b"SuiQuestXPBadge".to_string(),
        b"This is a commemorative NFT awarded to participants of an event hosted on the SuiQuest platform. It serves as a digital proof of engagement and contribution, recognizing individuals who took part in the experience and earned valuable knowledge. This badge symbolizes progress with the Sui ecosystem may represent participation, learning milestone, or community ".to_string(),
        new_completion,
        quest_name,
        event_name,
        b"".to_string(),
        ctx,
    )
}

public fun edit(
    nft: &mut ParticipationNft,
    start_time: u64,
    correct_answers: u8,
    total_questions: u8,
    quest_index: u64,
    end_time: u64,
    event_name: String,
    quest_name: String
){
    let mut completions = nft.get_completion();

    completions.add(
        start_time,
        correct_answers,
        total_questions,
        quest_index,
        end_time,
        event_name
    );
}
