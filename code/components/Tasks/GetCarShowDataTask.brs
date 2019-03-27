'------------------------------------------------
' Task for loading our data from the API
'
' The task runs in a Thread but be careful of
' Thread to Scene Graph data handling rules.
'
' See Roku documentation for further details.
'------------------------------------------------

' Init - Initialises the Task. Here we just start the Task
' by assigning the function name to the interface parameter
' m.top.functionName
Sub Init()
    print "GetCarShowDataTask:Init()"

    ' Set Function Name
    m.top.functionName = "RunGetCarShowDataTask"
End Sub


' RunGetCarShowDataTask - This function is called when the Task runs.
' We need to set the 'state' to Done via the Control interface Parameter. This
' guarantees that any Observers looking at the 'state' will be correctly notified.
Sub RunGetCarShowDataTask()
    print "GetCarShowDataTask:RunGetCarShowDataTask() : in"

    ' Start Timer
    timeoutTimer = CreateObject("roTimespan")

    ' Timeout
    timeout = m.top.timeout

    ' Copy the URL (as it might go invalid any time!)
    httpUrl = m.top.url

    ' Only proceed if the URL was passed in successfully
    if (httpUrl <> invalid and httpUrl <> "") then
        print "Getting Data from URL: " + httpUrl

        ' Create the request
        request = CreateHTTPRequest()
        request.urlTransfer.AddHeader("accept", "application/json")
        request.urlTransfer.SetRequest("GET")
        request.urlTransfer.SetUrl(httpUrl)

        ' In this case just get the response as a string. Normally we would get
        ' the status code from the response and process the results based on that.
        response = request.GetToString()

        ' Got something from the server then we parse it and return it
        ' to the caller via the response interface parameter
        if (true)'response <> "") then
            m.top.response = { content: [{name:"New York Car Show",cars:[{make:"Hondaka",model:"Elisa"},{make:"George Motors",model:"George 15"},{make:"Julio Mechannica",model:"Mark 1"},{make:"Moto Tourismo",model:"Cyclissimo"},{make:"Edison Motors",model:""}]},{name:"Melbourne Motor Show","cars":[{make:"Julio Mechannica",model:"Mark 4S"},{make:"Hondaka",model:"Elisa"},{make:"Moto Tourismo",model:"Cyclissimo"},{make:"George Motors",model:"George 15"},{make:"Moto Tourismo",model:"Delta 4"}]},{name:"Cartopia","cars":[{make:"Moto Tourismo",model:"Cyclissimo"},{make:"George Motors",model:"George 15"},{make:"Hondaka",model:"Ellen"},{make:"Moto Tourismo",model:"Delta 16"},{make:"Moto Tourismo",model:"Delta 4"},{make:"Julio Mechannica",model:"Mark 2"}]},{name:"Carographic","cars":[{make:"Hondaka",model:"Elisa"},{make:"Hondaka",model:"Elisa"},{make:"Julio Mechannica",model:"Mark 4"},{make:"Julio Mechannica",model:"Mark 2"},{make:"Moto Tourismo"},{make:"Julio Mechannica",model:"Mark 4"}]},{"cars":[{make:"Moto Tourismo",model:"Delta 4"}]}], failureReason: "" }
'            m.top.response = { content: response, failureReason: "" }
        else
            m.top.response = { content: invalid, failureReason: request.GetFailureReason() }
        end if
    else
        print "URL not provided"
    end if

    ' Flag that the task is complete
    m.top.control = "done"
    print "GetCarShowDataTask:RunGetCarShowDataTask() : out"
End Sub