enumerating
selectAttachments: aDSMessages
	<return: #DSMessages> 
	^ aDSMessages select: [ :message |
		message numberOfAttachments isZero not ]