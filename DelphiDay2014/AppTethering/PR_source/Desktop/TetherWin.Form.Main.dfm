object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Desktop Tethering Application'
  ClientHeight = 442
  ClientWidth = 590
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblTime: TLabel
    Left = 64
    Top = 8
    Width = 60
    Height = 18
    Caption = 'hh:mm:ss'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'TechnicBold'
    Font.Style = []
    ParentFont = False
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 284
    Width = 590
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 8
    ExplicitTop = 416
    ExplicitWidth = 635
  end
  object btnSubscription: TButton
    Left = 16
    Top = 29
    Width = 153
    Height = 25
    Caption = 'Sync Server Time'
    TabOrder = 0
    OnClick = btnSubscriptionClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 287
    Width = 590
    Height = 155
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 368
    ExplicitWidth = 635
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 111
    Width = 590
    Height = 173
    Align = alBottom
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 334
    Top = 74
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 3
  end
  object Button1: TButton
    Left = 16
    Top = 74
    Width = 153
    Height = 25
    Action = actUpdateDB
    TabOrder = 4
  end
  object Button2: TButton
    Left = 175
    Top = 74
    Width = 153
    Height = 25
    Action = actCloseDB
    TabOrder = 5
  end
  object TetheringManagerDesktop: TTetheringManager
    OnPairedFromLocal = TetheringManagerDesktopPairedFromLocal
    OnPairedToRemote = TetheringManagerDesktopPairedToRemote
    Text = 'TetheringManagerDesktop'
    Left = 104
    Top = 88
  end
  object TetheringAppProfileDesktop: TTetheringAppProfile
    Manager = TetheringManagerDesktop
    Text = 'TetheringAppProfileDesktop'
    Group = 'BarcodeGroup'
    Actions = <
      item
        Name = 'actUpdateDB'
        IsPublic = True
        Action = actUpdateDB
        NotifyUpdates = False
      end>
    Resources = <>
    OnAcceptResource = TetheringAppProfileDesktopAcceptResource
    OnResourceReceived = TetheringAppProfileDesktopResourceReceived
    OnResourceUpdated = TetheringAppProfileDesktopResourceUpdated
    Left = 104
    Top = 152
  end
  object ActionList1: TActionList
    Left = 408
    Top = 16
    object actUpdateDB: TAction
      Caption = 'Open DataBase'
      OnExecute = actUpdateDBExecute
    end
    object actCloseDB: TAction
      Caption = 'Close DataBase'
      OnExecute = actCloseDBExecute
    end
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 368
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 240
    Top = 96
  end
end
