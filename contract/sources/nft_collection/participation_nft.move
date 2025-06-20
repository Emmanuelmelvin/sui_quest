module  sui_quest::participation_nft;

use sui::event;
use sui::display;
use sui::package;
use std::string::{String, utf8};
use sui::url::Url;

use sui_quest::completion::Completion;

public struct PARTICIPATION_NFT has  drop {}

public struct ParticipationNftMinted has copy, drop {
    object_id: ID,
    creator: address,
    name: vector<u8>
}

public struct ParticipationNft has key {
    id: UID,
    name: String,
    desciption: String,
    creator: address,
    completion: Completion,
    quest_name: String,
    event_name: vector<u8>,
    url: Url,
}

fun init( 
    otw: PARTICIPATION_NFT, 
    ctx: &mut TxContext,
){
       let keys = vector[
        utf8(b"name"),
        utf8(b"desciption"),
        utf8(b"creator"),
        utf8(b"quest_name"),
        utf8(b"event_name"),
        utf8(b"url"),
    ];

    let values = vector[
        utf8(b"{name}"),
        utf8(b"{desciption}"),
        utf8(b"{creator}"),
        utf8(b"{quest_name}"),
        utf8(b"{event_name}"),
        utf8(b"{url}"),
    ];

    let publisher = package::claim(otw, ctx);
    let mut display = display::new_with_fields<ParticipationNft>(
        &publisher, keys, values,  ctx
    );

    display.update_version();


    transfer::public_transfer(display, ctx.sender());
    transfer::public_transfer(publisher, ctx.sender());

    
}
