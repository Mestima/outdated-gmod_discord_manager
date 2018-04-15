
if SERVER then
MDiscord = {}
MDiscord.settings = {}

function MDiscord:Init()
	if not file.Exists("mestima_save","DATA") then file.CreateDir("mestima_save") end
	if not file.Exists("mestima_save/discord.txt","DATA") then file.Write("mestima_save/discord.txt", util.TableToJSON(self.settings)) end
	
	self.settings = util.JSONToTable(file.Read("mestima_save/discord.txt","DATA"))
end

function MDiscord:UpdateURL(url)
	if not file.Exists("mestima_save","DATA") then file.CreateDir("mestima_save") end
	if not file.Exists("mestima_save/discord.txt","DATA") then file.Write("mestima_save/discord.txt","") end
	
	self.settings.url = tostring(url)
	file.Write("mestima_save/discord.txt", util.TableToJSON(self.settings))
end

function MDiscord:UpdateMODE(gamemode)
	if not file.Exists("mestima_save","DATA") then file.CreateDir("mestima_save") end
	if not file.Exists("mestima_save/discord.txt","DATA") then file.Write("mestima_save/discord.txt","") end
	
	self.settings.gm = tostring(gamemode)
	file.Write("mestima_save/discord.txt", util.TableToJSON(self.settings))
end

function MDiscord:RPSend(ply, text, team)
	local msg = text
	if string.len(msg) < 4 then return end
	if string.sub(msg,1,3) == "///" then return end
	if string.sub(msg,1,3) == "/ad" then return end
	if string.sub(msg,1,2) == "//" or string.sub(msg,1,2) == "/a" or string.sub(msg,1,4) == "/ooc" then
		msg = string.gsub(msg,"// ","")
		msg = string.gsub(msg,"/a ","")
		msg = string.gsub(msg,"/ooc ","")
		local name = ""
	
		if team == true then name = name .. "(TEAM) " end
		if ply:Alive() == false then name = name .. "*DEAD* " end
		name = name .. ply:Nick()
	
		http.Post("https://" .. self.settings.url, {content = msg, username = name})
	end
end

function MDiscord:SandboxSend(ply, text, team)
	local msg = text
	local name = ""
	
	if team == true then name = name .. "(TEAM) " end
	if ply:Alive() == false then name = name .. "*DEAD* " end
	name = name .. ply:Nick()
	
	http.Post("https://" .. self.settings.url, {content = msg, username = name})
end

hook.Add("Initialize", "MDiscordInit", function() MDiscord:Init() end)
hook.Add("PlayerSay", "MDiscordSend", function(ply, text, team) if MDiscord.settings.gm == "darkrp" then MDiscord:RPSend(ply, text, team) else MDiscord:SandboxSend(ply, text, team) end end)

concommand.Add("discord_set_url", function(ply, cmd, args)
	if ply:IsSuperAdmin() == false then return end
	local a = args
	local url = ""
	for k,v in pairs(a) do url = url .. v end
	MDiscord:UpdateURL(url)
end)

concommand.Add("discord_gm_darkrp", function(ply, cmd, args)
	if ply:IsSuperAdmin() == false then return end
	MDiscord.settings.gm = "darkrp"
	file.Write("mestima_save/discord.txt", util.TableToJSON(MDiscord.settings))
end)

concommand.Add("discord_gm_sandbox", function(ply, cmd, args)
	if ply:IsSuperAdmin() == false then return end
	MDiscord.settings.gm = "sandbox"
	file.Write("mestima_save/discord.txt", util.TableToJSON(MDiscord.settings))
end)
end

if CLIENT then
concommand.Add("discord_help", function(ply, cmd, args)
local text = [[
### HOW TO SET UP DISCORD MANAGER ###
1. Go to your discord server and create new webhook.
2. Copy your webhook url.
3. Remove https:// from your webhook url. It is important!
4. Go to your gmod server and type into your console discord_set_url your_url_without_https://
For example: discord_set_url discordapp.com/api/webhooks/000000000000000000/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

5. Choose your server gamemode. You should use special console commands:
discord_gm_darkrp (it will send only OOC messages to your discord server)
discord_gm_sandbox (it will send all messages to your discord server)

Done!
]]
print(text)
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
#|          ЭТОТ БЫДЛОКОД НАКОДИЛ MESTIMA!
#|          ВЫ МОЖЕТЕ ДЕЛАТЬ С ЭТИМ БЫДЛОКОДОМ ВСЕ,
#|          ЧТО ВАМ СНИТСЯ В ВАШИХ МОКРЫХ СНАХ,
#|          НО ПЕРЕД ЭТИМ ОБЯЗАТЕЛЬНО ДАЙТЕ ЗНАТЬ
#|          ОБ ЭТОМ АВТОРУ ДАННОГО БЫДЛОКОДА!
#|          ЕМУ БУДЕТ ОЧЕНЬ ПРИЯТНО ЗНАТЬ, ЧТО КОМУ-ТО
#|          НУЖЕН ЕГО БЫДЛОКОД <3
#|__________________________________________________________|#
##############################################################
]]

copyright[3] = [[
##############################################################
#|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|#
#|          THIS SCRIPT CODED BY MESTIMA!                   |#
#|          YOU CAN DO WITH THAT CODE WHATEVER              |#
#|          YOU WANT, BUT LET AUTHOR KNOW ABOUT             |#
#|          THAT BEFORE YOU WILL DO THAT!                   |#
#|          IT WILL BE VERY NICE TO KNOW                    |#
#|          SOMEBODY NEEDS HIS SHITTY CODE <3               |#
#|__________________________________________________________|#
##############################################################
]]

copyright[4] = [[
##############################################################
#|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|#
#|                       MESTIMA                            |#
#|                        ©2018                             |#
#|   http://steamcommunity.com/profiles/76561198085223514   |#
#|__________________________________________________________|#
##############################################################
]]

for i=1,4 do print(copyright[i]) end
end)
end
