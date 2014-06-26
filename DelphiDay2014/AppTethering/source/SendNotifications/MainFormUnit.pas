unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, REST.OpenSSL,
  REST.Backend.PushTypes, REST.Backend.MetaTypes, System.JSON,
  REST.Backend.KinveyServices, Vcl.StdCtrls, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Backend.BindSource,
  REST.Backend.ServiceComponents, REST.Backend.KinveyProvider;

type
  TForm1 = class(TForm)
    KinveyProvider1: TKinveyProvider;
    BackendPush1: TBackendPush;
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
BackendPush1.Message := Edit1.Text;
BackendPush1.Push;
end;

end.
