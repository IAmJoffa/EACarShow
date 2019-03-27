'**********************************************************
'**  test__HTTPRequest.brs
'**
'**********************************************************

'@TestSuite [HTTPRequest]

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It Constructor Tests
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

' Tests to see if our Proxy object has been created correctly
'
'@Test HTTPRequest__TestConstructor
Sub HTTPRequest__TestConstructor()
    request = CreateHTTPRequest()

    ' Assert that the object has been created correctly
    m.AssertNotInvalid(request)

    ' Make sure that no one has changed the keys on us, this protects the interface to the
    ' object from being changed and no Unit Tests being created for it
    m.AssertAAHasKeys(request, ["GetToString", "GetFailureReason", "urlTransfer"])
    m.AssertTrue(request.Keys().Count() = 3)
End Sub

