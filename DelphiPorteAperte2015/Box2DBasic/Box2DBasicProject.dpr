program Box2DBasicProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  Forms.Main in 'Forms.Main.pas' {Form1},
  Box2D.Collision in 'C:\Users\Public\Documents\Embarcadero\Studio\16.0\Samples\Object Pascal\Mobile Samples\Physics\Box2DHello\intermediate\Box2D.Collision.pas',
  Box2D.Common in 'C:\Users\Public\Documents\Embarcadero\Studio\16.0\Samples\Object Pascal\Mobile Samples\Physics\Box2DHello\intermediate\Box2D.Common.pas',
  Box2D.Dynamics in 'C:\Users\Public\Documents\Embarcadero\Studio\16.0\Samples\Object Pascal\Mobile Samples\Physics\Box2DHello\intermediate\Box2D.Dynamics.pas',
  Box2DTypes in 'C:\Users\Public\Documents\Embarcadero\Studio\16.0\Samples\Object Pascal\Mobile Samples\Physics\Box2DHello\intermediate\Box2DTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
