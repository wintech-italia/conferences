unit TetherServer.Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, IPPeerServer,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, System.Tether.Manager,
  System.Tether.AppProfile, Vcl.ExtCtrls, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TfrmMain = class(TForm)
    TetheringManagerServer: TTetheringManager;
    TetheringAppProfileServer: TTetheringAppProfile;
    ActionList1: TActionList;
    actAggiungi: TAction;
    actSottrai: TAction;
    actReset: TAction;
    actShow: TAction;
    Timer1: TTimer;
    mmoLog: TMemo;
    edtSendString: TEdit;
    Button4: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Panel1: TPanel;
    Label2: TLabel;
    lblTime: TLabel;
    Button1: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TetheringManagerServerPairedFromLocal(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure TetheringManagerServerPairedToRemote(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TetheringAppProfileServerResources1ResourceReceived(
      const Sender: TObject; const AResource: TRemoteResource);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  DateUtils, System.JSON;

{$R *.dfm}

procedure TfrmMain.FormShow(Sender: TObject);
begin
  TetheringManagerServer.AutoConnect;

  // A more DIY way...
  {
  TetheringManagerServer.DiscoverManagers();
  TetheringManagerServer.DiscoverProfiles();
  TetheringManagerServer.PairedManagers
  TetheringManagerServer.PairManager();
  }
end;

(*******************************************************************************
How to exchange data
*******************************************************************************)

// 1st approach. Invoke Remote Action
procedure TfrmMain.Button1Click(Sender: TObject);
var
  LRemoteAct: TRemoteAction;
begin
  // Get the remote action
  LRemoteAct := TetheringAppProfileServer.GetRemoteProfileActions(
    TetheringManagerServer.RemoteProfiles[0]).Items[0];

  // Execute the remote action
  if Assigned(LRemoteAct) then
    LRemoteAct.Execute;
end;

// 2nd approach.  Send to a remote profile (or profiles) a resource
procedure TfrmMain.Button4Click(Sender: TObject);
begin
  TetheringAppProfileServer.SendString(TetheringManagerServer.RemoteProfiles[0], 'Simple Message', edtSendString.Text);
  // To send way mooore data
  //TetheringAppProfileServer.SendStream()
end;

// 3rd approach. Update a resource.
// Another app can subscribe this resource and get immediately notified.
procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  RESTRequest1.Execute;
  lblTime.Caption := FormatDateTime('hh:nn:ss', UnixToDateTime((RESTResponse1.JSONValue as System.JSON.TJSONObject).GetValue('timestamp').Value.ToInteger));
  TetheringAppProfileServer.Resources.FindByName('CurTime').Value := lblTime.Caption;
end;

procedure TfrmMain.TetheringAppProfileServerResources1ResourceReceived(
  const Sender: TObject; const AResource: TRemoteResource);
begin
  mmoLog.Lines.Text := AResource.Value.AsString;
end;

procedure TfrmMain.TetheringManagerServerPairedFromLocal(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  mmoLog.Lines.Add('Paired Local ' + AManagerInfo.ManagerName);
end;

procedure TfrmMain.TetheringManagerServerPairedToRemote(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  mmoLog.Lines.Add('Paired Remote ' + AManagerInfo.ManagerName);
end;

end.
