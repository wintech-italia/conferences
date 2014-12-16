unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    Print1: TMenuItem;
    PrintSetup1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    Repeat1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    PasteSpecial1: TMenuItem;
    Find1: TMenuItem;
    Replace1: TMenuItem;
    GoTo1: TMenuItem;
    Links1: TMenuItem;
    Object1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    Button1: TButton;
    Edit2: TEdit;
    LabeledEdit1: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    CheckBox1: TCheckBox;
    ListBox1: TListBox;
    TrackBar1: TTrackBar;
    ProgressBar1: TProgressBar;
    StiliPopup: TPopupMenu;
    procedure StiliPopupPopup(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
    procedure StiliMenuItemClick(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  VCL.Themes;

procedure TForm1.StiliMenuItemClick(Sender: TObject);
begin
  TStyleManager.TrySetStyle((Sender as TMenuItem).Caption);
end;

procedure TForm1.StiliPopupPopup(Sender: TObject);
var
  LStyleName: string;
  LItem: TMenuItem;
begin
  StiliPopup.Items.Clear;

  for LStyleName in TStyleManager.StyleNames do
  begin
    LItem := TMenuItem.Create(StiliPopup);
    LItem.Caption := LStyleName;
    LItem.OnClick := StiliMenuItemClick;
    StiliPopup.Items.Add(LItem);
  end;

end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  ProgressBar1.Position := TrackBar1.Position * 10;
end;

end.
