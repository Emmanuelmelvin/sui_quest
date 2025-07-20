# `edit_quest`

Edits an existing quest within an event.

## Parameters
- `event: &mut Event`
- `name: String`
- `task_count: u8`
- `duration_sec: u64`
- `quest_index: u64`
- `ctx: &mut TxContext`

## Access
Only event organizers.

## Error Codes
- `EEventHasEnded (103)`
- `ENotAuthorized (104)`
