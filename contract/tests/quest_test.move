
#[test_only]
module sui_quest::sui_quest_tests;
// uncomment this line to import the module
 use sui_quest::quest::{ SELF, Quest}

const ENotImplemented: u64 = 0;

#[test]
fun test_sui_quest() {
    // pass
    const _: Quest = create_quest(
        b"Question and Answer".to_string(),
        2,
        0001,
        b"url".to_string()
    )
}

