

' IndexOf - Function to get the index of a value in an array.
Function IndexOf(array as Object, element as Dynamic, comparer = Invalid as Dynamic, comparee = Invalid as Dynamic) as Integer
    if IsList(array) then
        for i = 0 to array.count() - 1
            if isFunc(comparer) and comparee <> Invalid then
                if comparer(array[i], comparee) then
                    return i
                end if
            else
                if isStr(element) and isStr(array[i]) and element = array[i] then
                    return i
                else if isInt(element) and isInt(array[i]) and element = array[i] then
                    return i
                else if isBool(element) and isBool(array[i]) and element = array[i] then
                    return i
                end if
            end if
        end for
    end if

    return -1
End Function
