object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Server Thetering Application'
  ClientHeight = 289
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object mmoLog: TMemo
    Left = 0
    Top = 80
    Width = 554
    Height = 209
    Align = alBottom
    TabOrder = 0
  end
  object edtSendString: TEdit
    Left = 8
    Top = 10
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Button4: TButton
    Left = 135
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Send Value'
    TabOrder = 2
    OnClick = Button4Click
  end
  object Panel1: TPanel
    Left = 339
    Top = 8
    Width = 207
    Height = 56
    TabOrder = 3
    object Label2: TLabel
      Left = 52
      Top = 2
      Width = 117
      Height = 20
      Caption = 'Internet Time'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'TechnicBold'
      Font.Style = []
      ParentFont = False
    end
    object lblTime: TLabel
      Left = 69
      Top = 25
      Width = 70
      Height = 20
      Caption = 'hh:mm:ss'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'TechnicBold'
      Font.Style = []
      ParentFont = False
    end
  end
  object Button1: TButton
    Left = 8
    Top = 39
    Width = 121
    Height = 25
    Caption = 'Invoke Remote Action'
    TabOrder = 4
    OnClick = Button1Click
  end
  object TetheringManagerServer: TTetheringManager
    OnPairedFromLocal = TetheringManagerServerPairedFromLocal
    OnPairedToRemote = TetheringManagerServerPairedToRemote
    Text = 'Tethering Manager Server'
    Left = 64
    Top = 136
  end
  object TetheringAppProfileServer: TTetheringAppProfile
    Manager = TetheringManagerServer
    Text = 'TetheringAppProfileServer'
    Group = 'BarcodeGroup'
    Actions = <
      item
        Name = 'actAggiungi'
        IsPublic = True
        Action = actAggiungi
        NotifyUpdates = False
      end
      item
        Name = 'actSottrai'
        IsPublic = True
        Action = actSottrai
        NotifyUpdates = False
      end
      item
        Name = 'actReset'
        IsPublic = True
        Action = actReset
        NotifyUpdates = False
      end>
    Resources = <
      item
        Name = 'CurTime'
        IsPublic = True
      end
      item
        Name = 'Barcode'
        IsPublic = True
        Kind = Mirror
        OnResourceReceived = TetheringAppProfileServerResources1ResourceReceived
      end>
    Left = 64
    Top = 208
  end
  object ActionList1: TActionList
    Left = 152
    Top = 40
    object actAggiungi: TAction
      Caption = 'actAggiungi'
    end
    object actSottrai: TAction
      Caption = 'actSottrai'
    end
    object actReset: TAction
      Caption = 'actReset'
    end
    object actShow: TAction
      Caption = 'actShow'
    end
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 192
    Top = 40
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://api.timezonedb.com'
    Params = <>
    HandleRedirects = True
    Left = 392
    Top = 64
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = '?zone=Europe/Rome&format=json&key=174OUE7G6ZKI'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 440
    Top = 64
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 504
    Top = 64
  end
end
