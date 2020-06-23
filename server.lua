TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

RegisterServerEvent('esx_oserChat:entorno')
AddEventHandler('esx_oserChat:entorno', function(targetCoords, msg, streetName, entornoContador)
    local _source = source
    local xPlayers = ESX.GetPlayers()
	local messageFull
    local entornoMarcador
	local messageSending
    entornoMarcador = entornoContador
	messageFull = {
		template = '<div style="color: #FFFFFF; padding: 8px; margin: 5px; background-color: rgba(255, 0, 0, 1); border-radius: 5px;"><i class="fas fa-bell"style="font-size:15px"></i>  [Entorno] #{0} {1}: {2}</font></i></b></div>',
		args = {entornoContador, streetName, msg}
	}
	messageSending = {
		template = '<div style="color: #FFFFFF; padding: 8px; margin: 5px; background-color: rgba(255, 0, 0, 1); border-radius: 5px;"><i class="fas fa-bell"style="font-size:15px"></i>  [Entorno] Mensaje enviado a las autoridades</font></i></b></div>',
		args = {}
	}
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Mensaje enviado' })
	TriggerClientEvent('esx_oserChat:entornoMarker', -1, targetCoords, emergency, entornoMarcador)
    TriggerClientEvent('esx_oserChat:entornoSend', -1, messageFull, messageSending)
end)
