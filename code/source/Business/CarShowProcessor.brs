'---------------------------------------------------------------------------------
' This object is the Business Object that processes the data for the UI
' and passes it back to it in the sorted sequence.
'
' Manipulation in BrightScript is difficult and normally this sort of logic
' would be implemented by the service.
'
' Once again by doing this this way we can Mock/Stub this class
' in a unit test.
'---------------------------------------------------------------------------------

' CreateCarShowProcessor - Function to create the business object
' that will process the Car Show data in a UI friendly way
Function CreateCarShowProcessor(data = {} as Object) as Object
    ' Create an Assoc Array and add some functions to it
    m.this = {}
    m.this.data = data
    m.this.ProcessData = CarShowProcessor_ProcessData
    m.this.MakePrintableString = CarShowProcessor_MakePrintableString

    ' Return the newly created object
    return m.this
End Function


' Makes a printable string
Function CarShowProcessor_MakePrintableString()
    printableString = ""

    ' Print the data and yep Brightscript requires the chr(13) and
    ' not a newline like "\n"
    for each make in m.processedData.makes
        ' Don't display them if they are not there
        if (make.models.Count() > 0) then
            printableString += make.make + chr(13)

            for each model in make.models
                printableString += "    " + model.model + chr(13)

                for each carShow in model.carShows
                    printableString += "        " + carShow.name + chr(13)
                end for
            end for
        end if
    end for

    return printableString
End Function


' CarShowProcessor_ProcessData - Function to process the data into the required format
Function CarShowProcessor_ProcessData() as Object
    ' Check for an invalid value or an empty Array
    if (m.data = invalid or m.data.Count() = 0) then
        return invalid
    end if

    ' Unless you really have to you don't data processing like this in a Brightscript app.
    ' The reason is that Brightscript is had very poor data handling primatives.
    m.processedData = { makes: [] }

    ' First we have to extract the top level of the Tree. We're going to make
    ' An assoc array and populate a list of Makes.
    for each carShow in m.data
        for each car in carShow.cars
            ' See if we have the item in the list already
            index = IndexOf(m.processedData.makes, invalid, CompareMakes, car.make)

            if (index = -1) then
                makeNode = { make: car.make, models: [] }
                m.processedData.makes.Push(makeNode)
            else
                makeNode = m.processedData.makes[index]
            end if

            ' Now check that the Model is cthere and if it is process it
            if (car.model <> invalid and car.model <> "") then
                modelIndex = IndexOf(makeNode.models, invalid, CompareModels, car.model)

                if (modelIndex = -1) then
                    modelNode = { model: car.model, carShows: [] }
                    makeNode.models.Push(modelNode)
                else
                    modelNode = makeNode.models[modelIndex]
                end if

                ' Finally grab the Car Show name and add it to the Model
                if (carShow.name <> invalid and carShow.name <> "") then
                    ' Now we get to process the Car Show names into the data
                    carShowIndex = IndexOf(modelNode.carShows, invalid, CompareCarShows, carShow.name)

                    ' If not found add it in
                    if (carShowIndex = -1) then
                        carShowNode = { name: carShow.name }
                        modelNode.carShows.Push(carShowNode)
                    end if
                end if
            else
                print "Make: " + car.make + " has no Model"
            end if
        end for
    end for

    return m.processedData
End Function


' Compare a make object to the name fo the make.
Function CompareCarShows(carShow as Object, name as String) as Boolean
    return carShow.name = name
End Function


' Compare a make object to the name fo the make.
Function CompareMakes(makeObj as Object, makeName as String) as Boolean
    return makeObj.make = makeName
End Function


' Compare a make object to the name fo the make.
Function CompareModels(modelObj as Object, modelName as String) as Boolean
    return modelObj.model = modelName
End Function

