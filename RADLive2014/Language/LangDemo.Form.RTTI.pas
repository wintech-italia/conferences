unit LangDemo.Form.RTTI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Rtti, Vcl.StdCtrls;

type
  AliasAttribute = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(AName: string);
    property Name: string read FName write FName;
  end;

  MaxInstancesAttribute = class(TCustomAttribute)
  private
    FMaxInstances: Integer;
  public
    constructor Create(AMaxInstances: Integer);
    property MaxInstances: Integer read FMaxInstances write FMaxInstances;
  end;

  [Alias('MyForm')]
  [MaxInstances(10)]
  TfrmRTTI = class(TForm)
    btnAttributes: TButton;
    mmoLog: TMemo;

    procedure btnAttributesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRTTI: TfrmRTTI;

implementation

{$R *.dfm}

{ AliasAttribute }

constructor AliasAttribute.Create(AName: string);
begin
  FName := AName;
end;

{ MaxInstancesAttribute }

constructor MaxInstancesAttribute.Create(AMaxInstances: Integer);
begin
  FMaxInstances := AMaxInstances;
end;

{ TfrmRTTI }

procedure TfrmRTTI.btnAttributesClick(Sender: TObject);
var
 LContext: TRttiContext;
 LType: TRttiType;
 LAttribute: TCustomAttribute;
begin
  LContext := TRttiContext.Create;

  LType := LContext.GetType(TfrmRTTI);
  for LAttribute in  LType.GetAttributes do
  begin
   if LAttribute is AliasAttribute then
     mmoLog.Lines.Add('Class Alias: ' + (LAttribute as AliasAttribute).Name)
   else
   if LAttribute is MaxInstancesAttribute then
     mmoLog.Lines.Add('Class Max Instances: ' + (LAttribute as MaxInstancesAttribute).MaxInstances.ToString);
  end;
end;

end.
