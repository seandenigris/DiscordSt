tests
testLoginPasswordDoesNotMatch
	self startMockServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	self mockServerDelegate map: '/api/auth/login' to: [ :request :response |
		self mockServerRequests add: request.
		response 
			entity: (ZnEntity text: '{"password": ["Password does not match."]}');
			setContentType: ZnMimeType applicationJson.
		response statusLine
			code: 400;
			reason: 'BAD REQUEST'.
		response. ].
	api email: self constants emailString password: self constants passwordString.
	self should: [ api login ] raise: DSCannotLoginError withExceptionDo: [ :exception | 
		self assert: exception response notNil.
		self assert: exception response code = 400.
		self assert: exception response contents equals: '{"password": ["Password does not match."]}' ].
	self deny: api isAuthenticated.
	self assert: api token isNil.
	self assert: self mockServerRequests size equals: 1.
	self assert: self mockServerRequests first contents equals: '{"email":"email@example.com","password":"secret password"}'.
	self assert: self mockServerRequests first method equals: #POST.