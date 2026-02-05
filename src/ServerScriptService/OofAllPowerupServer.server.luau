
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local sendPowerupNotificationRE = ReplicatedStorage:FindFirstChild("SendPowerupNotification")

local devProductId = 3278571793  -- Replace with your actual Developer Product ID

-- Handle product purchase completion
MarketplaceService.ProcessReceipt = function(receiptInfo)
	if receiptInfo.ProductId == devProductId then

		
		local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
		
		
		
		if player then
			

			sendPowerupNotificationRE:FireAllClients(player, "Oof All")
			
			-- Kill all other players
			for _, otherPlayer in pairs(Players:GetPlayers()) do
				if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Humanoid") then
					otherPlayer.Character.Humanoid.Health = 0
				end
			end
		end
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	-- Not our product, let others handle it
	return Enum.ProductPurchaseDecision.NotProcessedYet
end
