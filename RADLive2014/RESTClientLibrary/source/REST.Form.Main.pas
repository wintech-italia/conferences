unit REST.Form.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.Memo, FMX.TabControl, System.Rtti,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.Grid, FMX.ListView.Types, FMX.ListView, Data.DB;

type
  TfrmMain = class(TForm)
    btnHelloWorld: TButton;
    btnUser: TButton;
    btnCustom: TButton;
    ctrlResponse: TTabControl;
    tabHeaders: TTabItem;
    tabContent: TTabItem;
    mmoContent: TMemo;
    mmoHeaders: TMemo;
    StatusBar1: TStatusBar;
    tabGrid: TTabItem;
    gridResponse: TStringGrid;
    Edit1: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    pnlButtons: TPanel;
    pnlList: TPanel;
    listHyperMedia: TListView;
    Label1: TLabel;
    pnlParams: TPanel;
    Label2: TLabel;
    lblHyperMedia: TLabel;
    listParams: TListView;
    pnlLeft: TPanel;
    btnNavigate: TButton;
    btnAuthForm: TButton;
    procedure btnHelloWorldClick(Sender: TObject);
    procedure btnUserClick(Sender: TObject);
    procedure btnCustomClick(Sender: TObject);
    procedure listHyperMediaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure gridResponseDblClick(Sender: TObject);
    procedure listHyperMediaDblClick(Sender: TObject);
    procedure btnNavigateClick(Sender: TObject);
    procedure btnAuthFormClick(Sender: TObject);
  private
    procedure ParseHyperMedia(ADataSet: TDataSet);
    procedure AuthRedirect(const AURL: string; var DoCloseWebView: Boolean);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  System.JSON, REST.Json, REST.Client, REST.Authenticator.OAuth.WebForm.Win,
  REST.Data.Main;

{$R *.fmx}

procedure TfrmMain.AuthRedirect(const AURL: string; var DoCloseWebView: Boolean);
begin
  ShowMessage(AURL);
  //dmMain.OAuth2Authenticator1.Authenticate();
end;

procedure TfrmMain.btnAuthFormClick(Sender: TObject);
var
  LForm: Tfrm_OAuthWebForm;
begin
  LForm := Tfrm_OAuthWebForm.Create(nil);
  try
    LForm.OnAfterRedirect := AuthRedirect;
    LForm.ShowModalWithURL(dmMain.OAuth2Authenticator1.AuthorizationRequestURI);
  finally
    LForm.Free;
  end;
end;

procedure TfrmMain.btnCustomClick(Sender: TObject);
begin
  mmoContent.Lines.Text := dmMain.DoRequestCustom(Edit1.Text);
  mmoHeaders.Lines.Text := dmMain.RESTResponseGitHub.Headers.Text;
  dmMain.dsResponse.Open;
end;

procedure TfrmMain.btnHelloWorldClick(Sender: TObject);
begin
  ShowMessage(dmMain.DoRequestHello);
end;

procedure TfrmMain.btnNavigateClick(Sender: TObject);
var
  LItem: TListViewItem;
begin
  LItem := listHyperMedia.Selected;
  if Assigned(LItem) then
  begin
    mmoContent.Lines.Text := dmMain.DoNavigate;
    mmoHeaders.Lines.Text := dmMain.RESTResponseGitHub.Headers.Text;
    dmMain.dsResponse.Open;
  end;
end;

procedure TfrmMain.btnUserClick(Sender: TObject);
begin
  mmoContent.Lines.Text := dmMain.DoRequestUser('paolo-rossi');
  mmoHeaders.Lines.Text := dmMain.RESTResponseGitHub.Headers.Text;
  dmMain.dsResponse.Open;
end;

procedure TfrmMain.gridResponseDblClick(Sender: TObject);
begin
  ParseHyperMedia(dmMain.dsResponse);
end;

procedure TfrmMain.listHyperMediaDblClick(Sender: TObject);
begin
  Showmessage('button');
end;

procedure TfrmMain.listHyperMediaItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  LParams: TRESTRequestParameterList;
  LParam: TRESTRequestParameter;
  LItem: TListViewItem;
begin
  lblHyperMedia.Text := AItem.Detail;
  listParams.ClearItems;
  LParams := dmMain.ParseParams(AItem.Detail);
  if Assigned(LParams) then
  begin
    for LParam in LParams do
    begin
      LItem := listParams.Items.Add;
      LItem.Text := LParam.ToString;
    end;
  end;
end;

procedure TfrmMain.ParseHyperMedia(ADataSet: TDataSet);
var
  LIndex: Integer;
  LItem: TListViewItem;
begin
  listHyperMedia.ClearItems;
  for LIndex := 0 to ADataSet.Fields.Count - 1 do
  begin
    if Pos('_url', ADataSet.Fields[LIndex].FieldName) > 0 then
    begin
      LItem := listHyperMedia.Items.Add;

      LItem.ButtonText := '->';
      LItem.Text := ADataSet.Fields[LIndex].FieldName;
      LItem.Detail := ADataSet.Fields[LIndex].AsString;
    end;
  end;
  listHyperMedia.ItemIndex := -1;
end;

end.
