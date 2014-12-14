unit REST.Form.Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageXML;

type
  TfrmClient = class(TForm)
    btnEmployee: TButton;
    edtID: TEdit;
    mmoLog: TMemo;
    btnStream: TButton;
    FDMemTable1: TFDMemTable;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    btnStreamXML: TButton;
    btnDataSet: TButton;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    DBGrid2: TDBGrid;
    FDStanStorageXMLLink1: TFDStanStorageXMLLink;
    procedure btnDataSetClick(Sender: TObject);
    procedure btnEmployeeClick(Sender: TObject);
    procedure btnStreamClick(Sender: TObject);
    procedure btnStreamXMLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClient: TfrmClient;

implementation

uses
  ClientModuleUnit1;

{$R *.dfm}

procedure TfrmClient.btnDataSetClick(Sender: TObject);
var
  LDataSet: TDataSet;
begin
  LDataSet := ClientModule1.ServerMethods1Client.GetDataSet;
  try
    LDataSet.Open;

    while not LDataSet.Eof do
    begin
      mmoLog.Lines.Add(LDataSet.FieldByName('FirstName').AsString);
      LDataSet.Next;
    end;

  finally
    LDataSet.Free;
  end;
end;

procedure TfrmClient.btnEmployeeClick(Sender: TObject);
begin
  mmoLog.Lines.Add(ClientModule1.ServerMethods1Client.GetEmployeeName(StrToInt(edtID.Text)));
end;

procedure TfrmClient.btnStreamClick(Sender: TObject);
var
  LStream: TStream;
begin
  LStream := ClientModule1.ServerMethods1Client.GetDataSetStream;
  LStream.Position := 0;
  FDMemTable1.LoadFromStream(LStream, sfBinary);
  FDMemTable1.Open;
end;

procedure TfrmClient.btnStreamXMLClick(Sender: TObject);
var
  LXML: string;
begin
  LXML := ClientModule1.ServerMethods1Client.GetDataSetStreamXML;
  FDMemTable1.XMLData := LXML;
  FDMemTable1.Open;
end;

end.
