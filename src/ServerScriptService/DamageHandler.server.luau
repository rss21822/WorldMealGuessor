
-- Services

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Teams = game:GetService("Teams")


-- Object References

local SendDistanceToServerRE = ReplicatedStorage:WaitForChild("SendDistanceToServer")
local updateOverheadNoticeRE = ReplicatedStorage:WaitForChild("UpdateOverheadNotice") 


SendDistanceToServerRE.OnServerEvent:Connect(function(player,distance)


	if player.Team == Teams["In-Game"] then

		local character = player.Character
		if character then
			local humanoid = character:FindFirstChild("Humanoid")
			if humanoid then
				
				if distance == 9999 then
					local healthLoss = math.clamp(distance*0.5, 0, 60) -- Min 5 HP, Max 50 HP
					humanoid.Health = math.max(0, humanoid.Health - healthLoss) -- Prevents negative health
					updateOverheadNoticeRE:FireClient(player, 100)
					
				else
				
					local healthLoss = math.clamp(distance*0.5, 0, 60) -- Min 5 HP, Max 50 HP
					humanoid.Health = math.max(0, humanoid.Health - healthLoss) -- Prevents negative health
					
					updateOverheadNoticeRE:FireClient(player, math.floor(healthLoss))
				end
			end
		end
	end

end)