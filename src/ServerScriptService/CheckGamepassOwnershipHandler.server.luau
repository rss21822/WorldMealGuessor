local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create a RemoteFunction for checking GamePass ownership
local checkIfPlayerOwnsGamepassRF = ReplicatedStorage:WaitForChild("CheckIfPlayerOwnsGamepass")

-- Function to check gamepass ownership
checkIfPlayerOwnsGamepassRF.OnServerInvoke = function(player, targetPlayerId, gamepassId)
	if not targetPlayerId or not gamepassId then return false end
	return MarketplaceService:UserOwnsGamePassAsync(targetPlayerId, gamepassId)
end
