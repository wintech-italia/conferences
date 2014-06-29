program AppTetheringMobile;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
