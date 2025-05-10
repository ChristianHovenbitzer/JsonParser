namespace DefaultPublisher.JsonParser.SampleJson;

codeunit 50101 "JsonParserExample"
{
    procedure ExampleUse()
    var
        JsonParserCU: Codeunit JsonParser;
        JsonParser: Interface IRoot;
    begin
        // Parsing the codeunit into the interface limits the available functions to the ones defined in the interface.
        JsonParser := JsonParserCU.Parse(GetJsonAsPlainText());

        // we have intellisense for each attribute in the JSON file.
        // Message(JsonParser.glossary().GlossDiv().GlossList().GlossEntry().ID());
        Message(JsonParser.glossary().GlossDiv().GlossList().GlossEntry().GlossDef().GlossSeeAlso().Get(2).title());
    end;


    procedure GetJsonAsPlainText(): JsonObject
    begin
        exit(NavApp.GetResourceAsJson('SampleJson.json'));
    end;
}