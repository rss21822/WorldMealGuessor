
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player:SetAttribute("isShielded", false) -- Default value
end)