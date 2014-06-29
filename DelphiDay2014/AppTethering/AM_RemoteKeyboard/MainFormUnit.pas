unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, IPPeerServer,
  System.Tether.Manager, System.Tether.AppProfile, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    ActionList1: TActionList;
    actnRotateCW: TAction;
    actnRotateCCW: TAction;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure actnRotateCWExecute(Sender: TObject);
    procedure actnRotateCCWExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Log(const AText: string);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


procedure SimulateKeyPress(const AKey: Word);
begin
  keybd_event( AKey, MapVirtualKey( AKey, 0), 0, 0);
  keybd_event( AKey, MapVirtualkey( AKey, 0 ), KEYEVENTF_KEYUP, 0);
end;

procedure TMainForm.actnRotateCWExecute(Sender: TObject);
begin
  Log('Destra');

  SimulateKeyPress( VK_RIGHT );
end;

Function GetUserFromWindows: string;
Var
  UserName : string;
  UserNameLen : Dword;
Begin
  UserNameLen := 255;
  SetLength(userName, UserNameLen) ;
  If GetUserName(PChar(UserName), UserNameLen) Then
    Result := Copy(UserName,1,UserNameLen - 1)
  Else
    Result := 'Unknown';
End;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TetheringManager1.Text := 'Keyboard.' + GetUserFromWIndows;

  Label1.Caption := 'Manger.Text = ' + TetheringManager1.Text;
end;

procedure TMainForm.Log(const AText: string);
begin
  Memo1.Lines.Add(DateTimeToStr(Now) + ': ' + AText);
end;

procedure TMainForm.actnRotateCCWExecute(Sender: TObject);
begin
  Log('Sinistra');

  SimulateKeyPress( VK_LEFT );
end;

end.
