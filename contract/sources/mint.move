module sui_quest::mint;

use sui_quest::participation_nft::{Self, ParticipationNft};
use std::string::String;
use sui_quest::completion::Completion;


public (package) fun participation(
    name: String,
    desciption: String,
    completion: Completion,
    quest_name: String,
    event_name: String,
    image_url: String,
    ctx: &mut TxContext,
){
    participation_nft::mint_to_sender(
        name,
        desciption,
        completion,
        quest_name,
        event_name,
        image_url,
        ctx,
    );
}

