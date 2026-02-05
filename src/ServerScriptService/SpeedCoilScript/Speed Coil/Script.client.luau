script.Parent.Equipped:Connect(function()
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 42
end)

script.Parent.Unequipped:Connect(function()
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 24
end)