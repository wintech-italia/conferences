unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects
  , Box2D.Common
  , Box2D.Collision
  , Box2D.Dynamics, FMX.Layouts
;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    TestButton: TButton;
    Rectangle1: TRectangle;
    Timer1: TTimer;
    Playground: TLayout;
    Rectangle2: TRectangle;
    Line2: TLine;
    Label1: TLabel;
    Label2: TLabel;
    procedure TestButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  gravity: b2Vec2;
  world: b2WorldWrapper;
  groundBodyDef: b2BodyDef;
  groundBody: b2BodyWrapper;
  groundBox: b2PolygonShapeWrapper;
  bodyDef: b2BodyDef;
  body: b2BodyWrapper;
  dynamicBox: b2PolygonShapeWrapper;
  fixtureDef: b2FixtureDef;
  timeStep: Double;
  velocityIterations: Integer;
  positionIterations: Integer;
  i: integer;
  pos: Pb2Vec2;
  angle: Double;

  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses Math;

procedure TForm1.TestButtonClick(Sender: TObject);
var
  f: b2Vec2;
begin
  // Define the gravity vector
  gravity := b2Vec2.Create(0.0, -9.81);

  // Construct a world object, which will hold and simulate the rigid bodies
  world := b2WorldWrapper.Create(gravity);
  try
    // Define the ground body
    groundBodyDef := b2BodyDef.Create();
    groundBodyDef.position.&Set(0.0, -10.0);
    // Call the body factory which allocates memory for the ground body
    groundBody := world.CreateBody(@groundBodyDef);
    // Define the ground box shape
    groundBox := b2PolygonShapeWrapper.Create();
    // The extents are the half-widths of the box
    groundBox.SetAsBox(50.0, 10.0);
    // Add the ground fixture to the ground body
    groundBody.CreateFixture(groundBox, 0.0);

    // Define another box shape for our dynamic body
    bodyDef := b2BodyDef.Create();
    bodyDef.&type := b2_DynamicBody;
    bodyDef.position.&Set(0.0, 4.0);
    body := world.CreateBody(@bodyDef);
    dynamicBox := b2PolygonShapeWrapper.Create();
    dynamicBox.SetAsBox(1.0, 1.0);
    fixtureDef := b2FixtureDef.Create();
    fixtureDef.shape := dynamicBox;
    fixtureDef.density := 1;
    fixtureDef.friction := 0.3;
    fixtureDef.restitution := 0.5;
    // Add the shape to the body
    body.CreateFixture(@fixtureDef);

    // Cleanup Shape Wrappers
    dynamicBox.Destroy;
    groundBox.Destroy;

    // Prepare for simulation. Typically we use a time step of 1/60 of a second (60Hz)
    timeStep := 1/60;
    velocityIterations := 6;
    positionIterations := 2;

    Timer1.Enabled := True;
    body.ApplyLinearImpulse(b2vec2.Create(10,20), body.GetWorldCenter^, true);

  finally
//    world.Destroy;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  TestButtonClick(TestButton);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  SCALING_F = 100;
var
  f: b2Vec2;
  velocity: Pb2Vec2;
begin
  world.Step(timeStep, velocityIterations, positionIterations);

  pos := body.GetPosition;
  angle := body.GetAngle;
  velocity := body.GetLinearVelocity;

  label1.Text :=
       'M:' + body.GetMass.ToString(TFloatFormat.ffFixed, 15, 4)
    + ' I:' + body.GetInertia.ToString(TFloatFormat.ffFixed, 15, 4);


//  f := body.GetWorldVector(b2Vec2.Create(0, 4*9.81*1.1));
//  body.ApplyForceToCenter(f, true);

  Rectangle1.Position.X := pos^.x * SCALING_F;
  Rectangle1.Position.Y := Playground.Height-pos^.y * SCALING_F;
  Rectangle1.RotationAngle := angle;


//  Label2.Text := Format('%.2f, %.2f', [pos^.x, pos^.y]);
  Label2.Text := Format('%.2f, %.2f', [body.GetWorldCenter.x, body.GetWorldCenter.y]);

  Line2.Width := velocity.Length * 10;
  Line2.RotationAngle := RadToDeg(ArcTan(-velocity.y / velocity.x));
end;

end.
