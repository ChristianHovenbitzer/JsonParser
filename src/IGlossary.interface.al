namespace DefaultPublisher.JsonParser.SampleJson;

interface IRoot
{
    procedure glossary(): Interface "IGlossary"
}

interface "IGlossary"
{
    procedure title(): Text
    procedure GlossDiv(): Interface "IGlossDiv"
}
// everything below is created via GitHub Copilot
// prompt: Add interfaces for each JSON object in the file.

interface "IGlossDiv"
{
    procedure title(): Text
    procedure GlossList(): Interface "IGlossList"
}

interface "IGlossList"
{
    procedure GlossEntry(): Interface "IGlossEntry"
}

interface "IGlossEntry"
{
    procedure ID(): Text
    procedure SortAs(): Text
    procedure GlossTerm(): Text
    procedure Acronym(): Text
    procedure Abbrev(): Text
    procedure GlossDef(): Interface "IGlossDef"
    procedure GlossSee(): Text
}

interface "IGlossDef"
{
    procedure para(): Text
    procedure GlossSeeAlso(): List of [Interface IGlossSeeAlso]
}
interface IGlossSeeAlso
{
    procedure title(): Text
}
