module sui_quest::winners_nft;

use sui::event;
use sui::display;
use sui::package;
use std::string::{String, utf8};

public struct WinnersNft has key, store {
    id: UID,
    name: String,
    reciepient: address,
    rank: u64,
    image_url: String
}

public struct WinnerNftMinted has copy, drop {
    object_id: ID,
    creator: address,
}

public struct WINNERS_NFT has drop{}

fun init( 
    otw: WINNERS_NFT, 
    ctx: &mut TxContext,
){
       let keys = vector[
        utf8(b"name"),
        utf8(b"description"),
        utf8(b"creator"),
        utf8(b"quest_name"),
        utf8(b"event_name"),
        utf8(b"image_url"),
    ];

    let values = vector[
        utf8(b"{name}"),
        utf8(b"This NFT is a special piece given to users that participated in a quest posted by an organizer in an event. It reflects the level of knowledge a user has about the taught concept."),
        utf8(b"{creator}"),
        utf8(b"{quest_name}"),
        utf8(b"{event_name}"),
        utf8(b"{image_url}"),
    ];

    let publisher = package::claim(otw, ctx);
    let mut display = display::new_with_fields<WinnersNft>(
        &publisher, keys, values,  ctx
    );

    display.update_version();


    transfer::public_transfer(display, ctx.sender());
    transfer::public_transfer(publisher, ctx.sender());

    
}

fun get_title_for_rank(
    rank: u64
): String {
    if(rank == 1){
        b"SuiQuest Mater".to_string()
    } else if( rank == 2){
        b"SuiQuest Ace".to_string()
    } else if(rank == 3){
        b"SuiQuest Challenger".to_string()
    } else {
        b"SuiQuest Finalist".to_string()
    }
}

fun get_image_url_for_rank(
    rank: u64
): String {
       if(rank == 1){
        b"".to_string()
    } else if( rank == 2){
        b"".to_string()
    } else if(rank == 3){
        b"".to_string()
    } else {
        b"".to_string()
    }
}

public (package) fun mint_to_sender(
    address: address,
    rank: u64,
    ctx: &mut TxContext
){
    let nft = WinnersNft {
        id: object::new(ctx),
        name: get_title_for_rank(rank),
        reciepient: address,
        rank,
        image_url: get_image_url_for_rank(rank),
    };

    event::emit( WinnerNftMinted {
        object_id: object::id(&nft),
        creator: ctx.sender()
    });

    transfer::public_transfer(nft, address);
}