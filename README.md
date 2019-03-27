# EACarShow
Car Show Example written in Brightscript

## Code Structure

This is a simple Brightscript application with a Single Scene. In a normal application there would be components behind the scene representing the many pages that would normally be associated with the App.

## Classes

GetCarShowDataTask is a simple implementation of a Task to get data from the API. In Brightscript Network calls, Registry Reads/Writes and File System operations have to be made from a Task.

HTTPRequest is a simple wrapper for the roURLTransfer object. Wrapping it provides the ability to Stub/Mock the function calls from Rooibos.

CarShowDataProcessor is a simple implementation of a business object that processes data form one format to another. In the case of Brightscript data processing is a difficult task and this sort of work would normally be done in the backend web services.

There are two simple Utility files (ArrayUtils and TypeUtil) that provide some helper functions for handling inspecting object Type information and processing of Arrays. In many ways Brightscript is a simple language and does not provide many of these primatives.

## Unit Tests

Unit testing is implemented using the Rooibos Unit Testing Framework written by George Cook. I have included a few sample tests as an example of the sorts of things we can test. In a production application like this with the variable data being returned you would normally include a lot more tests.

## Test Results

There is a test_results.txt file that has the results of a test run in it.
There is a screen shot of the final data output.
There is a showt video showing the loading of the app and the final data.
