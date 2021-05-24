local Peds = {}
local insidePoint = false
local Ped = nil


CreateThread(function()
    while true do 
        Wait(500)
        local PlayerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(PlayerPed)

        for k, ped in pairs(Peds) do
            if Peds[k].zone:isPointInside(pedCoords) then
                insidePoint = true

                local PedModel = ped.model
                local PedCoords = ped.coords

                RequestModel(PedModel)

                while not HasModelLoaded(PedModel) do
                    Wait(10)
                end

                if not DoesEntityExist(Ped) then
                    Ped = CreatePed(1, PedModel, PedCoords.x, PedCoords.y, PedCoords.z, ped.heading, false, true)
                    SetPedDiesWhenInjured(Ped, false)
                    SetPedCanPlayAmbientAnims(Ped, true)
                    SetPedCanRagdollFromPlayerImpact(Ped, false)
                end
                
                TriggerEvent("QBCore:Notify", "You have entered a zone", "success")

                while insidePoint == true do
                    if not Peds[k].zone:isPointInside(GetEntityCoords(PlayerPed)) then
                        insidePoint = false

                        if DoesEntityExist(Ped) then
                            DeletePed(Ped)
                        end

                        TriggerEvent("QBCore:Notify", "You have left a zone", "error")
                    end

                    Wait(5)
                end
            end
        end
    end
end)

--[[
    function NewPed
    Creates a ped that will dynamically spawn within given radius

    @param model: hash - Hash of the ped model
    @param x: float - X coordinate
    @param y: float - Y coordinate
    @param z: float - Z coordinate
    @param h: float - heading direction
    @param radius: number - range in which ped will spawn
    @param useZ: boolean - turn circle zone into a spherical zone
    @param debug: boolean - draw debug circle
]]

exports("NewPed", function(model, name, x, y, z, h, radius, useZ, debug)
    local coords = vector3(x, y, z)
    Zone = CircleZone:Create(coords, radius, {
        name = name,
        debugPoly = debug,
        useZ = useZ
    })

    table.insert(Peds, {
        name = name,
        model = model,
        zone = Zone,
        coords = coords,
        heading = h
    })
end)

--[[
    function DestroyPed
    Destroys the zone around a ped and if currently active destroys the ped also
    
    @param name: string - name of zone
]]

exports("DestroyPed", function(name)
    for k, v in pairs(Peds) do
        if v.name == name then
            v.zone:destroy()
            Peds[k] = nil

            insidePoint = false
            if DoesEntityExist(Ped) then
                DeletePed(Ped)
            end
        end
    end
end)