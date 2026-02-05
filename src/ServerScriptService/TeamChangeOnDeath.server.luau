local Teams = game:GetService("Teams") -- Get the Teams service
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.Died:Connect(function()
				-- Change team on death
				if Teams:FindFirstChild("Lobby") then -- Ensure the team exists
					player.Team = Teams.Lobby
				end
			end)
		end
	end)
end)