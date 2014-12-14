// 
// Created by the DataSnap proxy generator.
// 14/12/2014 23:13:03
// 

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FGetEmployeeNameCommand: TDSRestCommand;
    FGetDataSetStreamCommand: TDSRestCommand;
    FGetDataSetStreamCommand_Cache: TDSRestCommand;
    FGetDataSetStreamXMLCommand: TDSRestCommand;
    FGetDataSetCommand: TDSRestCommand;
    FGetDataSetCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function GetEmployeeName(AID: Integer; const ARequestFilter: string = ''): string;
    function GetDataSetStream(const ARequestFilter: string = ''): TStream;
    function GetDataSetStream_Cache(const ARequestFilter: string = ''): IDSRestCachedStream;
    function GetDataSetStreamXML(const ARequestFilter: string = ''): string;
    function GetDataSet(const ARequestFilter: string = ''): TDataSet;
    function GetDataSet_Cache(const ARequestFilter: string = ''): IDSRestCachedDataSet;
  end;

const
  TServerMethods1_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_GetEmployeeName: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_GetDataSetStream: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_GetDataSetStream_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_GetDataSetStreamXML: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_GetDataSet: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDataSet')
  );

  TServerMethods1_GetDataSet_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

implementation

function TServerMethods1Client.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare(TServerMethods1_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare(TServerMethods1_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetEmployeeName(AID: Integer; const ARequestFilter: string): string;
begin
  if FGetEmployeeNameCommand = nil then
  begin
    FGetEmployeeNameCommand := FConnection.CreateCommand;
    FGetEmployeeNameCommand.RequestType := 'GET';
    FGetEmployeeNameCommand.Text := 'TServerMethods1.GetEmployeeName';
    FGetEmployeeNameCommand.Prepare(TServerMethods1_GetEmployeeName);
  end;
  FGetEmployeeNameCommand.Parameters[0].Value.SetInt32(AID);
  FGetEmployeeNameCommand.Execute(ARequestFilter);
  Result := FGetEmployeeNameCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetDataSetStream(const ARequestFilter: string): TStream;
begin
  if FGetDataSetStreamCommand = nil then
  begin
    FGetDataSetStreamCommand := FConnection.CreateCommand;
    FGetDataSetStreamCommand.RequestType := 'GET';
    FGetDataSetStreamCommand.Text := 'TServerMethods1.GetDataSetStream';
    FGetDataSetStreamCommand.Prepare(TServerMethods1_GetDataSetStream);
  end;
  FGetDataSetStreamCommand.Execute(ARequestFilter);
  Result := FGetDataSetStreamCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.GetDataSetStream_Cache(const ARequestFilter: string): IDSRestCachedStream;
begin
  if FGetDataSetStreamCommand_Cache = nil then
  begin
    FGetDataSetStreamCommand_Cache := FConnection.CreateCommand;
    FGetDataSetStreamCommand_Cache.RequestType := 'GET';
    FGetDataSetStreamCommand_Cache.Text := 'TServerMethods1.GetDataSetStream';
    FGetDataSetStreamCommand_Cache.Prepare(TServerMethods1_GetDataSetStream_Cache);
  end;
  FGetDataSetStreamCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FGetDataSetStreamCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.GetDataSetStreamXML(const ARequestFilter: string): string;
begin
  if FGetDataSetStreamXMLCommand = nil then
  begin
    FGetDataSetStreamXMLCommand := FConnection.CreateCommand;
    FGetDataSetStreamXMLCommand.RequestType := 'GET';
    FGetDataSetStreamXMLCommand.Text := 'TServerMethods1.GetDataSetStreamXML';
    FGetDataSetStreamXMLCommand.Prepare(TServerMethods1_GetDataSetStreamXML);
  end;
  FGetDataSetStreamXMLCommand.Execute(ARequestFilter);
  Result := FGetDataSetStreamXMLCommand.Parameters[0].Value.GetWideString;
end;

function TServerMethods1Client.GetDataSet(const ARequestFilter: string): TDataSet;
begin
  if FGetDataSetCommand = nil then
  begin
    FGetDataSetCommand := FConnection.CreateCommand;
    FGetDataSetCommand.RequestType := 'GET';
    FGetDataSetCommand.Text := 'TServerMethods1.GetDataSet';
    FGetDataSetCommand.Prepare(TServerMethods1_GetDataSet);
  end;
  FGetDataSetCommand.Execute(ARequestFilter);
  Result := TCustomSQLDataSet.Create(nil, FGetDataSetCommand.Parameters[0].Value.GetDBXReader(False), True);
  Result.Open;
  if FInstanceOwner then
    FGetDataSetCommand.FreeOnExecute(Result);
end;

function TServerMethods1Client.GetDataSet_Cache(const ARequestFilter: string): IDSRestCachedDataSet;
begin
  if FGetDataSetCommand_Cache = nil then
  begin
    FGetDataSetCommand_Cache := FConnection.CreateCommand;
    FGetDataSetCommand_Cache.RequestType := 'GET';
    FGetDataSetCommand_Cache.Text := 'TServerMethods1.GetDataSet';
    FGetDataSetCommand_Cache.Prepare(TServerMethods1_GetDataSet_Cache);
  end;
  FGetDataSetCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedDataSet.Create(FGetDataSetCommand_Cache.Parameters[0].Value.GetString);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGetEmployeeNameCommand.DisposeOf;
  FGetDataSetStreamCommand.DisposeOf;
  FGetDataSetStreamCommand_Cache.DisposeOf;
  FGetDataSetStreamXMLCommand.DisposeOf;
  FGetDataSetCommand.DisposeOf;
  FGetDataSetCommand_Cache.DisposeOf;
  inherited;
end;

end.
