unit MainFormUnit;

interface

{
  Demo: AppTethering, Desktop Server
  Date/Event: DelphiDay 2014
  Author: Andrea Magni (Wintech-Italia s.r.l.)
  Contacts:
    Twitter: @andreamagni82
    Facebook: https://www.facebook.com/andreamagni82
    Google+: https://plus.google.com/+AndreaMagni
    Blog: blog.delphiedintorni.it
}


uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.StdCtrls, FMX.Layouts, IPPeerClient, IPPeerServer,
  System.Tether.Manager, System.Tether.AppProfile, FMX.Memo, FMX.ListView.Types,
  FMX.ListView, Generics.Collections, FMX.Objects, FMX.Ani;

type
  TMainForm = class(TForm)
    ActionList1: TActionList;
    actnLeft: TAction;
    actnRight: TAction;
    TetheringAppProfile1: TTetheringAppProfile;
    TetheringManager1: TTetheringManager;
    StyleBook1: TStyleBook;
    layButtons: TLayout;
    Button1: TButton;
    Button2: TButton;
    btnScan: TButton;
    lvManagers: TListView;
    lbMessage: TLabel;
    imgWintech: TImage;
    aniWintech: TFloatKeyAnimation;
    procedure TetheringManager1PairedToRemote(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure btnScanClick(Sender: TObject);
    procedure TetheringManager1EndManagersDiscovery(const Sender: TObject;
      const RemoteManagers: TTetheringManagerInfoList);
    procedure FormCreate(Sender: TObject);
    procedure TetheringManager1EndProfilesDiscovery(const Sender: TObject;
      const RemoteProfiles: TTetheringProfileInfoList);
    procedure lvManagersItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
    FAvailableManagers: TDictionary<TListViewItem, TTetheringManagerInfo>;

    procedure UnPair;
    procedure PairWithAssociatedManager(const AItem: TListViewItem);
  public
    { Public declarations }
    procedure ClearLog;
    procedure Log(const AText: string);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.btnScanClick(Sender: TObject);
begin
  ClearLog;
  lvManagers.Items.Clear;
  FAvailableManagers.Clear;

  TetheringManager1.DiscoverManagers(3000);
  aniWintech.Start;
end;

procedure TMainForm.ClearLog;
begin
  lbMessage.Text := '';
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FAvailableManagers := TDictionary<TListViewItem, TTetheringManagerInfo>.Create();
end;

procedure TMainForm.lvManagersItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  ClearLog;

  UnPair;

  if Assigned(lvManagers.Selected) then
    PairWithAssociatedManager(lvManagers.Selected);
end;

procedure TMainForm.Log(const AText: string);
begin
  lbMessage.Text := AText;
end;

procedure TMainForm.PairWithAssociatedManager(const AItem: TListViewItem);
var
  LTargetManager: TTetheringManagerInfo;
begin
  if FAvailableManagers.TryGetValue(AItem, LTargetManager) then
    TetheringManager1.PairManager(LTargetManager);
end;

procedure TMainForm.TetheringManager1EndManagersDiscovery(const Sender: TObject;
  const RemoteManagers: TTetheringManagerInfoList);
var
  LRemoteManager: TTetheringManagerInfo;
  LItem: TListViewItem;
begin
  Log('Managers: ' + RemoteManagers.Count.ToString);

  for LRemoteManager in RemoteManagers do
  begin
    LItem := lvManagers.Items.Add;
    LItem.Text := LRemoteManager.ManagerText;
    FAvailableManagers.Add(LItem, LRemoteManager);
  end;
end;

procedure TMainForm.TetheringManager1EndProfilesDiscovery(const Sender: TObject;
  const RemoteProfiles: TTetheringProfileInfoList);
var
  LRemoteProfile: TTetheringProfileInfo;
begin
  for LRemoteProfile in RemoteProfiles do
    TetheringAppProfile1.Connect(LRemoteProfile);
end;

procedure TMainForm.TetheringManager1PairedToRemote(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  Log('Paired To: ' + AManagerInfo.ManagerText);
end;

procedure TMainForm.UnPair;
var
  LPairedManager: TTetheringManagerInfo;
begin
  for LPairedManager in TetheringManager1.PairedManagers do
    TetheringManager1.UnPairManager(LPairedManager);
end;

end.
