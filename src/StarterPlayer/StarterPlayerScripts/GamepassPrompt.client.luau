local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local promptEvent = ReplicatedStorage:WaitForChild("PromptGamepassPurchase")

promptEvent.OnClientEvent:Connect(function(gamepassId)
	local player = game.Players.LocalPlayer
	MarketplaceService:PromptGamePassPurchase(player, gamepassId)
end)
