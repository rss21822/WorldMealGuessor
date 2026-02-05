local TextChatService = game:GetService("TextChatService")
local MarketplaceService = game:GetService("MarketplaceService")

local OwnersName = {"HHMH07"} -- Put your Name or someones Name inside of Here
local DevelopersName = {"MeHuMan101"} -- Put your Name or someones Name inside of Here

local proMemberGamePassID = 1117351622 -- Replace with the actual GamePass ID

TextChatService.OnIncomingMessage = function(Message)

	

	local Player = game.Players:GetPlayerByUserId(Message.TextSource.UserId)

	if table.find(OwnersName, Player.Name) then

		local OwnerTag = "[Developer] "
		local OwnerColoredTag = "<font color='#FAB1A0'>"..OwnerTag.."</font>"

		Message.PrefixText = OwnerColoredTag..""..Message.PrefixText

	elseif table.find(DevelopersName, Player.Name) then

		local DeveloperTag = "[Tester] "
		local DeveloperColoredTag = "<font color='#81ECEC'>"..DeveloperTag.."</font>"

		Message.PrefixText = DeveloperColoredTag..""..Message.PrefixText
	elseif MarketplaceService:UserOwnsGamePassAsync(Player.UserId, proMemberGamePassID) then
		
		local OwnerTag = "[Pro Member] "
		local OwnerColoredTag = "<font color='#FEC104'>"..OwnerTag.."</font>"

		Message.PrefixText = OwnerColoredTag..""..Message.PrefixText
		
	end




end