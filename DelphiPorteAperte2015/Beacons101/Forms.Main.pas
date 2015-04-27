unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Beacon,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, System.Beacon.Components,
  FMX.StdCtrls, FMX.Layouts, FMX.ListView.Types, FMX.ListView, FMX.Edit,
  FMX.ListBox;

type
  TMainForm = class(TForm)
    Beacon1: TBeacon;
    Layout1: TLayout;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Switch1: TSwitch;
    Label2: TLabel;
    Layout2: TLayout;
    Label8: TLabel;
    ListBox1: TListBox;
    lbiIDs: TListBoxItem;
    lbiDistance: TListBoxItem;
    lbiProximity: TListBoxItem;
    lbiRssi: TListBoxItem;
    lbiLastUpdate: TListBoxItem;
    procedure Timer1Timer(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

function BeaconProximityToStr(const ABeaconProximity: TBeaconProximity): string;
begin
  case ABeaconProximity of
    TBeaconProximity.Immediate: result := 'Immediate';
    TBeaconProximity.Near: result := 'Near';
    TBeaconProximity.Far: result := 'Far';
    TBeaconProximity.Away: result := 'Away';
  end;
end;

procedure TMainForm.Switch1Switch(Sender: TObject);
begin
  Timer1.Enabled := Switch1.IsChecked;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  LNearestBeacon: IBeacon;
  LItem: TListViewItem;
begin
  LNearestBeacon := Beacon1.Nearest;
  if Assigned(LNearestBeacon) and LNearestBeacon.ItsAlive then
  begin
    lbiIDs.ItemData.Detail        := LNearestBeacon.Major.ToString + '/' + LNearestBeacon.Minor.ToString;
    lbiDistance.ItemData.Detail   := LNearestBeacon.Distance.ToString(TFloatFormat.ffFixed, 15, 2) + 'm';
    lbiProximity.ItemData.Detail  := BeaconProximityToStr(LNearestBeacon.Proximity);
    lbiRssi.ItemData.Detail       := LNearestBeacon.Rssi.ToString();
    lbiLastUpdate.ItemData.Detail := TimeToStr(Now);
  end;
end;

end.
