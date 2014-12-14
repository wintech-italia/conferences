object frmDynArrays: TfrmDynArrays
  Left = 0
  Top = 0
  Caption = 'Dynamic Arrays'
  ClientHeight = 163
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnArrayInit: TButton
    Left = 24
    Top = 24
    Width = 113
    Height = 33
    Caption = 'Initialization'
    TabOrder = 0
    OnClick = btnArrayInitClick
  end
  object btnArrayRTL: TButton
    Left = 24
    Top = 63
    Width = 113
    Height = 34
    Caption = 'Array RTL'
    TabOrder = 1
    OnClick = btnArrayRTLClick
  end
  object mmoLog: TMemo
    Left = 152
    Top = 24
    Width = 345
    Height = 121
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
end
