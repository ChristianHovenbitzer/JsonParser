namespace DefaultPublisher.JsonParser;
using Microsoft.Sales.Customer;

pageextension 50100 "Customer List" extends "Customer List"
{

    trigger OnOpenPage()
    var
        JsonParserExample: Codeunit DefaultPublisher.JsonParser.SampleJson.JsonParserExample;
    begin
        JsonParserExample.ExampleUse();
    end;
}