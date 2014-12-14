object frmClient: TfrmClient
  Left = 0
  Top = 0
  Caption = 'REST Client'
  ClientHeight = 299
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
  object btnEmployee: TButton
    Left = 25
    Top = 67
    Width = 113
    Height = 33
    Caption = 'Employee Name'
    TabOrder = 0
    OnClick = btnEmployeeClick
  end
  object edtID: TEdit
    Left = 25
    Top = 40
    Width = 113
    Height = 21
    NumbersOnly = True
    TabOrder = 1
    Text = '1'
  end
  object mmoLog: TMemo
    Left = 233
    Top = 24
    Width = 394
    Height = 113
    Lines.Strings = (
      'mmoLog')
    TabOrder = 2
  end
  object btnStream: TButton
    Left = 25
    Top = 129
    Width = 113
    Height = 33
    Caption = 'Get Stream'
    TabOrder = 3
    OnClick = btnStreamClick
  end
  object DBGrid1: TDBGrid
    Left = 1089
    Top = 536
    Width = 394
    Height = 120
    DataSource = DataSource1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnStreamXML: TButton
    Left = 25
    Top = 168
    Width = 113
    Height = 33
    Caption = 'Get Stream XML'
    TabOrder = 5
    OnClick = btnStreamXMLClick
  end
  object btnDataSet: TButton
    Left = 25
    Top = 207
    Width = 113
    Height = 33
    Caption = 'Get DataSet'
    TabOrder = 6
    OnClick = btnDataSetClick
  end
  object DBGrid2: TDBGrid
    Left = 233
    Top = 160
    Width = 394
    Height = 120
    DataSource = DataSource1
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    AutoCommitUpdates = False
    Left = 168
    Top = 40
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 168
    Top = 88
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 408
    Top = 24
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 408
    Top = 80
  end
  object FDStanStorageXMLLink1: TFDStanStorageXMLLink
    Left = 408
    Top = 144
  end
end
