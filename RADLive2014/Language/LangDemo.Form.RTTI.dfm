object frmRTTI: TfrmRTTI
  Left = 0
  Top = 0
  Caption = 'RTTI & Attributes'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnAttributes: TButton
    Left = 32
    Top = 40
    Width = 113
    Height = 33
    Caption = 'Test Attributes'
    TabOrder = 0
    OnClick = btnAttributesClick
  end
  object mmoLog: TMemo
    Left = 161
    Top = 40
    Width = 368
    Height = 129
    TabOrder = 1
  end
end
