unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.JumpList;

type
  TMainForm = class(TForm)
    JumpList1: TJumpList;
    Memo1: TMemo;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Apri1: TMenuItem;
    N1: TMenuItem;
    Esci1: TMenuItem;
    FileOpenDialog1: TFileOpenDialog;
    procedure Esci1Click(Sender: TObject);
    procedure Apri1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure LoadFromFile(const AFileName: string);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.Apri1Click(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
    LoadFromFile(FileOpenDialog1.FileName);
end;

procedure TMainForm.Esci1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  if ParamCount > 0 then
    LoadFromFile(ParamStr(1));
end;

procedure TMainForm.LoadFromFile(const AFileName: string);
begin
  Memo1.Lines.LoadFromFile(AFileName);
  JumpList1.AddToRecent(AFileName);
  Caption := ExtractFileName(AFileName);
end;

end.
