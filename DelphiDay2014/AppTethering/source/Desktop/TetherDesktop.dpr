program TetherDesktop;

uses
  Vcl.Forms,
  TetherWin.Form.Main in 'TetherWin.Form.Main.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
