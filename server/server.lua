local tabela = {}
local sharedItems = exports['qbr-core']:GetItems()

exports['qbr-core']:CreateUseableItem(Config.Itemkit, function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('usemoonkit', source)
    end
end)

RegisterServerEvent("updateclientside",function()
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    for k, v in pairs(tabela) do
        TriggerClientEvent("createclientobj",src,v.kitid,v.kitpos,v.modelHash,v.kith)
        TriggerClientEvent("createclienttabele",src,v.object,v.kitpos,v.modelHash,v.kitid,v.kith,v.burnproces,v.corn,v.water,v.sugar)
    end
end)

RegisterServerEvent("newmoonshinekite",function(object,kitpos,modelHash,kitid,kith,burnproces,corn,water,sugar)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local kitovi = #tabela+1
    tabela[kitovi] = {["object"] = object, ['kitpos'] = kitpos, ['modelHash'] = modelHash,['kitid'] = kitid, ['kitih'] = kith, ['burnproces'] = burnproces, ['corn'] = corn , ['water'] = water, ['sugar'] = sugar}
    for a, v in pairs(tabela) do
        TriggerClientEvent("settargetbroclient",src,v.kitid,v.kitpos)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.Thicktime)

        for k, v in pairs(tabela) do
            if v.burnproces < 100 then
                if v.corn and v.water and v.sugar then
                    v.burnproces = v.burnproces + 1
                end
            end
        end
    end
end)

RegisterServerEvent("takemoonshine",function(kitid,burnproces)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
  
    for k, v in pairs(tabela) do

        if v.burnproces == 100 then 

            if v.kitid == kitid then
                v.burnproces = 0
                v.corn = false
                v.water = false
                v.sugar = false
            
                Player.Functions.AddItem(Config.ItemReward.name, Config.ItemReward.quant)
                TriggerClientEvent('inventory:client:ItemBox', src, sharedItems[Config.ItemReward.name], "add")
                TriggerClientEvent('QBCore:Notify', src, 9, Config.Rewardnotify ..Config.ItemReward.quant, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
            end
        end
        
    end
end)


RegisterServerEvent("deleteenittykit",function(kitid)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
   
    for k, v in pairs(tabela) do
        if v.kitid == kitid then
            table.remove(tabela, k)
          
		end
    end
end)

RegisterServerEvent('openmenu')
AddEventHandler('openmenu', function(kitid)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)

    for k, v in pairs(tabela) do
        if v.kitid == kitid then
            if v.corn == false then
                TriggerClientEvent('qbr-moonshiner:client:corn',src)
            end
            if v.water == false then
                TriggerClientEvent('qbr-moonshiner:client:water',src)
            end
            if v.sugar == false then
                TriggerClientEvent('qbr-moonshiner:client:sugar',src)
            end
            if v.corn and v.water and v.sugar then
                TriggerClientEvent('qbr-moonshiner:client:bp',src,v.burnproces)
            end
            if v.burnproces == 100 then
                TriggerClientEvent('qbr-moonshiner:client:harvest',src)
            end
        end
    end
end)

RegisterServerEvent('serveraddcorn')
AddEventHandler('serveraddcorn', function(kitid)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    
    Player.Functions.RemoveItem(Config.ItemCorn.name, Config.ItemCorn.quant)
    TriggerClientEvent('inventory:client:ItemBox', src, sharedItems[Config.ItemCorn.name], "remove")
    
    for k, v in pairs(tabela) do
        if v.kitid == kitid then
            v.corn = true
        end
    end
end)

RegisterServerEvent('serveraddwater')
AddEventHandler('serveraddwater', function(kitid)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)

    Player.Functions.RemoveItem(Config.ItemWater.name, Config.ItemWater.quant)
    TriggerClientEvent('inventory:client:ItemBox', src, sharedItems[Config.ItemWater.name], "remove")

    for k, v in pairs(tabela) do
        if v.kitid == kitid then
            v.water = true
        end
    end
end)

RegisterServerEvent('serveraddsugar')
AddEventHandler('serveraddsugar', function(kitid)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    
    Player.Functions.RemoveItem(Config.ItemSugar.name, Config.ItemSugar.quant)
    TriggerClientEvent('inventory:client:ItemBox', src, sharedItems[Config.ItemSugar.name], "remove")
    
    for k, v in pairs(tabela) do
        if v.kitid == kitid then
            v.sugar = true
        end
    end
end)


