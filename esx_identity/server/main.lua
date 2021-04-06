ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source, callback)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT identifier, firstname, lastname, dateofbirth, sex, height FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1].firstname ~= nil then
			local data = {
				identifier	= result[1].identifier,
				firstname	= result[1].firstname,
				lastname	= result[1].lastname,
				dateofbirth	= result[1].dateofbirth,
				sex			= result[1].sex,
				height		= result[1].height
			}

			callback(data)
		else
			local data = {
				identifier	= '',
				firstname	= '',
				lastname	= '',
				dateofbirth	= '',
				sex			= '',
				height		= ''
			}

			callback(data)
		end
	end)
end

function setIdentity(identifier, data, callback)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function updateIdentity(playerId, data, callback)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= xPlayer.identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(rowsChanged)
		if callback then
			TriggerEvent('esx_identity:characterUpdated', playerId, data)
			callback(true)
		end
	end)
end

function deleteIdentity(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= xPlayer.identifier,
		['@firstname']		= '',
		['@lastname']		= '',
		['@dateofbirth']	= '',
		['@sex']			= '',
		['@height']			= '',
	})
end

RegisterServerEvent('esx_identity:setIdentity')
AddEventHandler('esx_identity:setIdentity', function(data, myIdentifiers)
	local xPlayer = ESX.GetPlayerFromId(source)
	setIdentity(myIdentifiers.steamid, data, function(callback)
		if callback then
			TriggerClientEvent('esx_identity:identityCheck', myIdentifiers.playerid, true)
			TriggerEvent('esx_identity:characterUpdated', myIdentifiers.playerid, data)
		else
			xPlayer.showNotification(_U('failed_identity'))
		end
	end)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	local myID = {
		steamid = xPlayer.identifier,
		playerid = playerId
	}

	TriggerClientEvent('esx_identity:saveID', playerId, myID)

	getIdentity(playerId, function(data)
		if data.firstname == '' then
			TriggerClientEvent('esx_identity:identityCheck', playerId, false)
			TriggerClientEvent('esx_identity:showRegisterIdentity', playerId)
		else
			TriggerClientEvent('esx_identity:identityCheck', playerId, true)
			TriggerEvent('esx_identity:characterUpdated', playerId, data)
		end
	end)
end)

AddEventHandler('esx_identity:characterUpdated', function(playerId, data)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		xPlayer.setName(('%s %s'):format(data.firstname, data.lastname))
		xPlayer.set('firstName', data.firstname)
		xPlayer.set('lastName', data.lastname)
		xPlayer.set('dateofbirth', data.dateofbirth)
		xPlayer.set('sex', data.sex)
		xPlayer.set('height', data.height)
	end
end)

-- Set all the client side variables for connected users one new time
AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(3000)
		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer then
				local myID = {
					steamid  = xPlayer.identifier,
					playerid = xPlayer.source
				}
	
				TriggerClientEvent('esx_identity:saveID', xPlayer.source, myID)
	
				getIdentity(xPlayer.source, function(data)
					if data.firstname == '' then
						TriggerClientEvent('esx_identity:identityCheck', xPlayer.source, false)
						TriggerClientEvent('esx_identity:showRegisterIdentity', xPlayer.source)
					else
						TriggerClientEvent('esx_identity:identityCheck', xPlayer.source, true)
						TriggerEvent('esx_identity:characterUpdated', xPlayer.source, data)
					end
				end)
			end
		end
	end
end)

--[[
ESX.RegisterCommand('register', 'user', function(xPlayer, args, showError)
	getIdentity(xPlayer.source, function(data)
		if data.firstname ~= '' then
			xPlayer.showNotification(_U('already_registered'))
		else
			TriggerClientEvent('esx_identity:showRegisterIdentity', xPlayer.source)
		end
	end)
end, false, {help = _U('show_registration')})

ESX.RegisterCommand('char', 'user', function(xPlayer, args, showError)
	getIdentity(xPlayer.source, function(data)
		if data.firstname == '' then
			xPlayer.showNotification(_U('not_registered'))
		else
			xPlayer.showNotification(_U('active_character', data.firstname, data.lastname))
		end
	end)
end, false, {help = _U('show_active_character')})

ESX.RegisterCommand('chardel', 'user', function(xPlayer, args, showError)
	getIdentity(xPlayer.source, function(data)
		if data.firstname == '' then
			xPlayer.showNotification(_U('not_registered'))
		else
			deleteIdentity(xPlayer.source)
			xPlayer.showNotification(_U('deleted_character'))
			TriggerClientEvent('esx_identity:showRegisterIdentity', xPlayer.source)
		end
	end)
end, false, {help = _U('delete_character')})
]]




