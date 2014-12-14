object frmHelpers: TfrmHelpers
  Left = 0
  Top = 0
  Caption = 'Helpers (Type, Record Class)'
  ClientHeight = 220
  ClientWidth = 603
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnSimpleHelpers: TButton
    Left = 24
    Top = 32
    Width = 113
    Height = 33
    Caption = 'Simple Type Helpers'
    TabOrder = 0
    OnClick = btnSimpleHelpersClick
  end
  object btnEnumHelpers: TButton
    Left = 24
    Top = 71
    Width = 113
    Height = 34
    Caption = 'Enum Helpers'
    TabOrder = 1
    OnClick = btnEnumHelpersClick
  end
  object btnAray: TButton
    Left = 24
    Top = 111
    Width = 113
    Height = 34
    Caption = 'DynArrays Helpers'
    TabOrder = 2
    OnClick = btnArayClick
  end
  object btnClassHelper: TButton
    Left = 24
    Top = 151
    Width = 113
    Height = 34
    Caption = 'Class Helpers'
    TabOrder = 3
    OnClick = btnClassHelperClick
  end
  object mmoLog: TMemo
    Left = 152
    Top = 38
    Width = 425
    Height = 153
    TabOrder = 4
  end
  object dsTest: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    AutoCommitUpdates = False
    Left = 352
    Top = 56
    object dsTestName: TStringField
      FieldName = 'Name'
    end
    object dsTestAge: TIntegerField
      FieldName = 'Age'
    end
  end
end
