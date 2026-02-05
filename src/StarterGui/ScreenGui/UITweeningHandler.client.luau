local ScreenGui = script.Parent

local PowerupButtonsFolder = ScreenGui:FindFirstChild("PowerupButtonsFolder")
--[[
local imageLabelTable = {
	PowerupButtonsFolder:FindFirstChild("ShieldFrame"),
	PowerupButtonsFolder:FindFirstChild("OofAllFrame"),
	PowerupButtonsFolder:FindFirstChild("PlusSpeedFrame"),
	PowerupButtonsFolder:FindFirstChild("SetFireFrame"),
	PowerupButtonsFolder:FindFirstChild("MinusSpeedFrame"),
	PowerupButtonsFolder:FindFirstChild("PlusSpeedFrame")
}--]]

for _, imageLabel in pairs(PowerupButtonsFolder:GetDescendants()) do
	if imageLabel:IsA("ImageButton") then -- Make sure it's an ImageLabel
		local originalSize = imageLabel.Size -- Store the original size
		local hoverSize = UDim2.new(originalSize.X.Scale * 1.1, 0, originalSize.Y.Scale * 1.1, 0) -- Slightly bigger

		imageLabel.MouseEnter:Connect(function()
			imageLabel:TweenSize(hoverSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
		end)

		imageLabel.MouseLeave:Connect(function()
			imageLabel:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
		end)
	end
end

for _, imageLabel in pairs(ScreenGui:FindFirstChild("ConfirmPurchaseFrame"):GetDescendants()) do
	if imageLabel:IsA("ImageButton") or imageLabel:IsA("TextButton") then -- Make sure it's an ImageLabel
		local originalSize = imageLabel.Size -- Store the original size
		local hoverSize = UDim2.new(originalSize.X.Scale * 1.1, 0, originalSize.Y.Scale * 1.1, 0) -- Slightly bigger

		imageLabel.MouseEnter:Connect(function()
			imageLabel:TweenSize(hoverSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
		end)

		imageLabel.MouseLeave:Connect(function()
			imageLabel:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
		end)
	end
end