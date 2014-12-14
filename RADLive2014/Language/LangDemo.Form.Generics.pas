unit LangDemo.Form.Generics;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Types, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Contnrs,
  System.Generics.Collections, Vcl.StdCtrls;

type
  TMyObject = class(TObject)
  private
    FName: string;
  public
    constructor Create(AName: string);
    property Name: string read FName write FName;
  end;

  TMyObjectList = class(TObjectList)
  protected
    function GetItem(Index: Integer): TMyObject;
    procedure SetItem(Index: Integer; AObject: TMyObject);
  public
    function Add(AObject: TMyObject): Integer;
    function IndexOf(AObject: TMyObject): Integer;
    procedure Insert(Index: Integer; AObject: TMyObject);
    function Remove(AObject: TMyObject): Integer;
    property Items[Index: Integer]: TMyObject read GetItem write SetItem; default;
  end;

  TMyObjectGenericList = class(TObjectList<TMyObject>)
    // My custom methods
  end;

  TfrmGenerics = class(TForm)
    btnObjectList: TButton;
    btnGenericList: TButton;
    btnDerivedGeneric: TButton;
    btnDerivedList: TButton;
    procedure btnGenericListClick(Sender: TObject);
    procedure btnObjectListClick(Sender: TObject);
    procedure btnDerivedGenericClick(Sender: TObject);
    procedure btnDerivedListClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGenerics: TfrmGenerics;

implementation

{$R *.dfm}

{ TMyObjectList }

function TMyObjectList.Add(AObject: TMyObject): Integer;
begin
  Result := inherited Add(AObject);
end;

function TMyObjectList.GetItem(Index: Integer): TMyObject;
begin
  Result := TMyObject(inherited Items[Index]);
end;

function TMyObjectList.IndexOf(AObject: TMyObject): Integer;
begin
  Result := inherited IndexOf(AObject);
end;

procedure TMyObjectList.Insert(Index: Integer; AObject: TMyObject);
begin
  inherited Insert(Index, AObject);
end;

function TMyObjectList.Remove(AObject: TMyObject): Integer;
begin
  Result := inherited Remove(AObject);
end;

procedure TMyObjectList.SetItem(Index: Integer; AObject: TMyObject);
begin
  inherited Items[Index] := AObject;
end;

procedure TfrmGenerics.btnGenericListClick(Sender: TObject);
var
  LList: TObjectList<TMyObject>;
begin
  LList := TObjectList<TMyObject>.Create;
  try
    LList.Add(TMyObject.Create('Paolo'));
    LList.Add(TMyObject.Create('Andrea'));

    // Do something
  finally
    LList.Free;
  end;
end;

procedure TfrmGenerics.btnObjectListClick(Sender: TObject);
var
  LList: TObjectList;
begin
  LList := TObjectList.Create;
  try
    LList.Add(TMyObject.Create('Paolo'));
    LList.Add(TMyObject.Create('Andrea'));
    LList.Add(Self);

    // Do something
    //LList[0].Name := 'Pippo';
  finally
    LList.Free;
  end;
end;

procedure TfrmGenerics.btnDerivedGenericClick(Sender: TObject);
var
  LList: TMyObjectGenericList;
begin
  LList := TMyObjectGenericList.Create;
  try
    LList.Add(TMyObject.Create('Paolo'));
    LList.Add(TMyObject.Create('Andrea'));

    // Do something
  finally
    LList.Free;
  end;

end;

procedure TfrmGenerics.btnDerivedListClick(Sender: TObject);
var
  LList: TMyObjectList;
begin
  LList := TMyObjectList.Create;
  try
    LList.Add(TMyObject.Create('Paolo'));
    LList.Add(TMyObject.Create('Andrea'));

    // Do something
  finally
    LList.Free;
  end;
end;

{ TMyObject }

constructor TMyObject.Create(AName: string);
begin
  FName := AName;
end;

end.
