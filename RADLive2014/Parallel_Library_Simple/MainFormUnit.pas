unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.ComCtrls;

type
  TMainForm = class(TForm)
    IdHTTP1: TIdHTTP;
    Image1: TImage;
    Panel1: TPanel;
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
    FIndex: Integer;
  public
    { Public declarations }
  end;

const
  URLs: array [0..1] of string = (
    'http://www.hdwallpapers3d.com/wp-content/uploads/abstract-wallpaper1.jpg',
    'http://www.hdwallpapers3d.com/wp-content/uploads/2014-tesla-model-s_100436548_m.jpg'
  );

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  JPEG
  , System.Threading;

procedure TMainForm.Image1Click(Sender: TObject);
var
  LResponse: TMemoryStream;
  LJPEG: TJPEGImage;
begin
  if FIndex = 0 then
    FIndex := 1
  else
    FIndex := 0;

  Panel1.Caption := 'Downloading ' + URLs[FIndex];

TTask.Create(procedure begin

  LResponse := TMemoryStream.Create;
  try
    IdHTTP1.Get(URLs[FIndex], LResponse);
    LResponse.Position := 0;

    LJPEG := TJPEGImage.Create;
    try
      LJPEG.LoadFromStream(LResponse);

TThread.Synchronize(nil, procedure begin
      Image1.Picture.Assign(LJPEG);
//      Panel1.Caption := 'Completed';
end);

    finally
      LJPEG.Free;
    end;
  finally
    LResponse.Free;
  end;
end).Start;
end;

end.
