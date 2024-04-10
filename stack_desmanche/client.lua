local Proxy = module('vrp', 'lib/Proxy')
local Tunnel = module("vrp", "lib/Tunnel")
local vRP = Proxy.getInterface('vRP')

local ped = PlayerPedId()
local desmancheCoords = vec3(1685.35,-1696.6,112.54) 
desmancheStatus = 0



CreateThread(function()
	while true do
		Wait(0)
        local pedCds = GetEntityCoords(ped)
        local distanceDesmanche = #(pedCds - desmancheCoords)
        if distanceDesmanche < 10 then
            DrawMarker(27, desmancheCoords.x, desmancheCoords.y, desmancheCoords.z  - 0.9, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 4.0, 4.0, 4.0, 255, 0, 0, 255, false, false, 2, true, nil, false)
        end
	end
end)



CreateThread(function()
    while true do
        Wait(0)
        local pedCds = GetEntityCoords(ped)
        local distanceDesmanche = #(pedCds - desmancheCoords)
        if IsControlJustPressed(0, 38) and distanceDesmanche < 10 and desmancheStatus == 0 then
            --print('if 1')
            local vehicleDesmanche = vRP.getNearestVehicle(7)
            desmancheClass = GetVehicleClass(vehicleDesmanche)
            if IsPedInAnyVehicle(ped, false) or desmancheClass == 8 then
                --print('if 2')
                TriggerEvent("Notify","aviso","Nao é possivel iniciar o desmanche dentro de um veiculo ou Desmanchar uma Moto!")  
            else
                --print('else')
                vehicleDesmanche2 = vRP.getNearestVehicle(7)
                if vehicleDesmanche2 then
                    for i= 0, 7 do
                        SetVehicleDoorOpen(vehicleDesmanche2, i, false, true)
                        Wait(500)
                    end
                    desmancheStatus = 1
                    TriggerEvent("Notify","sucesso","Iniciando o Desmanche!") 
                    TriggerEvent('STACK_DESMANCHE:PORTA1')
                else 
                    --print('else 2')
                    TriggerEvent("Notify","aviso","Nenhum veiculo por perto!")
                end
            end
        end
        
    end

end)

RegisterNetEvent('STACK_DESMANCHE:PORTA1', function(source)
    local ped = PlayerPedId()
    local Porta1 = GetEntityBoneIndexByName(vehicleDesmanche2, 'door_dside_f' )
    local porta1Cds = GetEntityBonePosition_2(vehicleDesmanche2, Porta1)
 
    CreateThread(function()
        while true do 
            Wait(0)
            if desmancheStatus == 1 then 
                DrawText3D(porta1Cds.x, porta1Cds.y, porta1Cds.z, '~g~[E]~w~ Desmanchar porta')
            end
            if IsControlJustPressed(0, 38) and desmancheStatus ==  1 then 
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", -1, true)
                Wait(5000)
                ClearPedTasksImmediately(ped)
                SetVehicleDoorBroken(vehicleDesmanche2, 0, false)
                TriggerEvent("Notify","sucesso","Porta Desmanchada!") 
                TriggerServerEvent('STACK_DESMANCHE:PAYMENT')
                desmancheStatus = 2
                TriggerEvent('STACK_DESMANCHE:PORTA2')
                
            end 
        end
    
    end)
    
end)

RegisterNetEvent('STACK_DESMANCHE:PORTA2', function(source)
    local ped = PlayerPedId()
    local Porta2 = GetEntityBoneIndexByName(vehicleDesmanche2, 'door_pside_f' )
    local porta2Cds = GetEntityBonePosition_2(vehicleDesmanche2, Porta2)
    
    CreateThread(function()
        while true do 
            Wait(0)
            if desmancheStatus == 2 then 
                DrawText3D(porta2Cds.x, porta2Cds.y, porta2Cds.z, '~g~[E]~w~ Desmanchar porta')
            end
            if IsControlJustPressed(0, 38) and desmancheStatus ==  2 then 
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", -1, true)
                Wait(5000)
                ClearPedTasksImmediately(ped)
                SetVehicleDoorBroken(vehicleDesmanche2, 1, false)
                TriggerEvent("Notify","sucesso","Porta Desmanchada!") 
                TriggerServerEvent('STACK_DESMANCHE:PAYMENT')
                desmancheStatus = 3
                TriggerEvent('STACK_DESMANCHE:PORTA3')
                
            end 
        end
    
    end)
    
end)

RegisterNetEvent('STACK_DESMANCHE:PORTA3', function(source)
    local ped = PlayerPedId()
    local Porta3 = GetEntityBoneIndexByName(vehicleDesmanche2, 'door_dside_r' )
    local porta3Cds = GetEntityBonePosition_2(vehicleDesmanche2, Porta3)
    
    
    CreateThread(function()
        while true do 
            Wait(0)
            if desmancheStatus == 3 then 
                DrawText3D(porta3Cds.x, porta3Cds.y, porta3Cds.z, '~g~[E]~w~ Desmanchar porta')
            end
            if IsControlJustPressed(0, 38) and desmancheStatus ==  3 then 
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", -1, true)
                Wait(5000)
                ClearPedTasksImmediately(ped)
                SetVehicleDoorBroken(vehicleDesmanche2, 2, false)
                TriggerEvent("Notify","sucesso","Porta Desmanchada!") 
                TriggerServerEvent('STACK_DESMANCHE:PAYMENT')
                desmancheStatus = 4
                TriggerEvent('STACK_DESMANCHE:PORTA4')
                
            end 
        end
    
    end)
    
end)

