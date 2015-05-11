unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Maps,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit
  , System.Sensors
  , System.Threading, System.Sensors.Components, FMX.TabControl
  , DataModules.Main, FMX.ListBox, FMX.ListView.Types, FMX.ListView,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Objects,
  FMX.MultiView, System.Actions, FMX.ActnList, System.ImageList, FMX.ImgList
  , Generics.Collections, FMX.ScrollBox, FMX.Memo
  ;

type
  TVarProc<T> = reference to procedure (var Arg1: T);

  TMainForm = class(TForm)
    MapView: TMapView;
    Image1: TImage;
    TabControlMain: TTabControl;
    TabItemMap: TTabItem;
    TabItemList: TTabItem;
    ActionListMain: TActionList;
    ActionPartecipanti: TAction;
    ActionVicinanza: TAction;
    ActionWintech: TAction;
    ImageListMain: TImageList;
    BindingsList1: TBindingsList;
    ListViewPartecipanti: TListView;
    Memo1: TMemo;
    BindSourceDB1: TBindSourceDB;
    LinkListControlToField1: TLinkListControlToField;
    MultiViewMain: TMultiView;
    ActionMapSatellite: TAction;
    ActionMapIbrida: TAction;
    ActionMapNormal: TAction;
    Image2: TImage;
    ListBoxMenu: TListBox;
    lbiVicinanze: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ToolBar1: TToolBar;
    Button1: TButton;
    Label1: TLabel;
    TrackBarVicinanze: TTrackBar;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ActionPartecipantiExecute(Sender: TObject);
    procedure ActionVicinanzaExecute(Sender: TObject);
    procedure ActionWintechExecute(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure lbiVicinanzeClick(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListViewPartecipantiItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure MapViewMarkerClick(Marker: TMapMarker);
    procedure ActionMapSatelliteExecute(Sender: TObject);
    procedure ActionMapNormalExecute(Sender: TObject);
    procedure ActionMapIbridaExecute(Sender: TObject);
    procedure ListBoxItem4Click(Sender: TObject);
    procedure ListBoxItem5Click(Sender: TObject);
    procedure ListBoxItem6Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure TrackBarVicinanzeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FSheratonCoord: TLocationCoord2D;
    FWintechCoord: TLocationCoord2D;
    FMarkerWintech: TMapMarker;

    FMarkersDictionary: TDictionary<string, TMapMarker>;
    FCircleVicinanze: TMapCircle;
    procedure SetRaggioVicinanze(const Value: Integer);

    function AddMarker(ALocation: TMapCoordinate; AName: string;
      ASnippet: string = ''; ABeforeAdd: TVarProc<TMapMarkerDescriptor> = nil): TMapMarker; overload;
    procedure AddMarker(AIndirizzo: string; AName: string;
      ASnippet: string = ''; ABeforeAdd: TVarProc<TMapMarkerDescriptor> = nil); overload;

    procedure ClearMarkers;

    procedure SetMapLocation(ALocation: TLocationCoord2D);
    function EvidenziaVicinanze(ACoord: TLocationCoord2D; ARaggioKM: Integer): TMapCircle;
    procedure AggiungiMarkerWintech;
    procedure SetCircleVicinanze(const Value: TMapCircle);
    function GetRaggioVicinanze: Integer;
  public
    property RaggioVicinanze: Integer read GetRaggioVicinanze write SetRaggioVicinanze;
    property CircleVicinanze: TMapCircle read FCircleVicinanze write SetCircleVicinanze;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses FireDAC.Comp.Client
// , FMX.Maps.Android
{$IFDEF ANDROID}
 , Androidapi.Helpers
 , Androidapi.JNI.PlayServices
{$ENDIF}
 ;

function TMainForm.AddMarker(ALocation: TMapCoordinate; AName: string;
  ASnippet: string; ABeforeAdd: TVarProc<TMapMarkerDescriptor>): TMapMarker;
var
  LDescriptor: TMapMarkerDescriptor;
begin
  LDescriptor := TMapMarkerDescriptor.Create(ALocation, AName);
  LDescriptor.Snippet := ASnippet;
  if Assigned(ABeforeAdd) then
    ABeforeAdd(LDescriptor);
  Result := MapView.AddMarker(LDescriptor);
end;

function TMainForm.EvidenziaVicinanze(ACoord: TLocationCoord2D; ARaggioKM: Integer): TMapCircle;
var
  LMapCircle: TMapCircleDescriptor;
begin
  LMapCircle := TMapCircleDescriptor.Create(
    TMapCoordinate.Create(ACoord.Latitude, ACoord.Longitude)
    , ARaggioKM * 1000
  );

  LMapCircle.FillColor := TAlphaColorF.Create(1, 0, 0, 0.5).ToAlphaColor;
  LMapCircle.StrokeWidth := 1;
  LMapCircle.StrokeColor := TAlphaColorRec.Red;

  Result := MapView.AddCircle(LMapCircle);
end;

procedure TMainForm.ActionMapIbridaExecute(Sender: TObject);
begin
  MapView.MapType := TMapType.Hybrid;
end;

procedure TMainForm.ActionMapNormalExecute(Sender: TObject);
begin
  MapView.MapType := TMapType.Normal;
end;

procedure TMainForm.ActionMapSatelliteExecute(Sender: TObject);
begin
  MapView.MapType := TMapType.Satellite;
end;

procedure TMainForm.ActionPartecipantiExecute(Sender: TObject);
var
  LPartecipanti: Integer;
  LCitta: string;
  LDataSet: TFDMemTable;
begin
  LDataSet := MainData.PartecipantiDataSet;

  ClearMarkers;

  LDataSet.DisableControls;
  try
    LDataSet.First;
    while not LDataSet.Eof do
    begin
      LCitta := LDataSet.FieldByName('Citta').AsString;
      LPartecipanti := LDataSet.FieldByName('Quantita').AsInteger;
      AddMarker(
        LCitta
        , LCitta
        , 'Persone: ' + LPartecipanti.ToString
      );

      LDataSet.Next;
    end;
  finally
    LDataSet.EnableControls;
  end;
end;

procedure TMainForm.ActionVicinanzaExecute(Sender: TObject);
begin
  CircleVicinanze := EvidenziaVicinanze(FSheratonCoord, RaggioVicinanze);
  SetMapLocation(FSheratonCoord);
end;

procedure TMainForm.ActionWintechExecute(Sender: TObject);
begin
  if not Assigned(FMarkerWintech) then
    AggiungiMarkerWintech;
  SetMapLocation(FWintechCoord);
end;

procedure TMainForm.AddMarker(AIndirizzo, AName, ASnippet: string;
  ABeforeAdd: TVarProc<TMapMarkerDescriptor>);
var
  LAddress: TCivicAddress;
begin
  LAddress := TCivicAddress.Create;
  LAddress.Address := AIndirizzo;
  MainData.FGeocoderHandlerAnon :=
    procedure(Coords: TArray<TLocationCoord2D>)
    begin
      if Length(Coords)>0 then
      begin
        FMarkersDictionary.Add(
          AIndirizzo
          , AddMarker(
            TMapCoordinate.Create(Coords[0].Latitude, Coords[0].Longitude)
            , AName
            , ASnippet
            , ABeforeAdd));
      end;
    end;
  MainData.Geocoder.Geocode(LAddress);
end;

procedure TMainForm.AggiungiMarkerWintech;
begin
  FMarkerWintech := AddMarker(TMapCoordinate.Create(FWintechCoord.Latitude, FWintechCoord.Longitude), 'Wintech-Italia s.r.l.', 'www.wintech-italia.it',
    procedure(var ADescriptor: TMapMarkerDescriptor)
    begin
{$IFDEF ANDROID}
      TJMapsInitializer.JavaClass.initialize(SharedActivity);
{$ENDIF}
      ADescriptor.Icon := Image1.Bitmap;
    end
  );
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  MultiViewMain.Visible := not MultiViewMain.Visible;
end;

procedure TMainForm.ClearMarkers;
var
  LPair: TPair<string, TMapMarker>;
begin
  for LPair in FMarkersDictionary do
  begin
    LPair.Value.Remove;
  end;
  FMarkersDictionary.Clear;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TabControlMain.ActiveTab := TabItemMap;
  FMarkersDictionary := TDictionary<string, TMapMarker>.Create;

  FSheratonCoord.Latitude := 45.416142;
  FSheratonCoord.Longitude := 11.933284;

  FWintechCoord.Latitude := 44.8111628;
  FWintechCoord.Longitude := 10.330826;

  SetMapLocation(FSheratonCoord);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FMarkersDictionary.Free;
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkMenu then
    MultiViewMain.Visible := not   MultiViewMain.Visible;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  MultiViewMain.Visible := False;
end;

function TMainForm.GetRaggioVicinanze: Integer;
begin
  Result := Trunc(TrackBarVicinanze.Value);
end;

procedure TMainForm.ListBoxItem1Click(Sender: TObject);
begin
  MultiViewMain.HideMaster;

  ActionPartecipanti.Execute;
end;

procedure TMainForm.lbiVicinanzeClick(Sender: TObject);
begin
  MultiViewMain.Visible := False;

  ActionVicinanza.Execute;
end;

procedure TMainForm.ListBoxItem3Click(Sender: TObject);
begin
  MultiViewMain.Visible := False;

  ActionWintech.Execute;
end;

procedure TMainForm.ListBoxItem4Click(Sender: TObject);
begin
  MultiViewMain.Visible := False;

  ActionMapNormal.Execute;
end;

procedure TMainForm.ListBoxItem5Click(Sender: TObject);
begin
  MultiViewMain.Visible := False;

  ActionMapSatellite.Execute;
end;

procedure TMainForm.ListBoxItem6Click(Sender: TObject);
begin
  MultiViewMain.Visible := False;

  ActionMapIbrida.Execute;
end;

procedure TMainForm.ListViewPartecipantiItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LMarker: TMapMarker;
begin
  if FMarkersDictionary.TryGetValue(AItem.Text, LMarker) then
  begin
    TabControlMain.ActiveTab := TabItemMap;
    MapView.Location := LMarker.Descriptor.Position;
  end;
end;

procedure TMainForm.MapViewMarkerClick(Marker: TMapMarker);
begin
  MainData.PartecipantiDataSet.Locate('Citta', Marker.Descriptor.Title);
end;

procedure TMainForm.SetCircleVicinanze(const Value: TMapCircle);
begin
  if Assigned(FCircleVicinanze) then
  begin
    FCircleVicinanze.Remove;
    FreeAndNil(FCircleVicinanze);
  end;

  FCircleVicinanze := Value;
end;

procedure TMainForm.SetMapLocation(ALocation: TLocationCoord2D);
begin
  MapView.Location := TMapCoordinate.Create(ALocation.Latitude, ALocation.Longitude);
end;

procedure TMainForm.SetRaggioVicinanze(const Value: Integer);
begin
  TrackBarVicinanze.Value := Value;
  lbiVicinanze.Text := Trunc(TrackBarVicinanze.Value).ToString + 'km';
end;

procedure TMainForm.TrackBarVicinanzeChange(Sender: TObject);
begin
  RaggioVicinanze := Trunc(TrackBarVicinanze.Value);
end;

end.
