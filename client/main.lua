local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

local Schemtics = {}
local isCrafting = false
local CurrentAction = ""

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if DoesEntityExist(GetPlayerPed(-1)) then
            coords = GetEntityCoords(GetPlayerPed(-1))
            
            if Config.UseInterior == true then
                if GetDistanceBetweenCoords(coords, Config.InteriorCraftingLoc.x, Config.InteriorCraftingLoc.y, Config.InteriorCraftingLoc.z, true) < 6.0 then
                    ESX.Game.Utils.DrawText3D(vector3(Config.InteriorCraftingLoc.x, Config.InteriorCraftingLoc.y, Config.InteriorCraftingLoc.z + 1.0), "Press ~r~[E]~s~ to use", 0.6)
                end

                if GetDistanceBetweenCoords(coords, Config.InteriorCraftingLoc.x, Config.InteriorCraftingLoc.y, Config.InteriorCraftingLoc.z, true) < 4 then
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenCraftingMenu()
                        Citizen.Wait(2000)
                    end
                end
            else
                if GetDistanceBetweenCoords(coords, Config.CraftingLocation.x, Config.CraftingLocation.y, Config.CraftingLocation.z, true) < 6.0 then
                    ESX.Game.Utils.DrawText3D(vector3(Config.CraftingLocation.x, Config.CraftingLocation.y, Config.CraftingLocation.z + 1.0), "Press ~r~[E]~s~ to use", 0.6)
                end

                if GetDistanceBetweenCoords(coords, Config.CraftingLocation.x, Config.CraftingLocation.y, Config.CraftingLocation.z, true) < 4 then
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenCraftingMenu()
                        Citizen.Wait(2000)
                    end
                end
            end
        end
    end
