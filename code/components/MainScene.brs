'------------------------------------------------
' Main Scene of the App
'
' Try and do as little in the Scene as possible
' to make the code cleaner.
'------------------------------------------------


' Init - This function initialises the Scene and any components within it
' It is a single Scene Application
Function Init()
    print "MainScene:Init() : in"
    
    ' Set the focus to the Scene
    m.top.setFocus(true)

    ' Configure the UI Components
    'Set the font size
    m.myLabel = m.top.FindNode("myLabel")
    m.myLabel.font.size = 10
    'Set the color to light blue, Next time define it in a constants file
    m.myLabel.color = "0x72D7EEFF"
    m.myLabel.wrap = true

    ' Create the Task to get the Car Show data
    m.task = CreateObject("roSGNode", "GetCarShowDataTask")
    m.task.url = "http://eacodingtest.digital.energyaustralia.com.au/api/v1/cars"
    m.task.ObserveField("response", "OnGetCarShowDataTaskResponseChanged")
    m.task.control = "RUN"

    print "MainScene:Init() : out"
End Function


' OnGetCarShowDataTaskResponseChanged - Called when the response to the
' HTTP call is completed
Sub OnGetCarShowDataTaskResponseChanged()
    print "MainScene:OnGetCarShowDataTaskResponseChanged(" + (m.task.response <> invalid).ToStr() + ")"

    if (m.task.response = invalid) then
        print "Fatal Error Getting the Data"
        return
    end if

    if (m.task.response.content <> invalid) then
        processor = CreateCarShowProcessor(m.task.response.content)
        processedData = processor.ProcessData()

        printableString = processor.MakePrintableString()
        m.myLabel.text = printableString
    else ' We have an error with the data.
        if (m.task.response.failureReason <> invalid and m.task.response.failureReason <> "") then
            print "Failure Reason: " + m.task.response.failureReason
        else
            print "Unknown Failure Reason"
        end if
    end if
End Sub

