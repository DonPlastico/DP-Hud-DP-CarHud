local hunger = 100
local thirst = 100

RegisterNetEvent("hud:client:UpdateNeeds")
AddEventHandler("hud:client:UpdateNeeds", function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

CreateThread(function()
    while true do
        local msec = 1000;
        local ped = PlayerPedId()

        SendNUIMessage({
            action = "u-hud",
            vida = GetEntityHealth(ped) - 105,
            hunger = hunger,
            thirst = thirst,
            escudo = GetPedArmour(ped),
            stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
            oxigeno = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10,
            enVeh = IsPedInAnyVehicle(PlayerPedId())
        })
        DisplayRadar(IsPedInAnyVehicle(PlayerPedId()))
        Wait(msec)
    end
end)

CreateThread(function()
    while true do
        SetRadarBigmapEnabled(false, false)
        Wait(500)
    end
end)

CreateThread(function()
    local minimap = RequestScaleformMovie('minimap')
    if not HasScaleformMovieLoaded(minimap) then
        RequestScaleformMovie(minimap)
        while not HasScaleformMovieLoaded(minimap) do
            Wait(1)
        end
    end
end)



Citizen.CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0)
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0)
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0)
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0)
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0)
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1)
		if IsPedOnFoot(GetPlayerPed(-1)) then 
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			SetRadarZoom(1100)
		end
    end
end)