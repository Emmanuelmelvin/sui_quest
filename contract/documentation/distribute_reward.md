# `distribute_reward`

Distributes a reward NFT to a user at a specific rank.

## Parameters
- `event: &mut Event`
- `rank: u64`
- `address: address`
- `ctx: &mut TxContext`

## Access
Only event organizers.

## Error Codes
- `EEventHasNotEnded (300)`
- `ENotAuthorized (104)`
