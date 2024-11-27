namespace DefaultPublisher.JsonParser.SampleJson;

codeunit 50100 "JsonParser" implements IGlossary, IGlossDiv, IGlossList, IGlossEntry, IGlossDef
{
    var
        JsonObject: Jsonobject;

    procedure Parse(PlainText: Text)
    begin
        JsonObject.ReadFrom(PlainText);
    end;

    procedure Parse(NewJsonObject: JsonObject)
    begin
        JsonObject := NewJsonObject;
    end;

    #region Helper Functions
    procedure CanGetValue(JsonKey: Text): Boolean
    var
        JsonToken: JsonToken;
    begin
        if not JsonObject.Get(JsonKey, JsonToken) then
            exit;

        if not JsonToken.IsValue() then
            exit;

        if JsonToken.AsValue().IsNull then
            exit;

        exit(true);
    end;

    procedure GetValue(JsonKey: Text) JsonToken: JsonToken;
    begin
        JsonObject.Get(JsonKey, JsonToken);
    end;
    #endregion

    #region IGlossary
    procedure title(): Text
    begin
        exit(CanGetValue('title') ? GetValue('title').AsValue().AsText() : '');
    end;

    procedure GlossDiv() IGlossDiv: Interface IGlossDiv
    var
        JsonParser: Codeunit JsonParser;
    begin
        if CanGetValue('GlossDiv') then
            JsonParser.Parse(GetValue('GlossDiv').AsObject());
        IGlossDiv := JsonParser;

        exit(JsonParser);
    end;
    #endregion
}