
#[test_only]
module sui_quest::sui_quest_tests;
// uncomment this line to import the module
 use sui_quest::quest::{ Self, Quest};

const ENotImplemented: u64 = 0;

#[test_only]
fun create_quest(): Quest{
    quest::new(
        b"Good boy".to_string(),
        5,
        0001,
        b"link".to_string(),
    )
}   

#[test]
fun test_sui_quest() {
    let _ : Quest = quest::new(
        b"Good boy".to_string(),
        5,
        0001,
        b"link".to_string(),
    );
}

#[test]
fun test_start_quest(){
    let mut new_quest = create_quest();

    quest::start(
        &mut new_quest,
        0001
    );

    assert!(quest::check_if_quest_has_started(&new_quest));
}
