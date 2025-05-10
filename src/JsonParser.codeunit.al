namespace DefaultPublisher.JsonParser.SampleJson;


/// <summary>
/// This codeunit has a function for every attribute in the SampleJson file.
/// </summary>
/// <param name="PlainText">Text.</param>
codeunit 50100 "JsonParser" implements IRoot, IGlossary, IGlossDiv, IGlossList, IGlossEntry, IGlossDef, IGlossSeeAlso
{
    InherentEntitlements = X;
    InherentPermissions = X;

    var
        JsonObject: JsonObject;

    procedure Parse(PlainText: Text)
    begin
        JsonObject.ReadFrom(PlainText);
    end;

    procedure Parse(NewJsonObject: JsonObject): Codeunit JsonParser
    begin
        JsonObject := NewJsonObject;
        exit(this);
    end;

    #region IRoot    
    procedure glossary() IGlossary: Interface IGlossary
    var
        JsonParser: Codeunit JsonParser;
    begin
        exit(JsonParser.Parse(JsonObject.GetObject('glossary', true)));
    end;
    #endregion

    #region IGlossary
    // this procedure also implements the interface IGlossSeeAlso
    procedure title(): Text
    begin
        exit(JsonObject.GetText('title', true));
    end;

    procedure GlossDiv() IGlossDiv: Interface IGlossDiv
    var
        JsonParser: Codeunit JsonParser;
    begin
        exit(JsonParser.Parse(JsonObject.GetObject('GlossDiv', true)));
    end;
    #endregion

    #region IGlossDiv

    //title procedure already exists. We cannot create nor need another title procedure.


    // Returns a new instance of the same codeunit parsed into the interface to limit the available functions.
    procedure GlossList() IGlossList: Interface IGlossList
    var
        JsonParser: Codeunit JsonParser;
    begin
        exit(JsonParser.Parse(JsonObject.GetObject('GlossList', true)));
    end;
    #endregion

    #region IGlossList
    procedure GlossEntry() IGlossEntry: Interface IGlossEntry
    var
        JsonParser: Codeunit JsonParser;
    begin
        exit(JsonParser.Parse(JsonObject.GetObject('GlossEntry', true)));
    end;
    #endregion

    #region IGlossEntry
    procedure ID(): Text
    begin
        exit(JsonObject.GetText('ID', true));
    end;

    procedure SortAs(): Text
    begin
        exit(JsonObject.GetText('SortAs', true));
    end;

    procedure GlossTerm(): Text
    begin
        exit(JsonObject.GetText('GlossTerm', true));
    end;

    procedure Acronym(): Text
    begin
        exit(JsonObject.GetText('Acronym', true));
    end;

    procedure Abbrev(): Text
    begin
        exit(JsonObject.GetText('Abbrev', true));
    end;

    procedure GlossDef() IGlossDef: Interface IGlossDef
    var
        JsonParser: Codeunit JsonParser;
    begin
        exit(JsonParser.Parse(JsonObject.GetObject('GlossDef', true)));
    end;

    procedure GlossSee(): Text
    begin
        exit(JsonObject.GetText('GlossSee', true));
    end;
    #endregion

    #region IGlossDef
    procedure para(): Text
    begin
        exit(JsonObject.GetText('para', true));
    end;

    procedure GlossSeeAlso() GlossSeeAlsoList: List of [Interface IGlossSeeAlso]
    var
        JsonToken: JsonToken;
        JsonParser: Codeunit JsonParser;
    begin
        foreach JsonToken in JsonObject.GetArray('GlossSeeAlso', true) do begin
            GlossSeeAlsoList.Add(JsonParser.Parse(JsonToken.AsObject()));
            Clear(JsonParser); // to avoid object resuse
        end;

        exit(GlossSeeAlsoList);
    end;
    #endregion
}