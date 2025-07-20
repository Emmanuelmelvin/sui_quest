# `add_quest`

Adds a new quest to an event.

## Parameters
- `event: &mut Event`
- `event_register: &mut EventRegister`
- `name: String`
- `task_count: u8`
- `duration_sec: u64`
- `metadata_id: String`
- `ctx: &mut TxContext`

## Access
Only event organizers.

## Error Codes
- `EEventHasEnded (103)`
- `ENotAuthorized (104)`
