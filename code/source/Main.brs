
' Main function for the Application
' It all gets launched from here
Sub Main(args as Object)
    print "Main:Main()"

    ' Run the Test Harness if it exists
    if (args.run <> invalid and args.run = "test" and type(Rooibos__Init) = "Function") then 
        Rooibos__Init(args, invalid, invalid, "TestsScene")
    end if

    'Indicate this is a Roku SceneGraph application'
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    'Create a scene and load /components/helloworld.xml'
    scene = screen.CreateScene("MainScene")
    print "Main:MainScene Created"
    screen.show()

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
End Sub

