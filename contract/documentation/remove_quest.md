# `remove_quest`

Removes a quest from an event.

## Parameters
- `event: &mut Event`
- `quest_index: u64`
- `ctx: &mut TxContext`

## Access
Only event organizers.

## Error Codes
- `EEventHasEnded (103)`
- `ENotAuthorized (104)`
