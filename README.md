# gmod_discord_manager
It is simple tool to send messages from Gmod server chat to your discord server.

### HOW TO SET UP DISCORD MANAGER ###
1. Go to your discord server and create new webhook.
2. Copy your webhook url.
3. Remove https:// from your webhook url. It is important!
4. Go to your gmod server and type into your console discord_set_url your_url_without_https://
For example: discord_set_url discordapp.com/api/webhooks/short_id/long_id

5. Choose your server gamemode. You should use special console commands:
discord_gm_darkrp (it will send only OOC messages to your discord server)
discord_gm_sandbox (it will send all messages to your discord server)

Done!
You should set it up ONLY ONE time!

Command list:
discord_help -- shows addons set up help
discord_copyright -- shows author's copyright
discord_gm_sandbox -- set up sandbox gamemode to discord manager
discord_gm_darkrp -- set up darkrp gamemode to discord manager
discord_set_url -- set up discord webhook url
