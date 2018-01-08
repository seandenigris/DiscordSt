tests
testSendMessageToGuildTextOrDMChannelId
	| message returnedMessage |
	self startMockServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self constants tokenString.
	self mockServerDelegate map: '/api/channels/channel-id/messages' to: [ :request :response |
		self mockServerRequests add: request.
		response entity: (ZnEntity text: '{"nonce": null, "attachments": [], "tts": false, "embeds": [], "timestamp": "2017-05-08T15:56:48.149000+00:00", "mention_everyone": false, "id": "1234", "pinned": false, "edited_timestamp": null, "author": {"username": "User one", "discriminator": "5678", "id": "9012", "avatar": null}, "mention_roles": [], "content": "text message", "channel_id": "channel-id", "mentions": [], "type": 0}') ].
	message := DSClientJsonPost new content: 'message one'; yourself.
	returnedMessage := api sendMessage: message toGuildTextOrDMChannelId: 'channel-id' signalProgress: false.
	self assert: returnedMessage notNil.
	self assert: returnedMessage content equals: 'text message'.
	self assert: returnedMessage restApi == api description: 'It should have the api object'.
	self assert: self mockServerRequests size equals: 1.
	self assert: self mockServerRequests first method equals: #POST.