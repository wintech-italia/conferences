unit LangDemo.Form.About;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

const
  URL_WINTECH    = 'http://www.wintech-italia.it';
  URL_PAOLOROSSI = 'http://www.paolorossi.net';

type
  TfrmAbout = class(TForm)
    imgWintech: TImage;
    imgPaolo: TImage;
    procedure imgPaoloClick(Sender: TObject);
    procedure imgWintechClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses
  Winapi.ShellAPI;

{$R *.dfm}

procedure TfrmAbout.imgPaoloClick(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar(URL_PAOLOROSSI), '', '', SW_SHOWNORMAL);
end;

procedure TfrmAbout.imgWintechClick(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar(URL_WINTECH), '', '', SW_SHOWNORMAL);
end;

end.
