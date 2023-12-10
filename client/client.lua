local sharedItems = exports['qbr-core']:GetItems()

isLoggedIn = false
PlayerJob = {}

local tabela = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = exports['qbr-core']:GetPlayerData().job
	TriggerServerEvent("updateclientside")
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent("usemoonkit",function()
	
	local playerPed = PlayerPedId()
	
	local charpos = GetEntityCoords(playerPed, true)
	
	local canSet = CanSetkithere(charpos)
	
	
	
	if canSet == false then exports['qbr-core']:Notify(9, Config.DistancWarning, 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE') return end

	TaskStartScenarioInPlace(playerPed, Config.Scenario2, 10000, true, false, false, false)
	Wait(5000)
	ClearPedTasks(playerPed)
	SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.75, -1.55))
	local modelHash = GetHashKey(Config.Prop)
	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)
		while not HasModelLoaded(modelHash) do
			Wait(1)
		end
	end
	
	local burnproces = 0
	local corn = false
	local water = false
	local sugar = false
	local kitpos = GetEntityCoords(playerPed, true)
	local kith = GetEntityHeading(PlayerPedId())
	local object = modelHash
    local kitid = math.random(154, 45547854)
    TriggerServerEvent("newmoonshinekite", object,kitpos,modelHash,kitid,kith,burnproces,corn,water,sugar)
	TriggerEvent("createclienttabele",object,kitpos,modelHash,kitid,kith,burnproces,corn,water,sugar)
	TriggerEvent("createclientobj",kitid,kitpos,modelHash,kith)
end)


RegisterNetEvent("deleteclientserverkit",function()
	local ped = PlayerPedId()
	local kit = GetClosestkit()
	local kordinate = GetEntityCoords(PlayerPedId())
	local nearstKit = GetClosestObjectOfType(kordinate, 5.0,Config.Prop)
    DeleteEntity(nearstKit)

	for k, v in pairs(tabela) do
         if v.kitid == kit.kitid then
            table.remove(tabela, k)
			TriggerServerEvent("deleteenittykit",kit.kitid)
		end
	end
end)

RegisterNetEvent('harvest')
AddEventHandler('harvest', function()
    local ped = PlayerPedId()
   	local kit = GetClosestkit()
	TriggerServerEvent('takemoonshine', kit.kitid,kit.burnproces)
end)

RegisterNetEvent('addcorn')
AddEventHandler('addcorn', function()
    local ped = PlayerPedId()
   	local kit = GetClosestkit()
    exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
			TaskStartScenarioInPlace(ped, Config.Scenario, 10000, true, false, false, false)
			Wait(5000)
			ClearPedTasks(ped)
			SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
			TriggerServerEvent('serveraddcorn', kit.kitid)
		else
			exports['qbr-core']:Notify(9, Config.Cornnotify, 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
			Wait(5000)
			
		end
	end, { [Config.ItemCorn.name] = Config.ItemCorn.quant })
end)

RegisterNetEvent('addwater')
AddEventHandler('addwater', function()
    local ped = PlayerPedId()
   	local kit = GetClosestkit()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
			TaskStartScenarioInPlace(ped, Config.Scenario, 10000, true, false, false, false)
			Wait(5000)
			ClearPedTasks(ped)
			TriggerServerEvent('serveraddwater', kit.kitid)
			SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
		else
			exports['qbr-core']:Notify(9, Config.Waternotify, 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
			Wait(5000)
			
		end
	end, { [Config.ItemWater.name] = Config.ItemWater.quant })
end)

RegisterNetEvent('addsugar')
AddEventHandler('addsugar', function()
    local ped = PlayerPedId()
   	local kit = GetClosestkit()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			TaskStartScenarioInPlace(ped, Config.Scenario, 10000, true, false, false, false)
			Wait(5000)
			ClearPedTasks(ped)
			TriggerServerEvent('serveraddsugar', kit.kitid)
			SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
		else
			exports['qbr-core']:Notify(9, Config.Sugarnotify, 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
			Wait(5000)
			
		end
	end, { [Config.ItemSugar.name] = Config.ItemSugar.quant})
end)



RegisterNetEvent("createclientobj",function(kitid,kitpos,modelHash,kith)
	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)
		while not HasModelLoaded(modelHash) do
			Wait(1)
		end
	end
	local object = CreateObject(modelHash, kitpos-1, true, true, false)
	PlaceObjectOnGroundProperly(object)
	SetEntityAsMissionEntity(object, true)
	SetEntityHeading(object,kith)
	PlaceObjectOnGroundProperly(object)
	PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
end)


function GetClosestkit()
    local dist = 1000
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local kit = {}

    for i = 1, #tabela do
        local xd = GetDistanceBetweenCoords(pos, tabela[i].kitpos,true)
        if xd < dist then
            dist = xd
            kit = tabela[i]
		
        end
    end
    return kit
end

function isNearKit()
	local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    for i = 1, #tabela do
        if GetDistanceBetweenCoords(pos, tabela[i].kitpos, true) < 3.0 then
			return true
		end
	end
   	return false 
 end


function CanSetkithere(pos)
    local canSet = true

    for i = 1, #tabela do
        if GetDistanceBetweenCoords(pos, tabela[i].kitpos, true) < 3.0 then
            canSet = false
        end
    end

    return canSet
end



RegisterNetEvent("createclienttabele",function(object,kitpos,modelHash,kitid,kith,burnproces,corn,water,sugar)
	local kitovi = #tabela+1
    tabela[kitovi] = {["object"] = object, ['kitpos'] = kitpos, ['modelHash'] = modelHash,['kitid'] = kitid, ['kitih'] = kith, ['burnproces'] = burnproces, ['corn'] = corn , ['water'] = water, ['sugar'] = sugar}
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
		local shoulddraw = isNearKit()
		local sleep = true
        if shoulddraw then
            sleep = false
			DrawTxt("Press ~e~E~q~ to interact", 0.50, 0.84, 0.3, 0.3, true, 255, 255, 255, 255, true) 
                DrawSprite("menu_textures", "translate_bg_1a",  0.50, 0.85, 0.10, 0.04, 0.8, 0, 0, 0, 255, 0)
            if IsControlJustReleased(0, 0xCEFD9220) then
                TriggerEvent('openclmenu')
            end
        end
		if sleep then
			Wait(2000)
		end
    end
end)