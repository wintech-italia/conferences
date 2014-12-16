unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Vcl.StdCtrls, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, FireDAC.Phys.IBBase,
  FireDAC.Comp.UI;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    FDQuery1: TFDQuery;
    btnReopen: TButton;
    FDQuery1Calcolato: TIntegerField;
    procedure btnReopenClick(Sender: TObject);
    procedure FDQuery1CalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnReopenClick(Sender: TObject);
begin
  FDQuery1.Close;
  FDQuery1.Open;
end;

procedure TForm1.FDQuery1CalcFields(DataSet: TDataSet);
begin
  FDQuery1Calcolato.AsInteger := Random(100);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
end;

end.
