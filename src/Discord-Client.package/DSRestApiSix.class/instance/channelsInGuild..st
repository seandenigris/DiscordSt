public - guild
channelsInGuild: aDSUserGuild
	"Return Guild Channel objects.
	See https://discordapp.com/developers/docs/resources/guild#get-guild-channels"
	^ (self guildChannelsUsingId: aDSUserGuild id)