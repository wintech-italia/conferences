program TetherServer;

uses
  Vcl.Forms,
  TetherServer.Form.Main in 'TetherServer.Form.Main.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
