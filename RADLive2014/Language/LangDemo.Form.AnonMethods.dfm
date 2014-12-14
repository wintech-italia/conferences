object frmAnonMethods: TfrmAnonMethods
  Left = 0
  Top = 0
  Caption = 'Anonymous Thread'
  ClientHeight = 307
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Get Page'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 89
    Top = 39
    Width = 515
    Height = 260
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 89
    Top = 10
    Width = 515
    Height = 21
    TabOrder = 2
    Text = 'http://www.wintech-italia.it'
  end
end
