object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 212
  Width = 523
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=SQLite_Demo')
    LoginPrompt = False
    Left = 224
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 80
    Top = 56
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 208
    Top = 96
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
    Top = 136
  end
end
