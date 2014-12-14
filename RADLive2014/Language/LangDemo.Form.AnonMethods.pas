unit LangDemo.Form.AnonMethods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmAnonMethods = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAnonMethods: TfrmAnonMethods;

implementation

uses
  IdHTTP;

{$R *.dfm}

procedure TfrmAnonMethods.Button1Click(Sender: TObject);
var
  LAnonThread: TThread;
begin
  LAnonThread := TThread.CreateAnonymousThread(
    procedure
    var
      LHTTP: TIdHTTP;
      LResult: string;
    begin
      LHTTP := TIdHTTP.Create(nil);
      try
        Sleep(2000);
        LResult := LHTTP.Get(Edit1.Text);
      finally
        LHTTP.Free;
      end;
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          Memo1.Text := LResult;
        end
      );
    end
  );
  LAnonThread.Start;
end;

end.
