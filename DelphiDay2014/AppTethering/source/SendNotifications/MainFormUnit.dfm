object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 289
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 16
    Top = 16
    Width = 337
    Height = 21
    TabOrder = 0
    Text = 'Message here'
  end
  object Button1: TButton
    Left = 360
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 1
    OnClick = Button1Click
  end
  object KinveyProvider1: TKinveyProvider
    ApiVersion = '3'
    AppKey = 'kid_TPQyMLnzIO'
    AppSecret = '42539fade5d544b5b31ddcd5892eeb56'
    MasterSecret = '9439eafb95024f378ebb6c0cf2860ca9'
    UserName = 'andrea'
    Password = 'password'
    AndroidPush.GCMAppID = '64869271271'
    PushEndpoint = 'MyMessage'
    Left = 224
    Top = 96
  end
  object BackendPush1: TBackendPush
    Provider = KinveyProvider1
    Extras = <>
    Left = 224
    Top = 152
  end
end
