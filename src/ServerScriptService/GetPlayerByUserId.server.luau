local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")


local GetPlayerByIdRF = ReplicatedStorage:WaitForChild("GetPlayerById")


GetPlayerByIdRF.OnServerInvoke = function(player, userId)
	return Players:GetPlayerByUserId(userId)
end