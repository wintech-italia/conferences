object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'RemoteKeyboard'
  ClientHeight = 409
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  DesignSize = (
    612
    409)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 130
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 16
    Top = 8
    Width = 571
    Height = 23
    Caption = 
      'Questa applicazione simula la pressione di tasti SINISTRA e DEST' +
      'RA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 43
    Top = 48
    Width = 544
    Height = 23
    Caption = 
      'L'#39'esecuzione '#232' pilotata dall'#39'applicazione mobile via App Tetheri' +
      'ng'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 16
    Top = 149
    Width = 80
    Height = 13
    Caption = 'Log dei comandi:'
  end
  object Label5: TLabel
    Left = 80
    Top = 88
    Width = 447
    Height = 23
    Caption = '(i tasti vengono inviati all'#39'applicazione in primo piano)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 16
    Top = 168
    Width = 385
    Height = 225
    Anchors = [akLeft, akTop, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object TetheringManager1: TTetheringManager
    Text = 'RemoteKeyboard'
    Left = 296
    Top = 248
  end
  object TetheringAppProfile1: TTetheringAppProfile
    Manager = TetheringManager1
    Text = 'TetheringAppProfile1'
    Group = 'DelphiDay'
    Actions = <
      item
        Name = 'actnRotateCW'
        IsPublic = True
        Action = actnRotateCW
        NotifyUpdates = False
      end
      item
        Name = 'actnRotateCCW'
        IsPublic = True
        Action = actnRotateCCW
        NotifyUpdates = False
      end>
    Resources = <>
    Left = 296
    Top = 304
  end
  object ActionList1: TActionList
    Left = 200
    Top = 248
    object actnRotateCW: TAction
      Caption = 'Left'
      OnExecute = actnRotateCWExecute
    end
    object actnRotateCCW: TAction
      Caption = 'Right'
      OnExecute = actnRotateCCWExecute
    end
  end
end
