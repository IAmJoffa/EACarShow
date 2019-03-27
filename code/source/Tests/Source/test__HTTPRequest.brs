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
    m.AssertAAHasKeys(request, ["GetToString", "GetFailureReason", "urlTransfer"])
    m.AssertTrue(request.Keys().Count() = 3)
End Sub

