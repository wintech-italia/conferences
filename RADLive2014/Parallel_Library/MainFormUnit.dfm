object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Parallel Library'
  ClientHeight = 540
  ClientWidth = 665
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
  object FlowPanel1: TFlowPanel
    Left = 0
    Top = 73
    Width = 665
    Height = 448
    Align = alClient
    BevelOuter = bvNone
    Caption = 'FlowPanel1'
    TabOrder = 0
    ExplicitLeft = 72
    ExplicitTop = 120
    ExplicitWidth = 185
    ExplicitHeight = 41
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 665
    Height = 73
    Align = alTop
    TabOrder = 1
    DesignSize = (
      665
      73)
    object leFolder: TLabeledEdit
      Left = 72
      Top = 11
      Width = 361
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Folder'
      LabelPosition = lpLeft
      TabOrder = 0
      Text = 'Z:\Social'
    end
    object leFilter: TLabeledEdit
      Left = 482
      Top = 11
      Width = 89
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = 'Filter:'
      LabelPosition = lpLeft
      TabOrder = 1
      Text = '*.jpg'
    end
    object Button1: TButton
      Left = 144
      Top = 38
      Width = 91
      Height = 25
      Action = SingleThreadAction
      TabOrder = 2
    end
    object Button2: TButton
      Left = 241
      Top = 38
      Width = 89
      Height = 25
      Action = ParallelForAction
      TabOrder = 3
    end
    object Button3: TButton
      Left = 336
      Top = 38
      Width = 89
      Height = 25
      Action = TasksAction
      TabOrder = 4
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 521
    Width = 665
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitLeft = 344
    ExplicitTop = 280
    ExplicitWidth = 0
  end
  object ActionList1: TActionList
    Left = 488
    Top = 64
    object SingleThreadAction: TAction
      Caption = 'Single Thread'
      OnExecute = SingleThreadActionExecute
    end
    object ParallelForAction: TAction
      Caption = 'Parallel For'
      OnExecute = ParallelForActionExecute
    end
    object TasksAction: TAction
      Caption = 'Tasks'
      OnExecute = TasksActionExecute
    end
  end
end
