program MapViewProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  Forms.Main in 'Forms.Main.pas' {MainForm},
  DataModules.Main in 'DataModules.Main.pas' {MainData: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainData, MainData);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
