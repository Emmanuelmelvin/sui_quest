module  sui_quest::participation_nft;

use sui::event;
use sui::display;
use sui::package;
use std::string::{String, utf8};

use sui_quest::completion::Completion;

public struct PARTICIPATION_NFT has  drop {}

public struct ParticipationNftMinted has copy, drop {
    object_id: ID,
    creator: address,
    name: String,
}

public struct ParticipationNft has key, store {
    id: UID,
    name: String,
    description: String,
    creator: address,
    completion: Completion,
    quest_name: String,
    event_name: String,
    image_url: String,
}

fun init( 
    otw: PARTICIPATION_NFT, 
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
        utf8(b"{description}"),
        utf8(b"{creator}"),
        utf8(b"{quest_name}"),
        utf8(b"{event_name}"),
        utf8(b"{image_url}"),
    ];

    let publisher = package::claim(otw, ctx);
    let mut display = display::new_with_fields<ParticipationNft>(
        &publisher, keys, values,  ctx
    );

    display.update_version();


    transfer::public_transfer(display, ctx.sender());
    transfer::public_transfer(publisher, ctx.sender());

    
}

public (package) fun mint_to_sender(
    name: String,
    description: String,
    completion: Completion,
    quest_name: String,
    event_name: String,
    image_url: String,
    ctx: &mut TxContext,
) {

    let nft = ParticipationNft{
        id: object::new(ctx),
        name,
        description,
        creator: ctx.sender(),
        completion,
        quest_name,
        event_name,
        image_url,
    };

    event::emit(
        ParticipationNftMinted {
            object_id: object::id(&nft),
            creator: ctx.sender(),
            name,
        }
    );

    transfer::public_transfer(nft, ctx.sender());
}

public (package) fun get_completion(
    nft: &mut ParticipationNft
): &mut Completion {
    &mut nft.completion
}



public fun name(
    nft: &ParticipationNft,
): &String {
    &nft.name
}

public fun description(
    nft: &ParticipationNft,
): &String {
    &nft.description
}

public fun completion_object (
    nft: &ParticipationNft
): &Completion {
    &nft.completion
}

public fun image_url(
    nft:&ParticipationNft
):  &String{
    &nft.image_url
}