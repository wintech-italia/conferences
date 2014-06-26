unit TetherWin.Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, IPPeerServer,
  Vcl.StdCtrls, System.Tether.Manager, System.Tether.AppProfile, System.Actions,
  Vcl.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmMain = class(TForm)
    lblTime: TLabel;
    btnSubscription: TButton;
    TetheringManagerDesktop: TTetheringManager;
    TetheringAppProfileDesktop: TTetheringAppProfile;
    Memo1: TMemo;
    ActionList1: TActionList;
    actUpdateDB: TAction;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    Button2: TButton;
    actCloseDB: TAction;
    procedure btnSubscriptionClick(Sender: TObject);
    procedure TetheringAppProfileDesktopResourceUpdated(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure FormShow(Sender: TObject);
    procedure TetheringAppProfileDesktopAcceptResource(const Sender: TObject;
      const AProfileId: string; const AResource: TCustomRemoteItem;
      var AcceptResource: Boolean);
    procedure TetheringAppProfileDesktopResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure actUpdateDBExecute(Sender: TObject);
    procedure TetheringManagerDesktopPairedFromLocal(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure TetheringManagerDesktopPairedToRemote(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure actCloseDBExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FTableName: string;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.actCloseDBExecute(Sender: TObject);
begin
  FDMemTable1.Close;
end;

procedure TfrmMain.actUpdateDBExecute(Sender: TObject);
begin
  FDMemTable1.LoadFromFile('C:\Users\Public\Documents\Embarcadero\Studio\14.0\Samples\Data\' + FTableName);
  FDMemTable1.Open;

  Memo1.Lines.Add('actUpdateDBExecute invoked!!');
end;

procedure TfrmMain.btnSubscriptionClick(Sender: TObject);
var
  LProfile: TTetheringProfileInfo;
  LResource: TRemoteResource;
begin
  LProfile := TetheringManagerDesktop.RemoteProfiles[0];
  LResource := TetheringAppProfileDesktop.GetRemoteResourceValue(LProfile, 'CurTime');
  TetheringAppProfileDesktop.SubscribeToRemoteItem(LProfile, 'CurTime');

  {
  for LProfile in TetheringManagerDesktop.RemoteProfiles do
  begin
    if LProfile.ProfileGroup = 'BarcodeGroup' then
      Break;
  end;
  }
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FTableName := 'country.fds';
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  TetheringManagerDesktop.AutoConnect;
end;

procedure TfrmMain.TetheringAppProfileDesktopAcceptResource(
  const Sender: TObject; const AProfileId: string;
  const AResource: TCustomRemoteItem; var AcceptResource: Boolean);
begin
  AcceptResource := True;
end;

procedure TfrmMain.TetheringAppProfileDesktopResourceReceived(
  const Sender: TObject; const AResource: TRemoteResource);
begin
  FTableName := AResource.Value.AsString;
  if Pos('.fds', FTableName) = 0 then
    FTableName := FTableName + '.fds';

  Memo1.Lines.Add(FTableName);
end;

procedure TfrmMain.TetheringAppProfileDesktopResourceUpdated(
  const Sender: TObject; const AResource: TRemoteResource);
begin
  lblTime.Caption := AResource.Value.AsString;
end;

procedure TfrmMain.TetheringManagerDesktopPairedFromLocal(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  Memo1.Lines.Add('Paired From Local ' + AManagerInfo.ManagerName);
end;

procedure TfrmMain.TetheringManagerDesktopPairedToRemote(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  Memo1.Lines.Add('Paired To Remote ' + AManagerInfo.ManagerName);
end;

end.
