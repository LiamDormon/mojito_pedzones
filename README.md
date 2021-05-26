# mojito_pedzones
API for spawning peds dynamically within a polyzone

## Example:

```lua
-- Create a ped

exports["mojito_pedzones"]:NewPed(`mp_m_freemode_01`, "Test", {
    coords = vector3(11.0, 3.0, 70.0),
    radius = 15.0,
    heading = 0.0,
    useZ = false,
    debug = false
}, {
    invincible = true,
    canMove = false,
    ignorePlayer = true
})

-- Destroy a ped

exports["mojito_pedzones"]:DestroyPed("Test")
```

# License
<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 Unported License</a>.
