local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local OverheadGui = ReplicatedStorage:WaitForChild("OverheadGui")

local GamePassID = 1117351622 -- Replace with the actual GamePass ID


Players.PlayerAdded:Connect(function(Player: Player)

	Player.CharacterAdded:Connect(function(Character)

		local OverheadGuiClone = OverheadGui:Clone()
		local UsernameLabel = OverheadGuiClone:WaitForChild("Frame").UsernameLabel

		if Player.Name == "MeHuMan101" then
			UsernameLabel.Text = "Tester"
			
		elseif Player.Name == "HHMH07" then
			
			UsernameLabel.Text = "Developer"
		
		elseif MarketplaceService:UserOwnsGamePassAsync(Player.UserId, GamePassID) then
			
			UsernameLabel.Text = "Pro Member"
		
		else 
			
			UsernameLabel.Text = ""
		
		end
		





		OverheadGuiClone.Parent = Character:FindFirstChild("Head")
	end)
end)
