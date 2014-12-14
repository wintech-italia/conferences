unit LangDemo.Form.Records;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  Nullable<T> = record
  private
    FValue: T;
    FHasValue: string;
    procedure Clear;
    function GetValue: T;
    function GetHasValue: Boolean;
  public
    constructor Create(const Value: T); overload;
    constructor Create(const Value: Variant); overload;
    function Equals(const Value: Nullable<T>): Boolean;
    function GetValueOrDefault: T; overload;
    function GetValueOrDefault(const Default: T): T; overload;

    property HasValue: Boolean read GetHasValue;
    property Value: T read GetValue;

    class operator Implicit(const Value: Nullable<T>): T;
    class operator Implicit(const Value: Nullable<T>): Variant;
    class operator Implicit(const Value: Pointer): Nullable<T>;
    class operator Implicit(const Value: T): Nullable<T>;
    class operator Implicit(const Value: Variant): Nullable<T>;
    class operator Equal(const Left, Right: Nullable<T>): Boolean;
    class operator NotEqual(const Left, Right: Nullable<T>): Boolean;
  end;

type
  TfrmRecords = class(TForm)
    btnNullable: TButton;
    mmoLog: TMemo;
    procedure btnNullableClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRecords: TfrmRecords;

implementation

uses
  System.Generics.Defaults
  , System.Generics.Collections
  , System.Rtti
  ;

{ Nullable<T> }

constructor Nullable<T>.Create(const Value: T);
var
  LValue: TValue;
begin
  FValue := Value;
  FHasValue := DefaultTrueBoolStr;
end;

constructor Nullable<T>.Create(const Value: Variant);
begin
  if not VarIsNull(Value) and not VarIsEmpty(Value) then
    Create(TValue.FromVariant(Value).AsType<T>)
  else
    Clear;
end;

procedure Nullable<T>.Clear;
begin
  FValue := Default(T);
  FHasValue := '';
end;

function Nullable<T>.Equals(const Value: Nullable<T>): Boolean;
begin
  if HasValue and Value.HasValue then
    Result := TEqualityComparer<T>.Default.Equals(Self.Value, Value.Value)
  else
    Result := HasValue = Value.HasValue;
end;

function Nullable<T>.GetHasValue: Boolean;
begin
  Result := FHasValue <> '';
end;

function Nullable<T>.GetValue: T;
begin
  if not HasValue then
    raise Exception.Create('Nullable type has no value');
  Result := FValue;
end;

function Nullable<T>.GetValueOrDefault(const Default: T): T;
begin
  if HasValue then
    Result := FValue
  else
    Result := Default;
end;

function Nullable<T>.GetValueOrDefault: T;
begin
  Result := GetValueOrDefault(Default(T));
end;

class operator Nullable<T>.Implicit(const Value: Nullable<T>): T;
begin
  Result := Value.Value;
end;

class operator Nullable<T>.Implicit(const Value: Nullable<T>): Variant;
begin
  if Value.HasValue then
    Result := TValue.From<T>(Value.Value).AsVariant
  else
    Result := Null;
end;

class operator Nullable<T>.Implicit(const Value: Pointer): Nullable<T>;
begin
  if Value = nil then
    Result.Clear
  else
    Result := Nullable<T>.Create(T(Value^));
end;

class operator Nullable<T>.Implicit(const Value: T): Nullable<T>;
begin
  Result := Nullable<T>.Create(Value);
end;

class operator Nullable<T>.Implicit(const Value: Variant): Nullable<T>;
begin
  Result := Nullable<T>.Create(Value);
end;

class operator Nullable<T>.Equal(const Left, Right: Nullable<T>): Boolean;
begin
  Result := Left.Equals(Right);
end;

class operator Nullable<T>.NotEqual(const Left, Right: Nullable<T>): Boolean;
begin
  Result := not Left.Equals(Right);
end;

{$R *.dfm}

procedure TfrmRecords.btnNullableClick(Sender: TObject);
var
  LInt: Nullable<Integer>;
begin
  mmoLog.Lines.Add(Format('After declaration: %s', [BoolToStr(LInt.HasValue, True)]));

  LInt := Nullable<Integer>.Create(null);
  mmoLog.Lines.Add(Format('After creation: %s', [BoolToStr(LInt.HasValue, True)]));

  LInt := 10;
  mmoLog.Lines.Add(Format('After assignement (10): %s', [BoolToStr(LInt.HasValue, True)]));

  LInt := nil;
  mmoLog.Lines.Add(Format('After assignement (null): %s', [BoolToStr(LInt.HasValue, True)]));
end;

end.
