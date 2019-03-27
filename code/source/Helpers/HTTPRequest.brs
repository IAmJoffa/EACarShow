
' CreateHTTPRequest - Creates a new HTTP Request object stubbing some functions
' to allow them to be mocked/stubbed by the Test Harness
Function CreateHTTPRequest() as Object
    ' Create an empty Assoc array then we'll add the properties to it.
    m.this = {}
    m.this.urlTransfer = CreateObject("roUrlTransfer")
    m.this.GetToString = HTTPRequest_GetToString
    m.this.GetFailureReason = HTTPRequest_GetFailureReason

    return m.this
End Function


' HTTPRequest_GetToString
'
' Proxy function for the GetToString function
' We proxy these functions so that we can stub/mock them in
' our unit tests
Function HTTPRequest_GetToString() as String
    ' Make sure that this has been created
    if (m.urlTransfer = invalid) then
        print "HTTPRequest: Object not formed correctly"
        return ""
    end if

    ' Go and get the response data and return it
    ' For this simple example we'll just get the string
    responseData = m.urlTransfer.GetToString()
    return responseData
End function


' Stub to return the failure reason as a printable string
Function HTTPRequest_GetFailureReason() as String
    return m.urlTransfer.GetFailureReason()
End function

