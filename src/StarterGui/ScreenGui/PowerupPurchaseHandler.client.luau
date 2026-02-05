

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ScreenGui = script.Parent

local purchasePowerupRE = ReplicatedStorage:FindFirstChild("PurchasePowerup")


local PowerupButtonsFolder = ScreenGui:FindFirstChild("PowerupButtonsFolder")
local leftListFrame = PowerupButtonsFolder:FindFirstChild("LeftListFrame")
local rightListFrame = PowerupButtonsFolder:FindFirstChild("RightListFrame")

local confirmPurchaseFrame = ScreenGui:FindFirstChild("ConfirmPurchaseFrame")
local buyTextButton = confirmPurchaseFrame:FindFirstChild("BuyTextButton")

local shieldButton = leftListFrame:FindFirstChild("ShieldFrame"):FindFirstChild("ImageButton")
local oofAllButton = rightListFrame:FindFirstChild("OofAllFrame"):FindFirstChild("ImageButton")
local plusHealthButton = leftListFrame:FindFirstChild("PlusHealthFrame"):FindFirstChild("ImageButton")
local setFireButton = rightListFrame:FindFirstChild("SetFireFrame"):FindFirstChild("ImageButton")
local minusSpeedButton = rightListFrame:FindFirstChild("MinusSpeedFrame"):FindFirstChild("ImageButton")
local plusSpeedButton = leftListFrame:FindFirstChild("PlusSpeedFrame"):FindFirstChild("ImageButton")




shieldButton.Activated:Connect(function()
	
	confirmPurchaseFrame.Visible = true
	
	confirmPurchaseFrame:FindFirstChild("PurchaseTitleTextLabel").Text = "Shield"
	confirmPurchaseFrame:FindFirstChild("PurchaseDescriptionTextLabel").Text = "Protects you from all debuffs. Things such as -Speed and Set Fire won't affect you for 30 seconds"
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel").Text = "20 Coins"
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel").TextColor3 = Color3.fromRGB(255, 196, 29)
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel"):FindFirstChild("UIStroke").Color = Color3.fromRGB(255, 165, 20)
	

	--purchasePowerupRE:FireServer("Shield")
end)

oofAllButton.Activated:Connect(function()
	
	confirmPurchaseFrame.Visible = true

	confirmPurchaseFrame:FindFirstChild("PurchaseTitleTextLabel").Text = "Oof All"
	confirmPurchaseFrame:FindFirstChild("PurchaseDescriptionTextLabel").Text = "Oofs everyone in the server except you (OP)"
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel").Text = "49 Robux"
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel").TextColor3 = Color3.new(0.552941, 1, 0.133333)
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel"):FindFirstChild("UIStroke").Color = Color3.new(0.329412, 0.827451, 0)
	
	
	
	--purchasePowerupRE:FireServer("oofAll")
	
end)

plusHealthButton.Activated:Connect(function()
	
	confirmPurchaseFrame.Visible = true

	confirmPurchaseFrame:FindFirstChild("PurchaseTitleTextLabel").Text = "+Health"
	confirmPurchaseFrame:FindFirstChild("PurchaseDescriptionTextLabel").Text = "Buying this will give you +20 HP"
	
	print("Changin text")
	
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel").Text = "30 Coins"
	

	
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel").TextColor3 = Color3.fromRGB(255, 196, 29)
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel"):FindFirstChild("UIStroke").Color = Color3.fromRGB(255, 165, 20)

	--purchasePowerupRE:FireServer("plusHealth")
	
end)

setFireButton.Activated:Connect(function()
	
	confirmPurchaseFrame.Visible = true

	confirmPurchaseFrame:FindFirstChild("PurchaseTitleTextLabel").Text = "Set Fire"
	confirmPurchaseFrame:FindFirstChild("PurchaseDescriptionTextLabel").Text = "Sets fire to everyone in the game except you. This makes them loose 15 HP"
	
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel").Text = "50 Coins"
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel").TextColor3 = Color3.fromRGB(255, 196, 29)
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel"):FindFirstChild("UIStroke").Color = Color3.fromRGB(255, 165, 20)
	
	--purchasePowerupRE:FireServer("setFire")
end)

minusSpeedButton.Activated:Connect(function()
	
	confirmPurchaseFrame.Visible = true

	confirmPurchaseFrame:FindFirstChild("PurchaseTitleTextLabel").Text = "-Speed"
	confirmPurchaseFrame:FindFirstChild("PurchaseDescriptionTextLabel").Text = "Makes everyone except you walk slower for 10 seconds"
	
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel").Text = "30 Coins"
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel").TextColor3 = Color3.fromRGB(255, 196, 29)
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel"):FindFirstChild("UIStroke").Color = Color3.fromRGB(255, 165, 20)
	
	--purchasePowerupRE:FireServer("minusSpeed")
end)

plusSpeedButton.Activated:Connect(function()
	
	confirmPurchaseFrame.Visible = true

	confirmPurchaseFrame:FindFirstChild("PurchaseTitleTextLabel").Text = "+Speed"
	confirmPurchaseFrame:FindFirstChild("PurchaseDescriptionTextLabel").Text = "Makes you walk faster so that you can get around quickly for 15 seconds"
	
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel").Text = "10 Coins"
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel").TextColor3 = Color3.fromRGB(255, 196, 29)
	confirmPurchaseFrame:FindFirstChild("PurchaseCostTextLabel"):FindFirstChild("UIStroke").Color = Color3.fromRGB(255, 165, 20)
	
	
	
	--purchasePowerupRE:FireServer("plusSpeed")
end)

