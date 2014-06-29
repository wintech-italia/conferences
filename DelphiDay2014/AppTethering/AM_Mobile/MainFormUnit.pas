unit MainFormUnit;

interface

{
  Demo: AppTethering, Mobile App
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
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Edit, FMX.Layouts, FMX.Memo, Fmx.Platform, IPPeerClient,
  IPPeerServer, System.Tether.Manager, System.Tether.AppProfile, System.Actions,
  FMX.ActnList, System.JSON, FMX.ListView.Types, FMX.ListView
  , System.Messaging
{$IFDEF ANDROID}
  , Androidapi.JNI.App
  , Androidapi.JNIBridge
  , Androidapi.JNI.GraphicsContentViewText
  , FMX.Helpers.Android
  , Androidapi.JNI.JavaTypes
  , Androidapi.Helpers
  , FMX.Platform.Android
{$ENDIF}
  , FMX.Objects;

type
  TMainForm = class(TForm)
    ButtonScan: TButton;
    LayoutTop: TLayout;
    LayoutBottom: TLayout;
    ButtonClearLog: TButton;
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    btnDiscover: TButton;
    lvScan: TListView;
    meScanText: TMemo;
    lbMessage: TLabel;
    StyleBook1: TStyleBook;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    procedure ButtonScanClick(Sender: TObject);
    procedure ButtonClearLogClick(Sender: TObject);
    procedure TetheringManager1PairedToRemote(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure btnDiscoverClick(Sender: TObject);
    procedure PushEvents1DeviceTokenRequestFailed(Sender: TObject;
      const AErrorMessage: string);
    procedure lvScanItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    const SCAN_REQUEST_CODE = 0;
    const TETHERING_TIMEOUT = 3000; // 3 seconds

    var FMessageSubscriptionID: Integer;

    procedure HandleActivityMessage(const Sender: TObject; const M: TMessage);
    function OnActivityResult(RequestCode, ResultCode: Integer; Data: JIntent): Boolean;
    procedure DoScanSuccessful(const AContent, AFormat: string);
    procedure ClearLog;
    procedure LogMessage(const AString: string);
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.ButtonScanClick(Sender: TObject);
{$IFDEF ANDROID}
var
  Intent: JIntent;
{$ENDIF}
begin
  {
    Start an Android app using an intent and handle onActivityResult event
    Info: http://blong.com/Articles/DelphiXE6AndroidActivityResult/ActivityResult.htm
  }

{$IFDEF ANDROID}
  FMessageSubscriptionID := TMessageManager.DefaultManager.SubscribeToMessage(
    TMessageResultNotification, HandleActivityMessage);

  // launch Barcode Scanner in SCAN mode
  Intent := TJIntent.JavaClass.init(StringToJString('com.google.zxing.client.android.SCAN'));
  Intent.setPackage(StringToJString('com.google.zxing.client.android'));
  Intent.putExtra(StringToJString('SCAN_MODE'), StringToJString('ONE_D_MODE,QR_CODE_MODE,PRODUCT_MODE,DATA_MATRIX_MODE'));

  SharedActivity.startActivityForResult(Intent, SCAN_REQUEST_CODE);
{$ENDIF}
end;

procedure TMainForm.ClearLog;
begin
  lvScan.Items.Clear;
  meScanText.Text := '';
end;

procedure TMainForm.DoScanSuccessful(const AContent, AFormat: string);
var
  LInformation: string;
  LItem: TListViewItem;
begin
  // build information token
  LInformation := Format('%s (%s)', [AContent, AFormat]);

  // add to local GUI
  LItem := lvScan.Items.Add;
  LItem.Text := TimeToStr(Now) + ': ' + AFormat;
  LItem.Data['ScanText'] := AContent;

  // update shared resource (AppTethering)
  TetheringAppProfile1.Resources.FindByName('Barcode').Value := LInformation;
end;

procedure TMainForm.HandleActivityMessage(const Sender: TObject;
  const M: TMessage);
begin
  if M is TMessageResultNotification then
    OnActivityResult(
      TMessageResultNotification(M).RequestCode,
      TMessageResultNotification(M).ResultCode,
      TMessageResultNotification(M).Value);
end;

procedure TMainForm.btnDiscoverClick(Sender: TObject);
begin
  LogMessage('Discovering...');
  TetheringManager1.AutoConnect(TETHERING_TIMEOUT);
end;

procedure TMainForm.ButtonClearLogClick(Sender: TObject);
begin
  ClearLog;
end;

procedure TMainForm.LogMessage(const AString: string);
begin
  lbMessage.Text := AString;
end;

procedure TMainForm.lvScanItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  meScanText.Text := AItem.Data['ScanText'].ToString;
end;

function TMainForm.OnActivityResult(RequestCode, ResultCode: Integer;
  Data: JIntent): Boolean;
var
  LScanContent, LScanFormat: string;
begin
  Result := False;

{$IFDEF ANDROID}
  TMessageManager.DefaultManager.Unsubscribe(TMessageResultNotification, FMessageSubscriptionID);
  FMessageSubscriptionID := 0;

  if RequestCode = SCAN_REQUEST_CODE then
  begin
    if ResultCode = TJActivity.JavaClass.RESULT_OK then
    begin
      Result := True;

      if Assigned(Data) then
      begin
        LScanContent := JStringToString(Data.getStringExtra(StringToJString('SCAN_RESULT')));
        LScanFormat := JStringToString(Data.getStringExtra(StringToJString('SCAN_RESULT_FORMAT')));
        TThread.Synchronize(nil,
          procedure
          begin
            DoScanSuccessful(LScanContent, LScanFormat);
            Realign; // avoid GUI glitches
          end
        );
      end;
    end;
  end;
{$ENDIF}
end;

procedure TMainForm.PushEvents1DeviceTokenRequestFailed(Sender: TObject;
  const AErrorMessage: string);
begin
  LogMessage('Error: ' + AErrorMessage);
end;

procedure TMainForm.TetheringManager1PairedToRemote(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  LogMessage('Paired with server!');
end;

end.
