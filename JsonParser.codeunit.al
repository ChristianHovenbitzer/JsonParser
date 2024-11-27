namespace DefaultPublisher.JsonParser.SampleJson;


/// <summary>
/// This codeunit has a function for every attribute in the SampleJson file.
/// </summary>
/// <param name="PlainText">Text.</param>
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

    #region IGlossDiv

    //title procedure already exists. We cannot create nor need another title procedure.


    // Returns a new instance of the same codeunit parsed into the interface to limit the available functions.
    procedure GlossList() IGlossList: Interface IGlossList
    var
        JsonParser: Codeunit JsonParser;
    begin
        if CanGetValue('GlossList') then
            JsonParser.Parse(GetValue('GlossList').AsObject());
        IGlossList := JsonParser;
        exit(JsonParser);
    end;
    #endregion

    #region IGlossList
    procedure GlossEntry() IGlossEntry: Interface IGlossEntry
    var
        JsonParser: Codeunit JsonParser;
    begin
        if CanGetValue('GlossEntry') then
            JsonParser.Parse(GetValue('GlossEntry').AsObject());
        IGlossEntry := JsonParser;
        exit(JsonParser);
    end;
    #endregion

    #region IGlossEntry
    procedure ID(): Text
    begin
        exit(CanGetValue('ID') ? GetValue('ID').AsValue().AsText() : '');
    end;

    procedure SortAs(): Text
    begin
        exit(CanGetValue('SortAs') ? GetValue('SortAs').AsValue().AsText() : '');
    end;

    procedure GlossTerm(): Text
    begin
        exit(CanGetValue('GlossTerm') ? GetValue('GlossTerm').AsValue().AsText() : '');
    end;

    procedure Acronym(): Text
    begin
        exit(CanGetValue('Acronym') ? GetValue('Acronym').AsValue().AsText() : '');
    end;

    procedure Abbrev(): Text
    begin
        exit(CanGetValue('Abbrev') ? GetValue('Abbrev').AsValue().AsText() : '');
    end;

    procedure GlossDef() IGlossDef: Interface IGlossDef
    var
        JsonParser: Codeunit JsonParser;
    begin
        if CanGetValue('GlossDef') then
            JsonParser.Parse(GetValue('GlossDef').AsObject());
        IGlossDef := JsonParser;
        exit(JsonParser);
    end;

    procedure GlossSee(): Text
    begin
        exit(CanGetValue('GlossSee') ? GetValue('GlossSee').AsValue().AsText() : '');
    end;
    #endregion

    #region IGlossDef
    procedure para(): Text
    begin
        exit(CanGetValue('para') ? GetValue('para').AsValue().AsText() : '');
    end;

    procedure GlossSeeAlso() GlossSeeAlsoList: List of [Text]
    var
        JsonArray: JsonArray;
        JsonToken: JsonToken;
    begin
        if CanGetValue('GlossSeeAlso') then begin
            JsonArray := GetValue('GlossSeeAlso').AsArray();
            foreach JsonToken in JsonArray do
                GlossSeeAlsoList.Add(JsonToken.AsValue().AsText());
        end;
        exit(GlossSeeAlsoList);
    end;
    #endregion
}