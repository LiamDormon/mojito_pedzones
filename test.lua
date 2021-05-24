CreateThread(function()
    exports["mojito_pedzones"]:NewPed(`mp_m_freemode_01`, "Test", 11.0, 3.0, 70.0, 0.0, 15.0, false, false)
end)

RegisterCommand("DestroyPed", function()
    exports["mojito_pedzones"]:DestroyPed("Test")
end)