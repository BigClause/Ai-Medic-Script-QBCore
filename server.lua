QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('clause-aimedic:docOnline', function(source, cb)
	local src = source
	local Ply = QBCore.Functions.GetPlayer(src)
	local xPlayers = QBCore.Functions.GetPlayers()
	local doctor = 0
	local canpay = false
	if Ply.PlayerData.money["cash"] >= Config.Price then
		canpay = true
	else
		if Ply.PlayerData.money["bank"] >= Config.Price then
			canpay = true
		end
	end

	for i=1, #xPlayers, 1 do
		local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
		if xPlayer.PlayerData.job.name == 'ambulance' and xPlayer.PlayerData.job.onduty then
			doctor = doctor + 1
		end
	end

	cb(doctor, canpay)
end)



RegisterServerEvent('clause-aimedic:charge')
AddEventHandler('clause-aimedic:charge', function()
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer.PlayerData.money["cash"] >= Config.Price then
		xPlayer.Functions.RemoveMoney("cash", Config.Price)
	else
		xPlayer.Functions.RemoveMoney("bank", Config.Price)
	end
	TriggerEvent("qb-management:server:addAccountMoney", 'ambulance', Config.Price) -- old qb, qb-bossmenu. New qb, change to qb-management. Only needed to add funds to ems society account.
end)
