object dmMain: TdmMain
  OldCreateOrder = False
  Height = 361
  Width = 694
  object RESTGitHub: TRESTClient
    Authenticator = authGitHub
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'https://api.github.com'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 64
    Top = 32
  end
  object RESTAdapterGitHub: TRESTResponseDataSetAdapter
    Dataset = dsResponse
    FieldDefs = <>
    Response = RESTResponseGitHub
    Left = 184
    Top = 176
  end
  object dsResponse: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 280
    Top = 176
  end
  object RESTRequestGitHub: TRESTRequest
    Client = RESTGitHub
    Params = <>
    Resource = 'zen'
    Response = RESTResponseGitHub
    SynchronizedEvents = False
    Left = 64
    Top = 112
  end
  object RESTResponseGitHub: TRESTResponse
    ContentType = 'text/plain'
    Left = 64
    Top = 176
  end
  object authGitHub: TOAuth2Authenticator
    AccessToken = 'b0c81e164a3932389540a449a0045c8212fe2ce1'
    Left = 144
    Top = 32
  end
  object OAuth2Authenticator1: TOAuth2Authenticator
    AccessToken = '370963fee50f46aa83e9f595598a07717248e3cb'
    AccessTokenEndpoint = 'https://github.com/login/oauth/access_token'
    AuthorizationEndpoint = 'https://github.com/login/oauth/authorize'
    ClientID = 'f031285a0910838a48b5'
    ClientSecret = 'f29ffb8751bf1790ec18c800c902a053ea906c90'
    RedirectionEndpoint = 'http://www.delphiday.it'
    TokenType = ttBEARER
    Left = 360
    Top = 112
  end
end
