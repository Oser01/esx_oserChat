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

Citizen.CreateThread(function()
	entornoContador = 0
	while true do
		Citizen.Wait(60000)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterCommand('entorno', function(source, args, rawCommand)
    local playerCoords = GetEntityCoords(PlayerPedId())
	streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    streetName = GetStreetNameFromHashKey(streetName)
	local msg = rawCommand:sub(8)
	entornoContador = entornoContador + 1
    TriggerServerEvent('esx_oserChat:entorno',{
        x = ESX.Math.Round(playerCoords.x, 1),
        y = ESX.Math.Round(playerCoords.y, 1),
        z = ESX.Math.Round(playerCoords.z, 1)
    }, msg, streetName, entornoContador)
end, false)

RegisterNetEvent('esx_oserChat:entornoSend')
AddEventHandler('esx_oserChat:entornoSend', function(messageFull)
    if PlayerData.job.name == 'police' then
    	--sonido de advertencia
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.9, 'alert', 0.9)
		TriggerEvent('chat:addMessage', messageFull)
    end
end)

RegisterNetEvent('esx_oserChat:entornoMarker')
AddEventHandler('esx_oserChat:entornoMarker', function(targetCoords, entornoMarcador)
    if PlayerData.job.name == 'police' then
        local alpha = 250
        local call = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
        lugarAviso = "Aviso entorno #" .. entornoContador
		SetBlipSprite (call, 480)
		SetBlipDisplay(call, 4)
		SetBlipScale  (call, 1.2)
        SetBlipAsShortRange(call, true)
        SetBlipAlpha(call, alpha)

        SetBlipHighDetail(call, true)
		SetBlipAsShortRange(call, true)

		SetBlipColour (call, 1)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(lugarAviso)
    	EndTextCommandSetBlipName(call)
		while alpha ~= 0 do
			Citizen.Wait(100 * 4)
			alpha = alpha - 1
			SetBlipAlpha(call, alpha)

			if alpha == 0 then
				RemoveBlip(call)
				return
			end
        end
    end
end)

--/1020 solo pueden usarlo si es policia
RegisterCommand('1020', function(source, args, rawCommand)
    if PlayerData.job.name == 'police' then
    	local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
	    streetName = GetStreetNameFromHashKey(streetName)
		local msg = rawCommand:sub(8)
		entornoContador = entornoContador + 1
	    TriggerServerEvent('esx_oserChat:1020',{
	        x = ESX.Math.Round(playerCoords.x, 1),
	        y = ESX.Math.Round(playerCoords.y, 1),
	        z = ESX.Math.Round(playerCoords.z, 1)
	    }, msg, streetName, entornoContador)
    end
end, false)

RegisterNetEvent('esx_oserChat:1020Send')
AddEventHandler('esx_oserChat:1020Send', function(messageFull)
    if PlayerData.job.name == 'police' then
    	--sonido de advertencia
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.9, 'alert', 0.9)
		TriggerEvent('chat:addMessage', messageFull)
    end
end)

RegisterNetEvent('esx_oserChat:1020Marker')
AddEventHandler('esx_oserChat:1020Marker', function(targetCoords, nombre)
    if PlayerData.job.name == 'police' then
        local alpha = 250
        local call = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
        lugarAviso = "Ubicación del oficial: " .. nombre
		SetBlipSprite (call, 458)
		SetBlipDisplay(call, 4)
		SetBlipScale  (call, 1.2)
        SetBlipAsShortRange(call, true)
        SetBlipAlpha(call, alpha)

        SetBlipHighDetail(call, true)
		SetBlipAsShortRange(call, true)

		SetBlipColour (call, 69)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(lugarAviso)
    	EndTextCommandSetBlipName(call)
		while alpha ~= 0 do
			Citizen.Wait(100 * 6)
			alpha = alpha - 1
			SetBlipAlpha(call, alpha)

			if alpha == 0 then
				RemoveBlip(call)
				return
			end
        end
    end
end)