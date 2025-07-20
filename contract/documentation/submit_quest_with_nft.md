# `submit_quest_with_nft`

Submits a quest for a user with a participation NFT.

## Parameters
- `participation_nft: &mut ParticipationNft`
- `event: &mut Event`
- `quest_index: u64`
- `start_time: u64`
- `end_time: u64`
- `correct_answers: u8`
- `total_questions: u8`
- `ctx: &mut TxContext`

## Access
Any user who owns a participation NFT.

## Error Codes
- `EEventHasEnded (103)`
- `EQuestHasNotStarted (310)`
- `ETaskCountMismatch (111)`
