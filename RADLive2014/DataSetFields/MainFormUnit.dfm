object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 404
  ClientWidth = 687
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
  object DBGrid1: TDBGrid
    Left = 16
    Top = 39
    Width = 481
    Height = 236
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnReopen: TButton
    Left = 16
    Top = 8
    Width = 75
    Height = 25
    Caption = 'btnReopen'
    TabOrder = 1
    OnClick = btnReopenClick
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=EMPLOYEE')
    LoginPrompt = False
    Left = 379
    Top = 56
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 563
    Top = 80
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 563
    Top = 136
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 379
    Top = 199
  end
  object FDQuery1: TFDQuery
    OnCalcFields = FDQuery1CalcFields
    Connection = FDConnection1
    SQL.Strings = (
      'select * from EMPLOYEE')
    Left = 376
    Top = 120
    object FDQuery1Calcolato: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Calcolato'
      Calculated = True
    end
  end
end
