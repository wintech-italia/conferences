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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, IPPeerServer,
  Vcl.StdCtrls, System.Tether.Manager, System.Tether.AppProfile;

type
  TMainForm = class(TForm)
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    LogMemo: TMemo;
    procedure TetheringAppProfile1Resources0ResourceReceived(
      const Sender: TObject; const AResource: TRemoteResource);
    procedure TetheringAppProfile1AcceptResource(const Sender: TObject;
      const AProfileId: string; const AResource: TCustomRemoteItem;
      var AcceptResource: Boolean);
    procedure TetheringManager1PairedFromLocal(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
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

procedure TMainForm.Log(const AText: string);
begin
  LogMemo.Lines.Add(DateTimeToStr(Now)+ ': ' + AText);
end;

procedure TMainForm.TetheringAppProfile1AcceptResource(const Sender: TObject;
  const AProfileId: string; const AResource: TCustomRemoteItem;
  var AcceptResource: Boolean);
begin
  AcceptResource := True;
end;

procedure TMainForm.TetheringAppProfile1Resources0ResourceReceived(
  const Sender: TObject; const AResource: TRemoteResource);
begin
  Log('Resource Received: ' + AResource.Value.AsString);
end;

procedure TMainForm.TetheringManager1PairedFromLocal(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  Log('Paired with client');
end;

end.
