unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Beacon,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, System.Beacon.Components,
  FMX.StdCtrls, FMX.Layouts, FMX.ListView.Types, FMX.ListView, FMX.Edit,
  FMX.ListBox, FMX.TabControl, FMX.Objects, FMX.MultiView, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components;

type
  TMainForm = class(TForm)
    Beacon1: TBeacon;
    Timer1: TTimer;
    ToolBarTop: TToolBar;
    Label1: TLabel;
    SwitchScan: TSwitch;
    Label2: TLabel;
    Layout2: TLayout;
    LabelBeacons: TLabel;
    ListBox1: TListBox;
    LabelLastUpdate: TLabel;
    TabControlMain: TTabControl;
    TabItemBeaconList: TTabItem;
    TabItemBeaconMap: TTabItem;
    RectangleQuadrato: TRectangle;
    ImageBeacon1: TImage;
    ImageBeacon2: TImage;
    ImageBeacon3: TImage;
    CircleBeacon1: TCircle;
    CircleBeacon2: TCircle;
    CircleBeacon3: TCircle;
    LabelBeacon1: TLabel;
    LabelBeacon2: TLabel;
    LabelBeacon3: TLabel;
    TabControlLayouts: TTabControl;
    TabItemQuadrato: TTabItem;
    MultiViewMain: TMultiView;
    ListBoxMenu: TListBox;
    Image1: TImage;
    ListBoxItem1: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    TabItemLineare: TTabItem;
    Button1: TButton;
    RectangleStanza: TRectangle;
    ImageBeacon4: TImage;
    Label4: TLabel;
    ImageBeacon5: TImage;
    Label5: TLabel;
    ImageBeacon6: TImage;
    Label6: TLabel;
    LayoutLunghezzaStanza: TLayout;
    TrackBarLunghezzaStanza: TTrackBar;
    LabelLunghezzaStanza: TLabel;
    BindingsList1: TBindingsList;
    LinkControlToPropertyText: TLinkControlToProperty;
    LayoutDimensioneQuadrato: TLayout;
    TrackBarDimensioneQuadrato: TTrackBar;
    LabelDimensioneQuadrato: TLabel;
    LinkControlToPropertyText2: TLinkControlToProperty;
    RectangleBeacon4: TRectangle;
    RectangleBeacon5: TRectangle;
    RectangleBeacon6: TRectangle;
    procedure Timer1Timer(Sender: TObject);
    procedure SwitchScanSwitch(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure ListBoxItem4Click(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateList(const ABeaconList: TBeaconList);
    procedure UpdateMap(const ABeaconList: TBeaconList);
  public
    { Public declarations }
    function FattoreDimensionale: Double;
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

function TMainForm.FattoreDimensionale: Double;
begin
  if TabControlLayouts.ActiveTab = TabItemQuadrato then
    Result := (RectangleQuadrato.Width / TrackBarDimensioneQuadrato.Value)
  else
    Result := (RectangleStanza.Height / TrackBarLunghezzaStanza.Value);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TabControlMain.TabPosition := TTabPosition.None;
  TabControlLayouts.TabPosition := TTabPosition.None;
  TabControlMain.ActiveTab := TabItemBeaconList;
end;

procedure TMainForm.ListBoxItem1Click(Sender: TObject);
begin
  TabControlMain.ActiveTab := TabItemBeaconList;
  MultiViewMain.HideMaster;
end;

procedure TMainForm.ListBoxItem3Click(Sender: TObject);
begin
  TabControlMain.ActiveTab := TabItemBeaconMap;
  TabControlLayouts.ActiveTab := TabItemQuadrato;
  MultiViewMain.HideMaster;
end;

procedure TMainForm.ListBoxItem4Click(Sender: TObject);
begin
  TabControlMain.ActiveTab := TabItemBeaconMap;
  TabControlLayouts.ActiveTab := TabItemLineare;
  MultiViewMain.HideMaster;
end;

procedure TMainForm.SwitchScanSwitch(Sender: TObject);
begin
  Timer1.Enabled := SwitchScan.IsChecked;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  LBeacons: TBeaconList;
begin
  LBeacons := Beacon1.BeaconList;
  LabelBeacons.Text := Length(LBeacons).ToString + ' beacons';

  UpdateList(LBeacons);

  UpdateMap(LBeacons);

  LabelLastUpdate.Text := TimeToStr(Now);
end;

procedure TMainForm.UpdateList(const ABeaconList: TBeaconList);
var
  LBeacon: IBeacon;
  LItem: TListBoxItem;
begin
  ListBox1.BeginUpdate;
  try
    ListBox1.Items.Clear;

    for LBeacon in ABeaconList do
    begin
      LItem := TListBoxItem.Create(ListBox1);
      ListBox1.AddObject(LItem);

      LItem.ItemData.Text := LBeacon.Major.ToString + '/' + LBeacon.Minor.ToString;
      if LBeacon = Beacon1.Nearest then
        LItem.ItemData.Text := '(*) ' + LItem.ItemData.Text;
      LItem.ItemData.Detail  := BeaconProximityToStr(LBeacon.Proximity) + ' ' + LBeacon.Distance.ToString(TFloatFormat.ffFixed, 15, 2) + 'm';;
    end;
  finally
    ListBox1.EndUpdate;
  end;
end;

procedure TMainForm.UpdateMap(const ABeaconList: TBeaconList);
var
  LBeacon: IBeacon;
  LCircle: TCircle;
  LRectangle: TRectangle;
begin
  for LBeacon in ABeaconList do
  begin
    if LBeacon.ItsAlive then
    begin
      LCircle := nil;
      LRectangle := nil;

      if TabControlLayouts.ActiveTab = TabItemQuadrato then
      begin
        case LBeacon.Minor of
          38452: LCircle := CircleBeacon1;
          42125: LCircle := CircleBeacon2;
          51789: LCircle := CircleBeacon3;
        end;
      end
      else
      begin
        case LBeacon.Minor of
          38452: LRectangle := RectangleBeacon4;
          42125: LRectangle := RectangleBeacon5;
          51789: LRectangle := RectangleBeacon6;
        end;
      end;

      if Assigned(LCircle) then
      begin
        LCircle.Size.Width := 2* LBeacon.Distance * FattoreDimensionale;
          LCircle.Size.Height := 2* LBeacon.Distance * FattoreDimensionale;
        if LBeacon = Beacon1.Nearest then
          LCircle.Fill.Kind := TBrushKind.Solid
        else
          LCircle.Fill.Kind := TBrushKind.None;
        LCircle.Stroke.Kind := TBrushKind.Solid;
      end;

      if Assigned(LRectangle) then
      begin
        if LBeacon = Beacon1.Nearest then
          LRectangle.Visible := True
        else
          LRectangle.Visible := False;
      end;

    end;
  end;
end;

end.
