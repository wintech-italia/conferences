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
    LabelBeacons: TLabel;
    ListBox1: TListBox;
    LabelLastUpdate: TLabel;
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
  LBeacons: TBeaconList;
  LBeacon: IBeacon;
  LItem: TListBoxItem;
begin
  LBeacons := Beacon1.BeaconList;
  LabelBeacons.Text := Length(LBeacons).ToString + ' beacons';
  ListBox1.BeginUpdate;
  try
    ListBox1.Items.Clear;

    for LBeacon in LBeacons do
    begin
      LItem := TListBoxItem.Create(ListBox1);
      ListBox1.AddObject(LItem);

      LItem.ItemData.Text := LBeacon.Major.ToString + '/' + LBeacon.Minor.ToString;
      LItem.ItemData.Detail  := BeaconProximityToStr(LBeacon.Proximity);

  //    lbiDistance.ItemData.Detail   := LBeacon.Distance.ToString(TFloatFormat.ffFixed, 15, 2) + 'm';
    end;
  finally
    ListBox1.EndUpdate;
  end;

  LabelLastUpdate.Text := TimeToStr(Now);
end;

end.
