unit REST.Data.Main;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Authenticator.OAuth;

type
  TdmMain = class(TDataModule)
    RESTGitHub: TRESTClient;
    RESTAdapterGitHub: TRESTResponseDataSetAdapter;
    dsResponse: TFDMemTable;
    RESTRequestGitHub: TRESTRequest;
    RESTResponseGitHub: TRESTResponse;
    authGitHub: TOAuth2Authenticator;
    OAuth2Authenticator1: TOAuth2Authenticator;
  private
    function FormatResponse(AResponse: TRESTResponse): string;
  public
    function ParseParams(AURL: string): TRESTRequestParameterList;

    function DoRequestUser(AUser: string): string;
    function DoRequestCustom(AResource: string): string;
    function DoRequestHello: string;
    function DoNavigate: string;
    procedure DoAuthorize;
  end;

var
  dmMain: TdmMain;

implementation

uses
  System.JSON, REST.JSON;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TdmMain }

procedure TdmMain.DoAuthorize;
begin
  //OAuth2Authenticator1.Authenticate();
end;

function TdmMain.DoNavigate: string;
begin
  RESTRequestGitHub.Execute;
  Result := FormatResponse(RESTResponseGitHub);
end;

function TdmMain.DoRequestCustom(AResource: string): string;
begin
  RESTRequestGitHub.Resource := AResource;
  RESTRequestGitHub.Execute;
  Result := FormatResponse(RESTResponseGitHub);
end;

function TdmMain.DoRequestHello: string;
begin
  RESTRequestGitHub.Resource := 'zen';
  RESTRequestGitHub.Execute;
  Result := RESTResponseGitHub.Content;
end;

function TdmMain.DoRequestUser(AUser: string): string;
begin
  RESTRequestGitHub.Resource := 'users/' + AUSer;
  RESTRequestGitHub.Execute;

  Result := FormatResponse(RESTResponseGitHub);
end;

function TdmMain.FormatResponse(AResponse: TRESTResponse): string;
var
  LJSON: TJSONValue;
begin
  Result := '';
  LJSON := nil;

  if AResponse.ContentType = 'application/json' then
    LJSON := AResponse.JSONValue;

  if Assigned(LJSON) then
    Result := TJson.Format(LJSON)
  else
    Result := AResponse.Content;
end;

function TdmMain.ParseParams(AURL: string): TRESTRequestParameterList;
var
  LResource: string;
begin
  if Pos(RESTGitHub.BaseURL, AURL) > 0 then
  begin
    LResource := Copy(AURL, 1 + Length(RESTGitHub.BaseURL), 200);
    RESTRequestGitHub.Resource := LResource;
    Result := RESTRequestGitHub.Params;
  end
  else
    Result := nil;
end;

end.
