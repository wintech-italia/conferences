unit REST.Methods.Server;

interface

uses
  System.SysUtils, System.Classes, System.Json, Data.DB,
  Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.Comp.UI, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageXML;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageXMLLink1: TFDStanStorageXMLLink;
  private
    { Private declarations }
  public
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;

    function GetEmployeeName(AID: Integer): string;

    // Metodi per ritornare un DataSet al client
    function GetDataSetStream: TStream;
    function GetDataSetStreamXML: string;
    function GetDataSet: TDataSet;
  end;
{$METHODINFO OFF}

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetDataSet: TDataSet;
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FDConnection1;
    LQuery.SQL.Text := 'select * from Employees order by EmployeeID';
    LQuery.Open;

    Result := LQuery;
  except
    LQuery.Free;
    raise;
  end;

end;

function TServerMethods1.GetDataSetStream: TStream;
var
  LQuery: TFDQuery;
begin
  Result := TMemoryStream.Create;
  try
    LQuery := TFDQuery.Create(nil);
    try
      LQuery.Connection := FDConnection1;
      LQuery.SQL.Text := 'select * from Employees order by EmployeeID';
      LQuery.Open;

      LQuery.SaveToStream(Result, sfBinary);
      Result.Position := 0;
    finally
      LQuery.Free;
    end;
  except
    Result.Free;
    raise;
  end;
end;

function TServerMethods1.GetDataSetStreamXML: string;
var
  LQuery: TFDQuery;

  LMemTable: TFDMemTable;
begin
  Result := '';
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FDConnection1;
    LQuery.SQL.Text := 'select * from Employees order by EmployeeID';
    LQuery.Open;

    LMemTable := TFDMemTable.Create(nil);
    try
      LMemTable.Data := LQuery.Data;
      Result := LMemTable.XMLData;
    finally
      LMemTable.Free;
    end;
  finally
    LQuery.Free;
  end;
end;

function TServerMethods1.GetEmployeeName(AID: Integer): string;
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FDConnection1;
    LQuery.SQL.Text := 'SELECT * FROM Employees where EmployeeID = ' + AID.ToString;
    LQuery.Open;
    if LQuery.RecordCount > 0 then
    begin
      Result := LQuery.FieldByName('FirstName').AsString + ' ' + LQuery.FieldByName('LastName').AsString;
    end
    else
      Result := '';
  finally
    LQuery.Free;
  end;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

