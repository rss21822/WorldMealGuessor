local TextChatService = game:GetService("TextChatService")

TextChatService.OnIncomingMessage = function(textChatMessage)
	if textChatMessage.Metadata == "Roblox.Team.Success.NowInTeam" then
		local override = Instance.new("TextChatMessageProperties")
		override.Text = " " -- note the intentional whitespace is included int he string
		return override
	end
end