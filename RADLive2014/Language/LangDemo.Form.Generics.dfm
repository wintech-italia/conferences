object frmGenerics: TfrmGenerics
  Left = 0
  Top = 0
  Caption = 'Generics Demo'
  ClientHeight = 258
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnObjectList: TButton
    Left = 24
    Top = 32
    Width = 113
    Height = 33
    Caption = 'Object List'
    TabOrder = 0
    OnClick = btnObjectListClick
  end
  object btnGenericList: TButton
    Left = 24
    Top = 127
    Width = 113
    Height = 33
    Caption = 'Generic List'
    TabOrder = 1
    OnClick = btnGenericListClick
  end
  object btnDerivedGeneric: TButton
    Left = 24
    Top = 166
    Width = 113
    Height = 33
    Caption = 'Derived Generic'
    TabOrder = 2
    OnClick = btnDerivedGenericClick
  end
  object btnDerivedList: TButton
    Left = 24
    Top = 71
    Width = 113
    Height = 33
    Caption = 'Object List'
    TabOrder = 3
    OnClick = btnDerivedListClick
  end
end
