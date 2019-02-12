
util.AddNetworkString("MDiscord_PostToChat")

MDiscord = {}
MDiscord.storage = {}
MDiscord.storage.received = {}
MDiscord.storage.lastMsg = 1

local function Init()
	if not file.Exists("mestima_save","DATA") then file.CreateDir("mestima_save") end
	if not file.Exists("mestima_save/discord.txt","DATA") then file.Write("mestima_save/discord.txt", util.TableToJSON(MDiscord.storage)) end
	
	MDiscord.storage = util.JSONToTable(file.Read("mestima_save/discord.txt","DATA"))
	timer.Create("DiscordMessageGetter", 3, 0, function() if not MDiscord.storage.token or not MDiscord.storage.channel then return end GetMessages() end)
end

local function UpdateURL(url)
	if not file.Exists("mestima_save","DATA") then file.CreateDir("mestima_save") end
	if not file.Exists("mestima_save/discord.txt","DATA") then file.Write("mestima_save/discord.txt","") end
	
	MDiscord.storage.url = tostring(url)
	file.Write("mestima_save/discord.txt", util.TableToJSON(MDiscord.storage))
end

local function UpdateMODE(gamemode)
	if not file.Exists("mestima_save","DATA") then file.CreateDir("mestima_save") end
	if not file.Exists("mestima_save/discord.txt","DATA") then file.Write("mestima_save/discord.txt","") end
	
	MDiscord.storage.gm = tostring(gamemode)
	file.Write("mestima_save/discord.txt", util.TableToJSON(MDiscord.storage))
end

local function UpdateToken(token)
	if not file.Exists("mestima_save","DATA") then file.CreateDir("mestima_save") end
	if not file.Exists("mestima_save/discord.txt","DATA") then file.Write("mestima_save/discord.txt","") end
	
	MDiscord.storage.token = tostring(token)
	file.Write("mestima_save/discord.txt", util.TableToJSON(MDiscord.storage))
end

local function UpdateChannel(channel)
	if not file.Exists("mestima_save","DATA") then file.CreateDir("mestima_save") end
	if not file.Exists("mestima_save/discord.txt","DATA") then file.Write("mestima_save/discord.txt","") end
	
	MDiscord.storage.channel = tostring(channel)
	file.Write("mestima_save/discord.txt", util.TableToJSON(MDiscord.storage))
end

local function RPSend(ply, text, team)
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
	
		http.Post("https://" .. MDiscord.storage.url, {content = msg, username = name})
	end
end

local function SandboxSend(ply, text, team)
	local msg = text
	local name = ""
	
	if team == true then name = name .. "(TEAM) " end
	if ply:Alive() == false then name = name .. "*DEAD* " end
	name = name .. ply:Nick()
	
	http.Post("https://" .. MDiscord.storage.url, {content = msg, username = name})
end

local function GetFromDiscord(body,len,headers,code)
	local content = util.JSONToTable(body)
	for i = MDiscord.storage.lastMsg, #content do
		if content[i].author.bot == true then goto skip end
		for k,v in pairs(MDiscord.storage.received) do if v == content[i].id then goto skip end end
		
		table.insert(MDiscord.storage.received, content[i].id)
		file.Write("mestima_save/discord.txt", util.TableToJSON(MDiscord.storage))
		local username = content[i].author.username
		local msg = content[i].content
	
		net.Start("MDiscord_PostToChat")
			net.WriteString(username)
			net.WriteString(msg)
		net.Broadcast()
		::skip::
	end
end

local function GetMessages()
	http.Fetch("https://discordapp.com/api/channels/" .. MDiscord.storage.channel .. "/messages?token=".. MDiscord.storage.token, GetFromDiscord)
end

hook.Add("Initialize", "MDiscordInit", function() Init() end)
hook.Add("PlayerSay", "MDiscordSend", function(ply, text, team) if MDiscord.storage.gm == "darkrp" then RPSend(ply, text, team) else SandboxSend(ply, text, team) end end)

concommand.Add("discord_set_url", function(ply, cmd, args)
	if ply:IsSuperAdmin() == false then return end
	local a = args
	local url = ""
	for k,v in pairs(a) do url = url .. v end
	UpdateURL(url)
end)

concommand.Add("discord_gm_darkrp", function(ply, cmd, args)
	if ply:IsSuperAdmin() == false then return end
	MDiscord.storage.gm = "darkrp"
	file.Write("mestima_save/discord.txt", util.TableToJSON(MDiscord.storage))
end)

concommand.Add("discord_gm_sandbox", function(ply, cmd, args)
	if ply:IsSuperAdmin() == false then return end
	MDiscord.storage.gm = "sandbox"
	file.Write("mestima_save/discord.txt", util.TableToJSON(MDiscord.storage))
end)

concommand.Add("discord_set_token", function(ply, cmd, args)
	if ply:IsSuperAdmin() == false then return end
	local a = args
	local token = ""
	for k,v in pairs(a) do token = token .. v end
	UpdateToken(token)
end)

concommand.Add("discord_set_channel", function(ply, cmd, args)
	if ply:IsSuperAdmin() == false then return end
	local a = args
	local channel = ""
	for k,v in pairs(a) do channel = channel .. v end
	UpdateChannel(channel)
end)
