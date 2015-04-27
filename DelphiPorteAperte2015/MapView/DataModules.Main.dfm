object MainData: TMainData
  OldCreateOrder = False
  Height = 456
  Width = 554
  object PartecipantiDataSet: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 80
    Top = 40
    object PartecipantiDataSetCitta: TStringField
      FieldName = 'Citta'
      Size = 100
    end
    object PartecipantiDataSetQuantita: TIntegerField
      FieldName = 'Quantita'
    end
  end
end
