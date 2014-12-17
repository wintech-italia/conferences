unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    TaskDialog1: TTaskDialog;
    procedure Button1Click(Sender: TObject);
    procedure TaskDialog1Timer(Sender: TObject; TickCount: Cardinal;
      var Reset: Boolean);
    procedure TaskDialog1HyperlinkClicked(Sender: TObject);
  private
    { Private declarations }
    FStartTime: TDateTime;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  DateUtils
  , ShellAPI;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FStartTime := Now;
  TaskDialog1.ProgressBar.Position := 0;
  TaskDialog1.Execute;
end;

procedure TForm1.TaskDialog1HyperlinkClicked(Sender: TObject);
begin
  ShellExecute(0, nil, PWideChar(TaskDialog1.URL), nil, nil, SW_SHOW);
end;

procedure TForm1.TaskDialog1Timer(Sender: TObject; TickCount: Cardinal;
  var Reset: Boolean);
var
  LElapsed: Int64;
begin
  LElapsed := SecondsBetween(Now, FStartTime);

  if LElapsed > 10 then
  begin
    TaskDialog1.OnTimer := nil;
    TaskDialog1.ProgressBar.Position := 100;
  end
  else
    TaskDialog1.ProgressBar.Position := LElapsed * 10;
end;

end.
