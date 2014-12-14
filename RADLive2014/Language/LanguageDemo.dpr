program LanguageDemo;

uses
  Vcl.Forms,
  LangDemo.Form.Main in 'LangDemo.Form.Main.pas' {frmMain},
  LangDemo.Form.Helpers in 'LangDemo.Form.Helpers.pas' {frmHelpers},
  LangDemo.Module.Main in 'LangDemo.Module.Main.pas' {dmMain: TDataModule},
  LangDemo.Form.About in 'LangDemo.Form.About.pas' {frmAbout},
  LangDemo.Form.DynArrays in 'LangDemo.Form.DynArrays.pas' {frmDynArrays},
  LangDemo.Form.Generics in 'LangDemo.Form.Generics.pas' {frmGenerics},
  LangDemo.Form.AnonMethods in 'LangDemo.Form.AnonMethods.pas' {frmAnonMethods},
  LangDemo.Form.Records in 'LangDemo.Form.Records.pas' {frmRecords},
  LangDemo.Form.RTTI in 'LangDemo.Form.RTTI.pas' {frmRTTI};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmHelpers, frmHelpers);
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmDynArrays, frmDynArrays);
  Application.CreateForm(TfrmGenerics, frmGenerics);
  Application.CreateForm(TfrmAnonMethods, frmAnonMethods);
  Application.CreateForm(TfrmRecords, frmRecords);
  Application.CreateForm(TfrmRTTI, frmRTTI);
  Application.Run;
end.
