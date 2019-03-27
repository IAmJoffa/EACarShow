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

