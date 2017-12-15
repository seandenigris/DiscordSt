tests
testOnLoginRequestDo
	| resultEmail resultPassword |
	morph := self classToTest filled.
	morph onLoginRequestDo: [ :email :password | resultEmail := email. resultPassword := password ].
	window := morph openInWindow.
	morph submorphs third simulateClick.
	self assert: resultEmail equals: 'contact@example.com'.
	self assert: resultPassword equals: 'secret password'.
	