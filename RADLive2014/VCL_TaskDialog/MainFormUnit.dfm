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
  object Edit1: TEdit
    Left = 64
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 88
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object TaskDialog1: TTaskDialog
    Buttons = <
      item
        Caption = 'Prima opzione'
        Default = True
        CommandLinkHint = 'Hint prima opzione'
        ModalResult = 100
      end
      item
        Caption = 'Seconda opzione'
        CommandLinkHint = 'Hint per seconda opzione'
        ModalResult = 101
      end>
    Caption = 'Esempio Caption'
    ExpandedText = 
      'Descrizione estesa (con tanto di <a href="www.google.it">link</a' +
      '> da mostrare quando la dialog '#232' espansa...'
    Flags = [tfEnableHyperlinks, tfAllowDialogCancellation, tfUseCommandLinks, tfShowProgressBar, tfCallbackTimer]
    FooterIcon = 1
    FooterText = 'Testo del footer'
    RadioButtons = <
      item
        Caption = 'RadioButton1'
      end
      item
        Caption = 'RadioButton2'
      end
      item
        Caption = 'RadioButton3'
      end>
    Text = 'Descrizione del task'
    Title = 'Testo del titolo'
    VerificationText = 'Ricorda la mia scelta'
    OnHyperlinkClicked = TaskDialog1HyperlinkClicked
    OnTimer = TaskDialog1Timer
    Left = 312
    Top = 96
  end
end
