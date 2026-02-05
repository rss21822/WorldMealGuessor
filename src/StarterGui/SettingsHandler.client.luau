
--[[
local openSettingsButton = script.Parent.ScreenGui:WaitForChild("MenuFrame"):WaitForChild("SettingsButtonFrame"):WaitForChild("SettingsMenuButton")

local SettingsFrame = script.Parent.ScreenGui:WaitForChild("SettingsFrame")
local closeButton = SettingsFrame:WaitForChild("MainFrame"):WaitForChild("CloseButton")



openSettingsButton.Activated:Connect(function()
	
	SettingsFrame.Visible = not SettingsFrame.Visible
		
	if SettingsFrame.Visible == true then
		game.Lighting.Blur.Enabled = true
	else
		game.Lighting.Blur.Enabled = false
	end
end)

closeButton.Activated:Connect(function()
	SettingsFrame.Visible = false
	
	game.Lighting.Blur.Enabled = false
end)--]]