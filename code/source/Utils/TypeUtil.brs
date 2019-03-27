'**********************************************************
'**  Type Utilities 
'**  
'**  Copyright (c) 2009 Roku Inc. All Rights Reserved.
'**********************************************************


' Determine if the given object supports the ifXMLElement interface
Function IsXMLElement(obj as dynamic) As Boolean
    return obj <> invalid and  GetInterface(obj, "ifXMLElement") <> invalid
End Function


' Determine if the given object supports the ifList interface
Function IsList(obj as dynamic) As Boolean
    return obj <> invalid and GetInterface(obj, "ifArray") <> invalid
End Function


'Determine if the given object supports the ifAssociativeArray interface
Function isobject(obj as dynamic) As Boolean
    return obj <> invalid and GetInterface(obj, "ifAssociativeArray") <> invalid
End function


' Determine if the given object supports the ifInt interface
Function IsInt(obj as dynamic) As Boolean
    return obj <> invalid and GetInterface(obj, "ifInt") <> invalid
End Function


' Determine if the given object supports the function interface
Function IsFunc(obj as dynamic) As Boolean
    tf = type(obj)
    return tf="Function" or tf="roFunction"
End Function


' Determine if the given object supports the ifString interface
Function IsStr(obj as dynamic) As Boolean
    return obj <> invalid and  GetInterface(obj, "ifString") <>invalid
End Function


' Determine if the given object supports the ifBoolean interface
Function IsBool(obj as dynamic) As Boolean
    if obj = invalid return false
    if GetInterface(obj, "ifBoolean") = invalid return false
    return true
End Function


' Determine if the given object supports the ifFloat interface
Function IsFloat(obj as dynamic) As Boolean
    if obj = invalid return false
    if GetInterface(obj, "ifFloat") = invalid return false
    return true
End Function


' Always return a valid string. if the argument is invalid or not a string, return an empty string.
Function ValidStr(obj As Object) As String
    if obj <> invalid and GetInterface(obj, "ifString") <> invalid
         return obj
    else
        return ""
    endif
End Function 


' Always return a valid integer. If the argument is invalid or not an integer, return zero.
Function ValidInt(obj As Dynamic) As Integer
    if obj <> invalid and GetInterface(obj, "ifInt") <> invalid
        return obj
    else
        return 0
    end if
End Function 


' Validate parameter is the correct type
Function ValidateParam(param As Object, paramType As String, functionName As String, allowInvalid = false) As Boolean
    if paramType = "roString" or paramType = "String" then
        if type(param) = "roString" or type(param) = "String" then
            return true
        end if
    else if type(param) = paramType then
        return true
    endif

    if allowInvalid = true then
        if type(param) = invalid then
            return true
        endif
    endif

    print "invalid parameter of type "; type(param); " for "; paramType; " in function "; functionName 
    return false
End Function


' Check the variable whether it is initialised, not invalid, the correct type and an optional expected value.
Function CheckVar(ref As Dynamic, expectedType As String, expectedValue = invalid As Dynamic, isFullCheck = true As Boolean) as Boolean
    ' Determine whether to do a proper check or a simple check (i.e. only check invalid).
    if not isFullCheck
        if ref <> invalid
            return true
        else
            return false
        end if
    end if
    
    if LCase(type(ref)).InStr("<uninitialized>") = -1 and ref <> invalid and LCase(type(ref)).InStr(LCase(expectedType)) > -1
        if expectedValue <> invalid
            return ref = expectedValue
        else
            return True
        end if
    else
        return False
    end if
End Function