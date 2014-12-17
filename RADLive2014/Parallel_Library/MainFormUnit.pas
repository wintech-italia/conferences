unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls
  , Generics.Collections;

type
  TMainForm = class(TForm)
    FlowPanel1: TFlowPanel;
    TopPanel: TPanel;
    ActionList1: TActionList;
    SingleThreadAction: TAction;
    leFolder: TLabeledEdit;
    leFilter: TLabeledEdit;
    StatusBar1: TStatusBar;
    ParallelForAction: TAction;
    TasksAction: TAction;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure SingleThreadActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ParallelForActionExecute(Sender: TObject);
    procedure TasksActionExecute(Sender: TObject);
  private
    { Private declarations }
    FImages: TThreadList<TImage>;
    function GetCurrentPath: string;
    procedure SetCurrentPath(const Value: string);
    function GetCurrentFilter: string;
  public
    { Public declarations }
    property CurrentPath: string read GetCurrentPath write SetCurrentPath;
    property CurrentFilter: string read GetCurrentFilter;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.Types
  , IOUtils
  , JPEG
  , System.Threading
  , CodeSiteLogging;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Randomize;
end;

function TMainForm.GetCurrentFilter: string;
begin
  Result := leFilter.Text;
end;

function TMainForm.GetCurrentPath: string;
begin
  Result := leFolder.Text;
end;

procedure TMainForm.ParallelForActionExecute(Sender: TObject);
var
  LFileName: string;
  LAllFiles: TStringDynArray;
begin
  // cleanup
  while FlowPanel1.ControlCount > 0 do
    FlowPanel1.Controls[0].Free;

  CodeSite.EnterMethod('RUN');
  LAllFiles := TDirectory.GetFiles(CurrentPath, CurrentFilter);
  CodeSite.SendMsg('Loading images...');

  TParallel.For(0, Length(LAllFiles)-1,
    procedure (I: Int64)
    var
      LImage: TImage;
    begin
      LImage := TImage.Create(nil);
      try
        LImage.Stretch := True;
        LImage.Proportional := True;

        Sleep(1000);
        LImage.Picture.LoadFromFile(LAllFiles[I]);
        CodeSite.SendMsg('Loaded ' + LAllFiles[I]);

        TThread.Queue(nil,
        procedure
        begin
          LImage.Parent := FlowPanel1;
        end
        );
      except
        LImage.Free;
        raise;
      end;
    end
  );

  CodeSite.ExitMethod('RUN');
end;

procedure TMainForm.SingleThreadActionExecute(Sender: TObject);
var
  LFileName: string;
  LAllFiles: TStringDynArray;

  procedure AddImage(AFileName: string);
  var
    LImage: TImage;
  begin
    LImage := TImage.Create(nil);
    try
      LImage.Stretch := True;
      LImage.Proportional := True;

      Sleep(1000);
      LImage.Picture.LoadFromFile(AFileName);
      CodeSite.SendMsg('Loaded ' + AFileName);

      LImage.Parent := FlowPanel1;
    except
      LImage.Free;
      raise;
    end;
  end;

begin
  // cleanup
  while FlowPanel1.ControlCount > 0 do
    FlowPanel1.Controls[0].Free;

  CodeSite.EnterMethod('RUN');
  LAllFiles := TDirectory.GetFiles(CurrentPath, CurrentFilter);
  CodeSite.SendMsg('Loading images...');

    for LFileName in LAllFiles do
      AddImage(LFileName);

  CodeSite.ExitMethod('RUN');
end;

procedure TMainForm.TasksActionExecute(Sender: TObject);
var
  LFileName: string;
  LAllFiles: TStringDynArray;
  LTasks: TArray<ITask>;

  function AddImageTask(AFileName: string): ITask;
  begin
    Result := TTask.Create(
    procedure
    var
      LImage: TImage;
    begin
      LImage := TImage.Create(nil);
      try
        LImage.Stretch := True;
        LImage.Proportional := True;

        Sleep(1000);
        LImage.Picture.LoadFromFile(AFileName);
        CodeSite.SendMsg('Loaded ' + AFileName);

        TThread.Queue(nil,
        procedure
        begin
          LImage.Parent := FlowPanel1;
        end
        );
      except
        LImage.Free;
        raise;
      end;
    end).Start;
  end;

begin
  // cleanup
  while FlowPanel1.ControlCount > 0 do
    FlowPanel1.Controls[0].Free;

  CodeSite.EnterMethod('RUN');
  LAllFiles := TDirectory.GetFiles(CurrentPath, CurrentFilter);
  CodeSite.SendMsg('Loading images...');

  LTasks := [];
  for LFileName in LAllFiles do
    LTasks := LTasks + [AddImageTask(LFileName)];

  CodeSite.SendMsg('MainThread: finished for loop.');

//  CodeSite.SendMsg('MainThread: starts waiting all tasks to finish...');
//  TTask.WaitForAll(LTasks);
//  CodeSite.SendMsg('MainThread: all tasks finished!');

  CodeSite.ExitMethod('RUN');
end;

procedure TMainForm.SetCurrentPath(const Value: string);
begin
  leFolder.Text := Value;
end;

end.
