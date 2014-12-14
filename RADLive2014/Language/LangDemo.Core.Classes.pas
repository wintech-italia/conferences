unit LangDemo.Core.Classes;

interface

type
  TStaticClass = class
    class var X: integer;
    class constructor Create;
    class destructor Destroy;
    class procedure Foo;
  end;

implementation

uses
  System.SysUtils;

{ TStaticClass }

class constructor TStaticClass.Create;
begin
  writeln('Inside Class Constructor');
  x := 42;
end;

class destructor TStaticClass.Destroy;
begin
  writeln('Inside Class Destructor');
  readln;
end;

class procedure TStaticClass.Foo;
begin
  writeln('Inside Foo and x is ' + x.ToString);
end;

initialization
  writeln('Inside Initialization');

finalization
  writeln('Inside Finalization');

end.
