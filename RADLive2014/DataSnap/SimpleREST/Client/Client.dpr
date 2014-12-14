program Client;

uses
  Vcl.Forms,
  REST.Form.Client in 'REST.Form.Client.pas' {frmClient},
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  ClientModuleUnit1 in 'ClientModuleUnit1.pas' {ClientModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmClient, frmClient);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.Run;
end.
