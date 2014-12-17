object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Andrea Notepad'
  ClientHeight = 289
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 554
    Height = 289
    Align = alClient
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object JumpList1: TJumpList
    AutoRefresh = True
    Enabled = True
    CustomCategories = <>
    ShowRecent = True
    TaskList = <>
    Left = 288
    Top = 168
  end
  object MainMenu1: TMainMenu
    Left = 296
    Top = 72
    object File1: TMenuItem
      Caption = 'File'
      object Apri1: TMenuItem
        Caption = 'Apri'
        OnClick = Apri1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Esci1: TMenuItem
        Caption = 'Esci'
        OnClick = Esci1Click
      end
    end
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 384
    Top = 64
  end
end
