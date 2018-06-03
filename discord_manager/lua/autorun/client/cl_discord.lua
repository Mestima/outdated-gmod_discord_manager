
net.Receive("MDiscord_PostToChat", function(len)
	local username = net.ReadString()
	local message = net.ReadString()
	chat.AddText(Color(66, 140, 244, 255), "[Discord] ", Color(145, 191, 255, 255), username, Color(255, 255, 255, 255), ": ", Color(255, 255, 255, 255), message)
end)

concommand.Add("discord_copyright", function(ply, cmd, args)
local copyright = {}
copyright[1] = [[
##############################################################
#|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|#
#|                       COPYRIGHT                          |#
#|__________________________________________________________|#
##############################################################
]]

copyright[2] = [[
##############################################################
#|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|#
#|                       MESTIMA                            |#
#|                        ©2018                             |#
#|   http://steamcommunity.com/profiles/76561198085223514   |#
#|__________________________________________________________|#
##############################################################
]]

for i=1,2 do print(copyright[i]) end
end)