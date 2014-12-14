unit LangDemo.Form.Helpers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, System.Types, System.Rtti,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TPriorityOld = (peLow, peMedium, peHigh);
  {$SCOPEDENUMS ON}
  TPriority = (Low, Medium, High);
  {$SCOPEDENUMS OFF}

  // Enum helpers
  TPriorityHelper = record helper for TPriority
  public
    function ToString: string;
    function ToInteger: Integer;
  end;

  // Dynamic arrays helpers
  TMyBytes = TBytes;
  TMyBytesHelper = record helper for TMyBytes
    function GetLength: Integer;
    function ToString(AEncoding: TEncoding): string;
  end;

  // Record helpers
  TPointHelper = record helper for TPoint
    function ToString: string;
  end;


  // Class helpers
  //TDataSetFilterProc =  reference to procedure (Arg1: T);
  TDataSetHelper = class helper for TDataSet
  public
    procedure ForEachFieldWithValue(
      AFieldName: string;
      AFieldValue: Variant;
      AWorkProc: TProc);
  end;

  TfrmHelpers = class(TForm)
    btnSimpleHelpers: TButton;
    btnEnumHelpers: TButton;
    btnAray: TButton;
    btnClassHelper: TButton;
    dsTest: TFDMemTable;
    dsTestName: TStringField;
    dsTestAge: TIntegerField;
    mmoLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnArayClick(Sender: TObject);
    procedure btnClassHelperClick(Sender: TObject);
    procedure btnEnumHelpersClick(Sender: TObject);
    procedure btnSimpleHelpersClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHelpers: TfrmHelpers;

implementation

uses
  System.TypInfo;

{$R *.dfm}

procedure TfrmHelpers.FormCreate(Sender: TObject);
begin
  dsTest.CreateDataSet;
  dsTest.InsertRecord(['Marco', 49]);
  dsTest.InsertRecord(['Paolo', 20]);
  dsTest.InsertRecord(['Luigi', 33]);
  dsTest.InsertRecord(['Paolo', 45]);
end;

procedure TfrmHelpers.btnArayClick(Sender: TObject);
var
  LBytes: TMyBytes;
begin
  LBytes := [80, 97, 111, 108, 111];
  mmoLog.Lines.Add(LBytes.ToString(TEncoding.ANSI));
end;

procedure TfrmHelpers.btnClassHelperClick(Sender: TObject);
begin
  dsTest.Open;

  dsTest.ForEachFieldWithValue('Name', 'Paolo',
    procedure
    begin
      mmoLog.Lines.Add(dsTest.FieldByName('Age').AsString);
    end
  );
end;

procedure TfrmHelpers.btnEnumHelpersClick(Sender: TObject);
var
  LOldPriority: TPriorityOld;
  LPriority: TPriority;

  LStr: string;
begin
  LOldPriority := peMedium;
  LStr := GetEnumName(TypeInfo(TPriorityOld), Integer(LOldPriority)) ;
  mmoLog.Lines.Add(LStr);

  LPriority := TPriority.Low;
  mmoLog.Lines.Add(LPriority.ToString);

  if LPriority.ToInteger < 50 then
    mmoLog.Lines.Add('Priority level too low')
end;

procedure TfrmHelpers.btnSimpleHelpersClick(Sender: TObject);
var
  LStr: string;
  LInt: integer;
begin
  LInt := 10;
  LStr := LInt.ToString;
  mmoLog.Lines.Add(LStr);

  mmoLog.Lines.Add(120.ToString);

  LStr := 5.ToString;
  mmoLog.Lines.Add(LStr);
end;

{ TPriorityHelper }

function TPriorityHelper.ToInteger: Integer;
begin
  case Self of
    TPriority.Low:    Result := 10;
    TPriority.Medium: Result := 50;
    TPriority.High:   Result := 100;
    else Result := 0;
  end;
end;

function TPriorityHelper.ToString: string;
begin
  case Self of
    TPriority.Low:    Result := 'Low Priority';
    TPriority.Medium: Result := 'Medium Priority';
    TPriority.High:   Result := 'High Priority';
  end;
end;

{ TMyBytesHelper }

function TMyBytesHelper.GetLength: Integer;
begin
  Result := Length(Self);
end;

function TMyBytesHelper.ToString(AEncoding: TEncoding): string;
begin
  Result := AEncoding.GetString(Self, 0, Length(Self));
end;

{ TPointHelper }

function TPointHelper.ToString: string;
begin
  Result := 'X: ' + Self.X.ToString + ', Y: ' + Self.Y.ToString;
end;

{ TDataSetHelper }

procedure TDataSetHelper.ForEachFieldWithValue(
  AFieldName: string;
  AFieldValue: Variant;
  AWorkProc: TProc);
begin
  Self.First;
  while not Self.Eof do
  begin
    if Self.FieldDefs.IndexOf(AFieldName) > -1 then
    begin
      // Work in progress: very weak test (use TValue)
      if Self.FieldByName(AFieldName).Value = AFieldValue then
        AWorkProc;
    end;
    Self.Next;
  end;
end;

end.
