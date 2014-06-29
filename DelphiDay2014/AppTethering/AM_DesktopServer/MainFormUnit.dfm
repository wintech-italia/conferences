object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'AppTethering - Desktop Server'
  ClientHeight = 289
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  DesignSize = (
    554
    289)
  PixelsPerInch = 96
  TextHeight = 13
  object LogMemo: TMemo
    Left = 8
    Top = 16
    Width = 538
    Height = 265
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object TetheringManager1: TTetheringManager
    OnPairedFromLocal = TetheringManager1PairedFromLocal
    Text = 'BarcodeScanner.Server'
    Left = 72
    Top = 56
  end
  object TetheringAppProfile1: TTetheringAppProfile
    Manager = TetheringManager1
    Text = 'TetheringAppProfile1'
    Group = 'BarcodeGroup'
    Actions = <>
    Resources = <
      item
        Name = 'Barcode'
        IsPublic = True
        Kind = Mirror
        OnResourceReceived = TetheringAppProfile1Resources0ResourceReceived
      end>
    OnAcceptResource = TetheringAppProfile1AcceptResource
    Left = 72
    Top = 120
  end
end
