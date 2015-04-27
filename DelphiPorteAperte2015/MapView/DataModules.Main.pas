unit DataModules.Main;

interface

uses
  System.SysUtils, System.Classes, System.Sensors, System.Sensors.Components
  , System.Threading, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.Text, FireDAC.Stan.StorageBin, System.ImageList,
  FMX.ImgList
  ;

type
  TMainData = class(TDataModule)
    PartecipantiDataSet: TFDMemTable;
    PartecipantiDataSetCitta: TStringField;
    PartecipantiDataSetQuantita: TIntegerField;
  private
    FGeocoder: TGeocoder;
    function GetGeocoder: TGeocoder;
  protected
    procedure OnGeocodeHandler(const Coords: TArray<TLocationCoord2D>);
  public
    FGeocoderHandlerAnon: TProc<TArray<TLocationCoord2D>>;
    property Geocoder: TGeocoder read GetGeocoder;
  end;

var
  MainData: TMainData;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

function TMainData.GetGeocoder: TGeocoder;
begin
  if not Assigned(FGeocoder) then
  begin
    FGeocoder := TGeocoder.Current.Create;
    FGeocoder.OnGeocode := OnGeocodeHandler;
  end;
  Result := FGeocoder;
end;


procedure TMainData.OnGeocodeHandler(const Coords: TArray<TLocationCoord2D>);
begin
  if Assigned(FGeocoderHandlerAnon) then
    FGeocoderHandlerAnon(Coords);
end;

end.

