local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")

local textLabel = script.Parent

if humanoid then
	local lastHealth = humanoid.Health  -- Store initial health

	humanoid.HealthChanged:Connect(function(newHealth)
		local healthLost = lastHealth - newHealth  -- Calculate HP lost
		if healthLost > 0 then  -- Ensure only damage (not healing) is displayed
			textLabel.Text = "-" .. math.floor(healthLost) .. " HP"
			textLabel.TextColor3 = Color3.new(1, 0, 0)  -- Red color for damage

			-- OPTIONAL: Fade out after a short time
			textLabel.TextTransparency = 0
			game:GetService("TweenService"):Create(
				textLabel, 
				TweenInfo.new(3, Enum.EasingStyle.Linear), 
				{TextTransparency = 1}
			):Play()
		end

		lastHealth = newHealth  -- Update lastHealth for next calculation
	end)
end