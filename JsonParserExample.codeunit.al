namespace DefaultPublisher.JsonParser.SampleJson;

codeunit 50101 "JsonParserExample"
{
    procedure ExampleUse()
    var
        JsonParserCU: Codeunit JsonParser;
        JsonParser: Interface IRoot;
    begin
        JsonParserCU.Parse(GetJsonAsPlainText());

        // Parsing the codeunit into the interface limits the available functions to the ones defined in the interface.
        JsonParser := JsonParserCU;

        // we have intellisense for each attribute in the JSON file.
        Message(JsonParser.glossary().GlossDiv().GlossList().GlossEntry().ID());
        // Message('JsonParser.glossary().GlossDiv().GlossList().GlossEntry().ID()');
    end;


    procedure GetJsonAsPlainText(): Text
    begin
        exit('{"glossary":{"title":"exampleglossary","GlossDiv":{"title":"S","GlossList":{"GlossEntry":{"ID":"SGML","SortAs":"SGML","GlossTerm":"StandardGeneralizedMarkupLanguage","Acronym":"SGML","Abbrev":"ISO8879:1986","GlossDef":{"para":"Ameta-markuplanguage,usedtocreatemarkuplanguagessuchasDocBook.","GlossSeeAlso":["GML","XML"]},"GlossSee":"markup"}}}}}');
    end;
}