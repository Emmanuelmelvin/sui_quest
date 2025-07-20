# `end`

Marks an event as ended.

## Parameters
- `event: &mut Event` — Mutable reference to the event.
- `ctx: &mut TxContext` — Transaction context.

## Access
Only the event organizer can call this function.

## Error Codes
- `EEventHasEnded (103)` — Event already ended.
- `ENotAuthorized (104)` — Caller is not the organizer.

---
