# `start_quest`

Marks a quest within an event as started.

## Parameters
- `event: &mut Event`
- `quest_index: u64`
- `start_time: u64`
- `ctx: &mut TxContext`

## Access
Only event organizers.

## Error Codes
- `EEventHasEnded (103)`
- `ENotAuthorized (104)`
