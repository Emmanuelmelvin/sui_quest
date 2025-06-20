module sui_quest::completion_register;

public struct CompletionRegister has key {
    id: UID,
    completions: vector<ID>,
}

public struct COMPLETION_REGISTER has drop {}

fun init(otw: COMPLETION_REGISTER, ctx: &mut TxContext){
    
}

