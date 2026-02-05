local parts = {}

local gamepassId = nil

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local promptEvent = ReplicatedStorage:WaitForChild("PromptGamepassPurchase")


for i,v in pairs(game.Workspace.GamepassDisplays:GetDescendants()) do
	if v.Name == "TouchToBuy" then
		table.insert(parts, v)
	end
end

for i,v in pairs(parts) do
	v.Touched:Connect(function(hit)
		local player = game:GetService("Players"):GetPlayerFromCharacter(hit.Parent)
		if player then
			local gamepassId
			if v.Parent.Name == "SpyingAbilitiesDisplay" then
				gamepassId = 1117351622
			elseif v.Parent.Name == "GravityCoilDisplay" then
				gamepassId = 1116369869
			elseif v.Parent.Name == "SpeedCoilDisplay" then
				gamepassId = 1115915102
			elseif v.Parent.Name == "ProMemberDisplay" then
				gamepassId = 1115996940
			end

			if gamepassId then
				promptEvent:FireClient(player, gamepassId)
			end
		end
	end)
end