end)

    function OpenCraftingMenu()
        local elements = {}
        Schemtics = {}
        if Config.RequiresBlueprint then
            ESX.TriggerServerCallback('suku:FetchSchematicsInInventory', function(_list)
                if _list[1] ~= nil then
                    Schemtics = _list
                end
            end)
        else
            for k, v in pairs(Config.Blueprints) do
                table.insert(Schemtics, {name = v.name, label = v.label, itemToCraft = v.itemToCraft})
            end
        end

        Citizen.Wait(500)

        for i = 1, #Schemtics, 1 do
            table.insert(elements, {label = Schemtics[i].label, value = Schemtics[i].name})
        end
        table.insert(elements, {label = 'exit', value = 'exit'})

        ESX.UI.Menu.CloseAll()

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_menu', {
            title = 'Crafting Shit',
            align = 'center',
            elements = elements
        }, function(data, menu)
            for i = 1, #Schemtics, 1 do
                if data.current.value == Schemtics[i].name then
                    if CurrentAction == "" then
                        ProcCraftingSequence(Schemtics[i].itemToCraft)
                    end
                end
            end

            if data.current.value == 'exit' then
                menu.close()
            end
        end, function(data, menu)
            menu.close()
        end)
    end

    function ProcCraftingSequence(itemToCraft)
        if CurrentAction == "" then
            TriggerServerEvent('suku:PlayerHasRequiredItems', itemToCraft)
        end
    end

    RegisterNetEvent('suku:BeginCraftingSchematic')
    AddEventHandler('suku:BeginCraftingSchematic', function(craftable, ingredients)
        CurrentAction = "MANUFACTURING"
        isCrafting = true

        startAnim("mp_arresting", "a_uncuff", craftable.manufactureTime)
        ManufactureTimer(craftable, "Manufacturing: "..craftable.label)
        Citizen.Wait(craftable.manufactureTime)

        TriggerServerEvent('suku:FinishManufacturing', craftable, ingredients)
        isCrafting = false
        CurrentAction = ""
    end)

    function ManufactureTimer(recipeitem, message)
        exports['progressBars']:startUI(recipeitem.manufactureTime, message)
    end

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if isCrafting then
                DisableControlAction(0, 24, true) -- Attack
                DisableControlAction(0, 257, true) -- Attack 2
                DisableControlAction(0, 25, true) -- Aim
                DisableControlAction(0, 263, true) -- Melee Attack 1
                DisableControlAction(0, 32, true) -- W
                DisableControlAction(0, 34, true) -- A
                DisableControlAction(0, 31, true) -- S
                DisableControlAction(0, 30, true) -- D

                DisableControlAction(0, 45, true) -- Reload
                DisableControlAction(0, 22, true) -- Jump
                DisableControlAction(0, 44, true) -- Cover
                DisableControlAction(0, 37, true) -- Select Weapon
                DisableControlAction(0, 23, true) -- Also 'enter'?

                DisableControlAction(0, 288,  true) -- Disable phone
                DisableControlAction(0, 289, true) -- Inventory
                DisableControlAction(0, 170, true) -- Animations
                DisableControlAction(0, 167, true) -- Job

                DisableControlAction(0, 73, true) -- Disable clearing animation
                DisableControlAction(2, 199, true) -- Disable pause screen

                DisableControlAction(0, 59, true) -- Disable steering in vehicle
                DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                DisableControlAction(0, 72, true) -- Disable reversing in vehicle

                DisableControlAction(2, 36, true) -- Disable going stealth

                DisableControlAction(0, 47, true)  -- Disable weapon
                DisableControlAction(0, 264, true) -- Disable melee
                DisableControlAction(0, 257, true) -- Disable melee
                DisableControlAction(0, 140, true) -- Disable melee
                DisableControlAction(0, 141, true) -- Disable melee
                DisableControlAction(0, 142, true) -- Disable melee
                DisableControlAction(0, 143, true) -- Disable melee
                DisableControlAction(0, 75, true)  -- Disable exit vehicle
                DisableControlAction(27, 75, true) -- Disable exit vehicle
            end
        end
    end)

    function startAnim(lib, anim, duration)
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, duration, 0, 0, false, false, false)
        end)
    end

    if Config.UseInterior then
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                player = GetPlayerPed(-1)
                coords = GetEntityCoords(player)
        
                for k, v in pairs(Config.DoorLocations) do
                    if GetDistanceBetweenCoords(coords, Config.DoorLocations[k].x, Config.DoorLocations[k].y, Config.DoorLocations[k].z, true) < 10.0 then
                        ESX.Game.Utils.DrawText3D(vector3(Config.DoorLocations[k].x, Config.DoorLocations[k].y, Config.DoorLocations[k].z + 1.0), "Press ~r~[E]~s~ to open", 0.6)
                    end

                    if GetDistanceBetweenCoords(coords, Config.DoorLocations[k].x, Config.DoorLocations[k].y, Config.DoorLocations[k].z, true) < 2.0 then
                        if IsControlJustReleased(0, Keys["E"]) then
                            SetEntityCoords(player, Config.DoorLocations[k].toX, Config.DoorLocations[k].toY, Config.DoorLocations[k].toZ - 1.0, 1, 0, 0, 1)
                            SetEntityHeading(player, Config.DoorLocations[k].toH)
                            Citizen.Wait(2000)
                        end
                    end
                end
            end
        end)
    end

    if Config.UseBlips then
        Citizen.CreateThread(function()
            if Config.UseInterior then
                CreateBlip(vector3(Config.DoorLocations.Outside.x, Config.DoorLocations.Outside.y, Config.DoorLocations.Outside.z ), "Workshop", 1.5, Config.Color, Config.BlipID)
            else
                CreateBlip(vector3(Config.CraftingLocation.x, Config.CraftingLocation.y, Config.CraftingLocation.z ), "Workshop", 1.5, Config.Color, Config.BlipID)
            end
        end)
    end

    function CreateBlip(coords, text, scale, color, sprite)
        local blip = AddBlipForCoord(coords)
        SetBlipSprite(blip, sprite)
        SetBlipColour(blip, color)
        SetBlipScale(blip, scale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(text)
        EndTextCommandSetBlipName(blip)
    end