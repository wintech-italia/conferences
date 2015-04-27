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
    Layout2: TLayout;
    LabelClick: TLabel;
    ActionListMain: TActionList;
    ActionPartecipanti: TAction;
    ActionVicinanza: TAction;
    ActionWintech: TAction;
    ImageListMain: TImageList;
    Layout1: TLayout;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    BindingsList1: TBindingsList;
    ListViewPartecipanti: TListView;
    Memo1: TMemo;
    BindSourceDB1: TBindSourceDB;
    LinkListControlToField1: TLinkListControlToField;
    Layout3: TLayout;
    ButtonIbr: TButton;
    ButtonMap: TButton;
    ButtonSat: TButton;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure MapViewMapClick(const Position: TMapCoordinate);
    procedure ActionPartecipantiExecute(Sender: TObject);
    procedure ActionVicinanzaExecute(Sender: TObject);
    procedure ActionWintechExecute(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListViewPartecipantiItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ButtonSatClick(Sender: TObject);
    procedure ButtonMapClick(Sender: TObject);
    procedure ButtonIbrClick(Sender: TObject);
    procedure MapViewMarkerClick(Marker: TMapMarker);
  private
    FSheratonCoord: TLocationCoord2D;
    FWintechCoord: TLocationCoord2D;
    FWintechMarker: TMapMarker;

    FMarkersDictionary: TDictionary<string, TMapMarker>;

    function AddMarker(ALocation: TMapCoordinate; AName: string;
      ASnippet: string = ''; ABeforeAdd: TVarProc<TMapMarkerDescriptor> = nil): TMapMarker; overload;
    procedure AddMarker(AIndirizzo: string; AName: string;
      ASnippet: string = ''; ABeforeAdd: TVarProc<TMapMarkerDescriptor> = nil); overload;

    procedure LoadDataSet;
    procedure ClearMarkers;

    procedure SetMapLocation(ALocation: TLocationCoord2D);
    procedure EvidenziaVicinanze(ACoord: TLocationCoord2D; ARaggioKM: Integer);
    procedure AggiungiMarkerWintech;
  public
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

procedure TMainForm.EvidenziaVicinanze(ACoord: TLocationCoord2D; ARaggioKM: Integer);
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

  MapView.AddCircle(LMapCircle);
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
  EvidenziaVicinanze(FSheratonCoord, 100);
  SetMapLocation(FSheratonCoord);
end;

procedure TMainForm.ActionWintechExecute(Sender: TObject);
begin
  if not Assigned(FWintechMarker) then
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
  FWintechMarker := AddMarker(TMapCoordinate.Create(FWintechCoord.Latitude, FWintechCoord.Longitude), 'Wintech-Italia s.r.l.', 'www.wintech-italia.it',
    procedure(var ADescriptor: TMapMarkerDescriptor)
    begin
{$IFDEF ANDROID}
      TJMapsInitializer.JavaClass.initialize(SharedActivity);
{$ENDIF}
      ADescriptor.Icon := Image1.Bitmap;
    end
  );
end;

procedure TMainForm.ButtonIbrClick(Sender: TObject);
begin
  MapView.MapType := TMapType.Hybrid;
end;

procedure TMainForm.ButtonMapClick(Sender: TObject);
begin
  MapView.MapType := TMapType.Normal;
end;

procedure TMainForm.ButtonSatClick(Sender: TObject);
begin
  MapView.MapType := TMapType.Satellite;
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
  FMarkersDictionary := TDictionary<string, TMapMarker>.Create;

  FSheratonCoord.Latitude := 45.416142;
  FSheratonCoord.Longitude := 11.933284;

  FWintechCoord.Latitude := 44.8111628;
  FWintechCoord.Longitude := 10.330826;

  SetMapLocation(FSheratonCoord);

  LoadDataSet;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FMarkersDictionary.Free;
end;

procedure TMainForm.ListBoxItem1Click(Sender: TObject);
begin
  if ActionPartecipanti.Update then
    ActionPartecipanti.Execute;
end;

procedure TMainForm.ListBoxItem2Click(Sender: TObject);
begin
  if ActionVicinanza.Update then
    ActionVicinanza.Execute;
end;

procedure TMainForm.ListBoxItem3Click(Sender: TObject);
begin
  if ActionWintech.Update then
    ActionWintech.Execute;
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

procedure TMainForm.LoadDataSet;
var
  LIndex: Integer;
  LDataSet: TFDMemTable;
  LCitta: string;
  LPartecipanti: Integer;
begin
  LDataSet := MainData.PartecipantiDataSet;
  LDataSet.DisableControls;
  try
    LDataSet.Active := False;
    LDataSet.Active := True;
    for LIndex := 0 to Memo1.Lines.Count-1 do
    begin
      LCitta := Memo1.Lines.Names[LIndex];
      LPartecipanti := StrToIntDef(Memo1.Lines.ValueFromIndex[LIndex], 0);
      if (LCitta <> '') and (LPartecipanti > 0) then
        LDataSet.AppendRecord([LCitta, LPartecipanti]);
    end;
  finally
    LDataSet.EnableControls;
  end;
end;

procedure TMainForm.MapViewMapClick(const Position: TMapCoordinate);
begin
  LabelClick.Text := Position.ToString;
end;

procedure TMainForm.MapViewMarkerClick(Marker: TMapMarker);
begin
  MainData.PartecipantiDataSet.Locate('Citta', Marker.Descriptor.Title);
end;

procedure TMainForm.SetMapLocation(ALocation: TLocationCoord2D);
begin
  MapView.Location := TMapCoordinate.Create(ALocation.Latitude, ALocation.Longitude);
end;

end.
