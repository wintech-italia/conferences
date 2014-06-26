program RESTGitHub;

uses
  FMX.Forms,
  REST.Form.Main in 'REST.Form.Main.pas' {frmMain},
  REST.Data.Main in 'REST.Data.Main.pas' {dmMain: TDataModule},
  REST.Dialog.Parameters in 'REST.Dialog.Parameters.pas' {frm_CustomHeaderDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(Tfrm_CustomHeaderDlg, frm_CustomHeaderDlg);
  Application.Run;
end.
