'**********************************************************
'**  test__CarShowProcessor.brs
'**
'**********************************************************

'@TestSuite [CSP]

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It Data Processing Tests
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test CSP__TestInvalidData
Sub CSP__TestInvalidData()
    csp = CreateCarShowProcessor(invalid)

    ' Check that we have a invalid value returned
    m.AssertInvalid(csp.ProcessData())
End Sub

'@Test CSP__TestEmptyData
Sub CSP__TestEmptyData()
    csp = CreateCarShowProcessor({})

    ' Check that we have a invalid value returned
    m.AssertInvalid(csp.ProcessData())
End Sub

'@Test CSP__TestValidData
'@Params [ true, [{name:"New York Car Show",cars:[{make:"Hondaka",model:"Elisa"},{make:"George Motors",model:"George 15"},{make:"Julio Mechannica",model:"Mark 1"},{make:"Moto Tourismo",model:"Cyclissimo"},{make:"Edison Motors",model:""}]},{name:"Melbourne Motor Show","cars":[{make:"Julio Mechannica",model:"Mark 4S"},{make:"Hondaka",model:"Elisa"},{make:"Moto Tourismo",model:"Cyclissimo"},{make:"George Motors",model:"George 15"},{make:"Moto Tourismo",model:"Delta 4"}]},{name:"Cartopia","cars":[{make:"Moto Tourismo",model:"Cyclissimo"},{make:"George Motors",model:"George 15"},{make:"Hondaka",model:"Ellen"},{make:"Moto Tourismo",model:"Delta 16"},{make:"Moto Tourismo",model:"Delta 4"},{make:"Julio Mechannica",model:"Mark 2"}]},{name:"Carographic","cars":[{make:"Hondaka",model:"Elisa"},{make:"Hondaka",model:"Elisa"},{make:"Julio Mechannica",model:"Mark 4"},{make:"Julio Mechannica",model:"Mark 2"},{make:"Moto Tourismo"},{make:"Julio Mechannica",model:"Mark 4"}]},{"cars":[{make:"Moto Tourismo",model:"Delta 4"}]}], "Hondaka     Elisa         New York Car Show         Melbourne Motor Show         Carographic     Ellen         Cartopia George Motors     George 15         New York Car Show         Melbourne Motor Show         Cartopia Julio Mechannica     Mark 1         New York Car Show     Mark 4S         Melbourne Motor Show     Mark 2         Cartopia         Carographic     Mark 4         Carographic Moto Tourismo     Cyclissimo         New York Car Show         Melbourne Motor Show         Cartopia     Delta 4         Melbourne Motor Show         Cartopia     Delta 16         Cartopia "]
'@Params [ false, [{name:"New York Car Show",cars:[{make:"Hondaka",model:""},{make:"George Motors",model:"George 15"},{make:"Julio Mechannica",model:"Mark 1"},{make:"Moto Tourismo",model:"Cyclissimo"},{make:"Edison Motors",model:""}]},{name:"Melbourne Motor Show","cars":[{make:"Julio Mechannica",model:"Mark 4S"},{make:"Hondaka",model:"Elisa"},{make:"Moto Tourismo",model:"Cyclissimo"},{make:"George Motors",model:"George 15"},{make:"Moto Tourismo",model:"Delta 4"}]},{name:"Cartopia","cars":[{make:"Moto Tourismo",model:"Cyclissimo"},{make:"George Motors",model:"George 15"},{make:"Hondaka",model:"Ellen"},{make:"Moto Tourismo",model:"Delta 16"},{make:"Moto Tourismo",model:"Delta 4"},{make:"Julio Mechannica",model:"Mark 2"}]},{name:"Carographic","cars":[{make:"Hondaka",model:"Elisa"},{make:"Hondaka",model:"Elisa"},{make:"Julio Mechannica",model:"Mark 4"},{make:"Julio Mechannica",model:"Mark 2"},{make:"Moto Tourismo"},{make:"Julio Mechannica",model:"Mark 4"}]},{"cars":[{make:"Moto Tourismo",model:"Delta 4"}]}], "Hondaka     Elisa         New York Car Show         Melbourne Motor Show         Carographic     Ellen         Cartopia George Motors     George 15         New York Car Show         Melbourne Motor Show         Cartopia Julio Mechannica     Mark 1         New York Car Show     Mark 4S         Melbourne Motor Show     Mark 2         Cartopia         Carographic     Mark 4         Carographic Moto Tourismo     Cyclissimo         New York Car Show         Melbourne Motor Show         Cartopia     Delta 4         Melbourne Motor Show         Cartopia     Delta 16         Cartopia "]
'@Params [ false, [{name:"New York Car Show",cars:[{make:"George Motors",model:"George 15"},{make:"Julio Mechannica",model:"Mark 1"},{make:"Moto Tourismo",model:"Cyclissimo"},{make:"Edison Motors",model:""}]},{name:"Melbourne Motor Show","cars":[{make:"Julio Mechannica",model:"Mark 4S"},{make:"Hondaka",model:"Elisa"},{make:"Moto Tourismo",model:"Cyclissimo"},{make:"George Motors",model:"George 15"},{make:"Moto Tourismo",model:"Delta 4"}]},{name:"Cartopia","cars":[{make:"Moto Tourismo",model:"Cyclissimo"},{make:"George Motors",model:"George 15"},{make:"Hondaka",model:"Ellen"},{make:"Moto Tourismo",model:"Delta 16"},{make:"Moto Tourismo",model:"Delta 4"},{make:"Julio Mechannica",model:"Mark 2"}]},{name:"Carographic","cars":[{make:"Hondaka",model:"Elisa"},{make:"Hondaka",model:"Elisa"},{make:"Julio Mechannica",model:"Mark 4"},{make:"Julio Mechannica",model:"Mark 2"},{make:"Moto Tourismo"},{make:"Julio Mechannica",model:"Mark 4"}]},{"cars":[{make:"Moto Tourismo",model:"Delta 4"}]}], "Hondaka     Elisa         New York Car Show         Melbourne Motor Show         Carographic     Ellen         Cartopia George Motors     George 15         New York Car Show         Melbourne Motor Show         Cartopia Julio Mechannica     Mark 1         New York Car Show     Mark 4S         Melbourne Motor Show     Mark 2         Cartopia         Carographic     Mark 4         Carographic Moto Tourismo     Cyclissimo         New York Car Show         Melbourne Motor Show         Cartopia     Delta 4         Melbourne Motor Show         Cartopia     Delta 16         Cartopia "]
Sub CSP__TestValidData(expectedResult as Boolean, data as Object, expectedString as string)
    ' Test data is converted into an array for processing
    csp = CreateCarShowProcessor(data)

    ' Check that we have a invalid value returned
    m.AssertNotInvalid(csp.ProcessData())
    ' Replace the newlines to make the test parameter easier to deal with
    if (expectedResult) then
        m.AssertEqual(expectedString, csp.MakePrintableString().Replace(chr(13), " "))
    else
        m.AssertNotEqual(expectedString, csp.MakePrintableString().Replace(chr(13), " "))
    end if
End Sub

