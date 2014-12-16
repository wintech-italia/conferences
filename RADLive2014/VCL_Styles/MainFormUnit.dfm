object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'VCL Styles'
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
  PopupMenu = StiliPopup
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 270
    Width = 554
    Height = 19
    Panels = <
      item
        Text = 'Status'
        Width = 50
      end
      item
        Text = 'Text'
        Width = 50
      end
      item
        Text = 'Example'
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 29
    Width = 554
    Height = 241
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object Button1: TButton
        Left = 16
        Top = 32
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 0
      end
      object TrackBar1: TTrackBar
        Left = 16
        Top = 80
        Width = 150
        Height = 45
        Position = 3
        TabOrder = 1
        OnChange = TrackBar1Change
      end
      object ProgressBar1: TProgressBar
        Left = 16
        Top = 144
        Width = 150
        Height = 17
        Position = 30
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object SpeedButton1: TSpeedButton
        Left = 144
        Top = 16
        Width = 23
        Height = 22
        Caption = '...'
      end
      object Edit2: TEdit
        Left = 16
        Top = 16
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'Edit2'
      end
      object LabeledEdit1: TLabeledEdit
        Left = 16
        Top = 72
        Width = 121
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'LabeledEdit1'
        TabOrder = 1
      end
      object CheckBox1: TCheckBox
        Left = 16
        Top = 120
        Width = 97
        Height = 17
        Caption = 'CheckBox1'
        TabOrder = 2
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
      object ListBox1: TListBox
        Left = 16
        Top = 24
        Width = 145
        Height = 169
        ItemHeight = 13
        Items.Strings = (
          'Primo'
          'Secondo'
          'Terzo'
          'Quarto e quinto insieme'
          'Sesto')
        TabOrder = 0
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 554
    Height = 29
    ButtonHeight = 21
    ButtonWidth = 72
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 2
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Caption = 'Cu&t'
      MenuItem = Cut1
    end
    object ToolButton2: TToolButton
      Left = 72
      Top = 0
      Caption = '&Copy'
      MenuItem = Copy1
    end
    object ToolButton3: TToolButton
      Left = 144
      Top = 0
      Caption = '&Paste'
      MenuItem = Paste1
    end
    object ToolButton4: TToolButton
      Left = 216
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 224
      Top = 0
      Caption = '&Print...'
      MenuItem = Print1
    end
    object ToolButton6: TToolButton
      Left = 296
      Top = 0
      Caption = 'P&rint Setup...'
      MenuItem = PrintSetup1
    end
  end
  object MainMenu1: TMainMenu
    Left = 272
    Top = 152
    object File1: TMenuItem
      Caption = '&File'
      object New1: TMenuItem
        Caption = '&New'
      end
      object Open1: TMenuItem
        Caption = '&Open...'
      end
      object Save1: TMenuItem
        Caption = '&Save'
      end
      object SaveAs1: TMenuItem
        Caption = 'Save &As...'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Print1: TMenuItem
        Caption = '&Print...'
      end
      object PrintSetup1: TMenuItem
        Caption = 'P&rint Setup...'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object Undo1: TMenuItem
        Caption = '&Undo'
        ShortCut = 16474
      end
      object Repeat1: TMenuItem
        Caption = '&Repeat <command>'
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Cut1: TMenuItem
        Caption = 'Cu&t'
        ShortCut = 16472
      end
      object Copy1: TMenuItem
        Caption = '&Copy'
        ShortCut = 16451
      end
      object Paste1: TMenuItem
        Caption = '&Paste'
        ShortCut = 16470
      end
      object PasteSpecial1: TMenuItem
        Caption = 'Paste &Special...'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Find1: TMenuItem
        Caption = '&Find...'
      end
      object Replace1: TMenuItem
        Caption = 'R&eplace...'
      end
      object GoTo1: TMenuItem
        Caption = '&Go To...'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Links1: TMenuItem
        Caption = 'Lin&ks...'
      end
      object Object1: TMenuItem
        Caption = '&Object'
      end
    end
  end
  object StiliPopup: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = StiliPopupPopup
    Left = 396
    Top = 109
  end
end
