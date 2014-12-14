unit LangDemo.Form.DynArrays;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmDynArrays = class(TForm)
    btnArrayInit: TButton;
    btnArrayRTL: TButton;
    mmoLog: TMemo;
    procedure btnArrayInitClick(Sender: TObject);
    procedure btnArrayRTLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDynArrays: TfrmDynArrays;

implementation

{$R *.dfm}

procedure TfrmDynArrays.btnArrayInitClick(Sender: TObject);
var
  LIntArray: array of Integer;
  LValue: Integer;
begin
  mmoLog.Lines.Clear;

  LIntArray := [1, 2, 3];    // initialization
  LIntArray := LIntArray + LIntArray;      // concatenation
  LIntArray := LIntArray + [4, 5];  // mixed concatenation

  for LValue in LIntArray do
    mmoLog.Lines.Add (LValue.ToString);
end;

procedure TfrmDynArrays.btnArrayRTLClick(Sender: TObject);
var
  LIntArray: array of Integer;
  LValue: Integer;
begin
  mmoLog.Lines.Clear;

  LIntArray := [1, 2, 3, 4, 5, 6];
  Insert ([8, 9], LIntArray, 4);
  Delete (LIntArray, 2, 1); // remove the third (0-based)
  for LValue in LIntArray do
    mmoLog.Lines.Add (LValue.ToString);
end;

end.
