# `submit_quest_without_nft`

Submits a quest for a user without a participation NFT.

## Parameters
- `event: &mut Event`
- `quest_index: u64`
- `start_time: u64`
- `end_time: u64`
- `correct_answers: u8`
- `total_questions: u8`
- `ctx: &mut TxContext`

## Access
Any user.

## Error Codes
- `EEventHasEnded (103)`
- `EQuestHasNotStarted (310)`
- `ETaskCountMismatch (111)`
