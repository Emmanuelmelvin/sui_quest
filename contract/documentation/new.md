# `new`

Creates a new event and registers it into the provided `EventRegister`.

## Parameters
- `name: String` — Name of the event.
- `metadata_id: String` — External or on-chain metadata reference.
- `register: &mut EventRegister` — Mutable reference to the event register.
- `ctx: &mut TxContext` — Transaction context.

## Access
Anyone can call.

## Behavior
Creates and adds a new `Event` into the register.

---
