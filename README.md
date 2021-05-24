# mojito_pedzones
API for spawning peds dynamically within a polyzone

## Example:

```lua
-- Create a ped
CreateThread(function()
    exports["mojito_pedzones"]:NewPed(`mp_m_freemode_01`, "Test", 11.0, 3.0, 70.0, 0.0, 15.0, false, false)
end)

-- Destroy a ped
RegisterCommand("DestroyPed", function()
    exports["mojito_pedzones"]:DestroyPed("Test")
end)
```

# License
<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 Unported License</a>.
