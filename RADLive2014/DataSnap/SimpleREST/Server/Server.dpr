program Server;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  REST.Form.Server in 'REST.Form.Server.pas' {frmServer},
  REST.Methods.Server in 'REST.Methods.Server.pas' {ServerMethods1: TDataModule},
  REST.Module.Web in 'REST.Module.Web.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmServer, frmServer);
  Application.Run;
end.
