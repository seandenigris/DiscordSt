test - sending
testSupressNetworkErrors
	"Post JSON entity"
	| response |
	self startZnServer.
	client := self classToTest new 
		url: self serverUrl;
		message: self messageString;
		supressNetworkErrors.
	server stop.
	response := client send.
	self assert: response isNil