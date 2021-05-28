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
                    if ped.behaviour.invincible then
                        SetPedDiesWhenInjured(Ped, false)
                    end
                    if ped.behaviour.canMove then
                        SetPedCanPlayAmbientAnims(Ped, true)
                        SetPedCanRagdollFromPlayerImpact(Ped, false)
                    end
                    if ped.behaviour.ignorePlayer then
                        SetBlockingOfNonTemporaryEvents(Ped, true)
                    end
                end

                while insidePoint == true do
                    if not Peds[k].zone:isPointInside(GetEntityCoords(PlayerPed)) then
                        insidePoint = false

                        if DoesEntityExist(Ped) then
                            DeletePed(Ped)
                        end
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
    @param props: table {
        coords: vector3 - ped coordinate
        heading: float - heading direction
        radius: number - range in which ped will spawn
        useZ: boolean - turn circle zone into a spherical zone
        debug: boolean - draw debug circle
    }
    @param behaviour: table {
        invincible: bool
        canMove: bool
        ignorePlayer: bool
    }
]]

exports("NewPed", function(model, name, props, behaviour)
    Zone = CircleZone:Create(props.coords, props.radius, {
        name = name,
        debugPoly = props.debug,
        useZ = props.useZ
    })

    table.insert(Peds, {
        name = name,
        model = model,
        zone = Zone,
        coords = props.coords,
        heading = props.heading,
        behaviour = behaviour
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