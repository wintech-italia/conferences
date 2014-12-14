unit LangDemo.Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ImgList,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls;

type
  TfrmMain = class(TForm)
    actlstMain: TActionList;
    actHelpers: TAction;
    actGenerics: TAction;
    actAnonymous: TAction;
    actDynArrays: TAction;
    actRTTI: TAction;
    actRecords: TAction;
    btnHelpers: TButton;
    btnAnonymous: TButton;
    btnRTTI: TButton;
    btnDynArrays: TButton;
    btnRecords: TButton;
    btnGenerics: TButton;
    actAbout: TAction;
    btnAbout: TButton;
    imgAbout: TImage;
    statMain: TStatusBar;
    procedure actAboutExecute(Sender: TObject);
    procedure actAnonymousExecute(Sender: TObject);
    procedure actDynArraysExecute(Sender: TObject);
    procedure actGenericsExecute(Sender: TObject);
    procedure actHelpersExecute(Sender: TObject);
    procedure actRecordsExecute(Sender: TObject);
    procedure actRTTIExecute(Sender: TObject);
    procedure imgAboutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Winapi.ShellAPI
  , LangDemo.Module.Main
  , LangDemo.Form.About
  , LangDemo.Form.Helpers
  , LangDemo.Form.Generics
  , LangDemo.Form.AnonMethods
  , LangDemo.Form.RTTI
  , LangDemo.Form.DynArrays
  , LangDemo.Form.Records
  ;

{$R *.dfm}

procedure TfrmMain.actAboutExecute(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.actAnonymousExecute(Sender: TObject);
begin
  frmAnonMethods.ShowModal;
end;

procedure TfrmMain.actDynArraysExecute(Sender: TObject);
begin
  frmDynArrays.ShowModal;
end;

procedure TfrmMain.actGenericsExecute(Sender: TObject);
begin
  frmGenerics.ShowModal;
end;

procedure TfrmMain.actHelpersExecute(Sender: TObject);
begin
  frmHelpers.ShowModal;
end;

procedure TfrmMain.actRecordsExecute(Sender: TObject);
begin
  frmRecords.ShowModal;
end;

procedure TfrmMain.actRTTIExecute(Sender: TObject);
begin
  frmRTTI.ShowModal;
end;

procedure TfrmMain.imgAboutClick(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar(URL_WINTECH), '', '', SW_SHOWNORMAL);
end;

end.
