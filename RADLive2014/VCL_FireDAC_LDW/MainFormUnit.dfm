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
  object DBGrid1: TDBGrid
    Left = 8
    Top = 64
    Width = 481
    Height = 217
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object cbConnected: TCheckBox
    Left = 16
    Top = 16
    Width = 97
    Height = 17
    Caption = 'cbConnected'
    TabOrder = 1
    OnClick = cbConnectedClick
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'MonitorBy=Remote'
      'ConnectionDef=EMPLOYEE')
    LoginPrompt = False
    Left = 384
    Top = 56
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 472
    Top = 56
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 472
    Top = 112
  end
  object FDTable1: TFDTable
    IndexFieldNames = 'EMP_NO'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'EMPLOYEE'
    TableName = 'EMPLOYEE'
    Left = 384
    Top = 112
  end
  object DataSource1: TDataSource
    DataSet = FDTable1
    Left = 384
    Top = 168
  end
  object FDMoniRemoteClientLink1: TFDMoniRemoteClientLink
    Tracing = True
    Left = 248
    Top = 168
  end
end