TriggerEvent('es:addCommand', 'register', function(source, args, user)
	getIdentity(source, function(data)
	  if data.firstname ~= '' then
		TriggerClientEvent('chatMessage', source, 'REGISTER', {255, 0, 0}, "You Can Only Have 1 Character.")
	  else
		TriggerClientEvent('esx_identity:showRegisterIdentity', source, {})
	  end
	end)
end)

TriggerEvent('es:addGroupCommand', 'char', "user", function(source, args, user)
	getIdentity(source, function(data)
	  if data.firstname == '' then
		TriggerClientEvent('chatMessage', source, 'CHAR', {255, 0, 0}, "You Have No Active Character.")
	  else
		TriggerClientEvent('chatMessage', source, 'CHAR', {255, 0, 0}, "Active Character: " .. data.firstname .. " " .. data.lastname)
	  end
	end)
  end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "List Your Current Active Character"})

TriggerEvent('es:addCommand', 'delchar', function(source, args, user)
	table.remove(args, 1)
	local charNumber = tonumber(table.concat(args, " "))
	getIdentity(source, function(data)
	  if charNumber == 1 then
		local data = {
		  identifier   = data.identifier,
		  firstname  = data.firstname1,
		  lastname  = data.lastname1,
		  dateofbirth  = data.dateofbirth1,
		  sex      = data.sex1,
		  height    = data.height1
		}
		if data.firstname ~= '' then
		  deleteIdentity(GetPlayerIdentifiers(source)[1], data, function(callback)
			if callback == true then
			TriggerClientEvent('chatMessage', source, "DELCHAR", {255, 0, 0}, "You Have Deleted " .. data.firstname .. " " .. data.lastname .. "!")
			else
			  TriggerClientEvent('chatMessage', source, "DELCHAR", {255, 0, 0}, "Failed To Delete Identity!")
			end
		  end)
		else
		  TriggerClientEvent('chatMessage', source, "DELCHAR", {255, 0, 0}, "You don\'t have a character in slot 1!")
		end
	  elseif charNumber == 2 then
		local data = {
		  identifier   = data.identifier,
		  firstname  = data.firstname2,
		  lastname  = data.lastname2,
		  dateofbirth  = data.dateofbirth2,
		  sex      = data.sex2,
		  height    = data.height2
		}
		if data.firstname ~= '' then
		  deleteIdentity(GetPlayerIdentifiers(source)[1], data, function(callback)
			if callback == true then
			  TriggerClientEvent('chatMessage', source, "DELCHAR", {255, 0, 0}, "You Have Deleted " .. data.firstname .. " " .. data.lastname .. "!")
			else
			  TriggerClientEvent('chatMessage', source, "DELCHAR", {255, 0, 0}, "Failed To Delete Identity!")
			end
		  end)
		else
		  TriggerClientEvent('chatMessage', source, "DELCHAR", {255, 0, 0}, "You don\'t have a character in slot 2!")
		end
	  elseif charNumber == 3 then
		local data = {
		  identifier   = data.identifier,
		  firstname  = data.firstname3,
		  lastname  = data.lastname3,
		  dateofbirth  = data.dateofbirth3,
		  sex      = data.sex3,
		  height    = data.height3
		}
		if data.firstname ~= '' then
		  deleteIdentity(GetPlayerIdentifiers(source)[1], data, function(callback)
			if callback == true then
			  TriggerClientEvent('chatMessage', source, "DELCHAR", {255, 0, 0}, "You Have Deleted " .. data.firstname .. " " .. data.lastname .. "!")
			else
			  TriggerClientEvent('chatMessage', source, "DELCHAR", {255, 0, 0}, "Failed To Delete Identity!")
			end
		  end)
		else
		  TriggerClientEvent('chatMessage', source, "DELCHAR", {255, 0, 0}, "You don\'t have a character in slot 3!")
		end
	  else
		TriggerClientEvent('chatMessage', source, "DELCHAR", {255, 0, 0}, "Failed To Delete Identity!")
	  end
	end)
end)