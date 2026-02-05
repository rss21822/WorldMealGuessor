

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local devProductId = 3278571793

local confirmPurchaseFrame = script.Parent

local closeImageButton = confirmPurchaseFrame:FindFirstChild("CloseImageButton")
local buyTextButton = confirmPurchaseFrame:FindFirstChild("BuyTextButton")
local purchaseTitleTextLabel = confirmPurchaseFrame:FindFirstChild("PurchaseTitleTextLabel")

local purchasePowerupRE = ReplicatedStorage:FindFirstChild("PurchasePowerup")

closeImageButton.Activated:Connect(function()
	
	confirmPurchaseFrame.Visible = false

end)

buyTextButton.Activated:Connect(function()
	
	if purchaseTitleTextLabel.Text == "+Speed" then
		purchasePowerupRE:FireServer("plusSpeed")
		
		confirmPurchaseFrame.Visible = false
		
	elseif purchaseTitleTextLabel.Text == "+Health" then
		purchasePowerupRE:FireServer("plusHealth")
		confirmPurchaseFrame.Visible = false
	elseif purchaseTitleTextLabel.Text == "Shield" then
		purchasePowerupRE:FireServer("shield")
		confirmPurchaseFrame.Visible = false
	elseif purchaseTitleTextLabel.Text == "-Speed" then
		purchasePowerupRE:FireServer("minusSpeed")
		confirmPurchaseFrame.Visible = false
	elseif purchaseTitleTextLabel.Text == "Set Fire" then
		purchasePowerupRE:FireServer("setFire")
		confirmPurchaseFrame.Visible = false
	elseif purchaseTitleTextLabel.Text == "Oof All" then
		
		MarketplaceService:PromptProductPurchase(game.Players.LocalPlayer, devProductId)
		confirmPurchaseFrame.Visible = false
		
	end
	
	
end)