--[[CreateThread(function()
    while true do 
        Wait(500)
        print(desmancheStatus)
    end
end)]]

RegisterNetEvent('STACK_DESMANCHE:PORTA4', function(source)
    local ped = PlayerPedId()
    local Porta4 = GetEntityBoneIndexByName(vehicleDesmanche2, 'door_pside_r' )
    local porta4Cds = GetEntityBonePosition_2(vehicleDesmanche2, Porta4)
     
    CreateThread(function()
        while true do 
            Wait(0)
            if desmancheStatus ==  4 then 
                DrawText3D(porta4Cds.x, porta4Cds.y, porta4Cds.z, '~g~[E]~w~ Desmanchar porta')
            end
            if IsControlJustPressed(0, 38) and desmancheStatus ==  4 then 
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", -1, true)
                Wait(5000)
                ClearPedTasksImmediately(ped)
                SetVehicleDoorBroken(vehicleDesmanche2, 3, false)
                TriggerEvent("Notify","sucesso","Porta Desmanchada!") 
                TriggerServerEvent('STACK_DESMANCHE:PAYMENT')
                desmancheStatus = 5
                TriggerEvent('STACK_DESMANCHE:CAPO')
                
            end 
        end
    
    end)
end)

RegisterNetEvent('STACK_DESMANCHE:CAPO', function(source)
    local ped = PlayerPedId()
    local Capo = GetEntityBoneIndexByName(vehicleDesmanche2, 'bonnet' )
    local capoCds = GetEntityBonePosition_2(vehicleDesmanche2, Capo)
     
    CreateThread(function()
        while true do 
            Wait(0)
            if desmancheStatus ==  5 then 
                DrawText3D(capoCds.x, capoCds.y, capoCds.z, '~g~[E]~w~ Desmanchar Capo')
            end
            if IsControlJustPressed(0, 38) and desmancheStatus ==  5 then 
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", -1, true)
                Wait(5000)
                ClearPedTasksImmediately(ped)
                SetVehicleDoorBroken(vehicleDesmanche2, 4, false)
                TriggerEvent("Notify","sucesso","Capo Desmanchado!") 
                TriggerServerEvent('STACK_DESMANCHE:PAYMENT')
                desmancheStatus = 6
                TriggerEvent('STACK_DESMANCHE:PORTAMALAS')
                
            end 
        end
    
    end)
end)


RegisterNetEvent('STACK_DESMANCHE:PORTAMALAS', function(source)
    local ped = PlayerPedId()
    local Malas = GetEntityBoneIndexByName(vehicleDesmanche2, 'boot' )
    local malasCds = GetEntityBonePosition_2(vehicleDesmanche2, Malas)
     
    CreateThread(function()
        while true do 
            Wait(0)
            if desmancheStatus ==  6 then 
                DrawText3D(malasCds.x, malasCds.y, malasCds.z, '~g~[E]~w~ Desmanchar Porta Malas')
            end
            if IsControlJustPressed(0, 38) and desmancheStatus ==  6 then 
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", -1, true)
                Wait(5000)
                ClearPedTasksImmediately(ped)
                SetVehicleDoorBroken(vehicleDesmanche2, 5, false)
                TriggerEvent("Notify","sucesso","Porta Malas Desmanchado!") 
                TriggerServerEvent('STACK_DESMANCHE:PAYMENT')
                desmancheStatus = 7
                TriggerEvent('STACK_DESMANCHE:CHASSI')
                
            end 
        end
    
    end)
    
end)


RegisterNetEvent('STACK_DESMANCHE:CHASSI', function(source)
    local ped = PlayerPedId()
    -- local Chassi = GetEntityBoneIndexByName(vehicleDesmanche2, 'chassis' )
    local chassiCds = GetEntityCoords(vehicleDesmanche2)
    CreateThread(function()
        while true do 
            Wait(0)
            if desmancheStatus == 7  then 
                DrawText3D(chassiCds.x, chassiCds.y, chassiCds.z, '~g~[E]~w~ Desmanchar Chassi')
            end
            if IsControlJustPressed(0, 38) and desmancheStatus ==  7 then 
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", -1, true)
                Wait(5000)
                ClearPedTasksImmediately(ped)
                TriggerEvent("Notify","sucesso","Desmanche Finalizado!") 
                TriggerServerEvent('STACK_DESMANCHE:PAYMENT')
                Wait(10000)
                SetEntityAsMissionEntity(vhicleDesmanche2, true, true )
                DeleteVehicle(vehicleDesmanche2)
                desmancheStatus = 0
            end 
        end
    
    end)
    
end)


function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.39, 0.39)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 235)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 270
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.04, 0, 0, 0, 145)
end