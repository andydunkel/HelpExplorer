unit mainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, activexcontainer, Forms, Controls, Graphics,
  Dialogs, ComCtrls, SHDocVw_1_1_TLB, settings, MSHTML_4_0_TLB, DAPlatform,
  globalfunctions;

type

  { TFormMain }

  TFormMain = class(TForm)
    ActiveXContainer1: TActiveXContainer;
    ImageListToolbar: TImageList;
    ToolBar: TToolBar;
    ButtonBack: TToolButton;
    ButtonForward: TToolButton;
    ButtonHome: TToolButton;
    ButtonExit: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure ButtonBackClick(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure ButtonForwardClick(Sender: TObject);
    procedure ButtonHomeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
    Browser: Webbrowser;
    Settings: TSettings;
    onull: OleVariant;

    function GetHomepage: String;
  public
    { public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Settings:= TSettings.Create;
  Settings.LoadSettings;

  //Set settings from INI file
  Self.Caption:= Settings.Title;
  Self.Width:= Settings.WindowWidth;
  Self.Height:= Settings.WindowHeight;

  if (Settings.WindowCenter) then
  begin
    Self.Position:= poScreenCenter;
  end else
  begin
    Self.Left:= Settings.WindowLeft;
    Self.Top:= Settings.WindowTop;
  end;

  if (not Settings.ShowToolbar) then
  begin
    ActiveXContainer1.Top:= 1;
    ToolBar.Visible:= false;
  end;

  if (Settings.StartMaximized) then
  begin
    Self.WindowState:=wsMaximized;
  end;

  //Load Browser
  onull:= NULL;
  Browser:= CoWebBrowser.Create;
  Browser.Silent:= true;
  ActiveXContainer1.ComServer:= Browser;
  ActiveXContainer1.Active:= true;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Settings);
end;

procedure TFormMain.ButtonExitClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormMain.ButtonForwardClick(Sender: TObject);
begin
  try
    Browser.GoForward;
  except
  end;
end;

procedure TFormMain.ButtonHomeClick(Sender: TObject);
var
  s: String;
begin
  s:= GetHomepage();
  Browser.Navigate(s, onull, onull, onull, onull);
end;

procedure TFormMain.ButtonBackClick(Sender: TObject);
begin
  try
    Browser.GoBack;
  except
  end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  Sleep(500);
  ButtonHomeClick(nil);
end;

function TFormMain.GetHomepage: String;
var
  s: String;
begin
  if (Pos('http://', Settings.Homepage) = 0) and (Pos('https://', Settings.Homepage) = 0) then
  begin
    s:= TDAPlatform.GetApplicationFolder('content\' + Settings.Homepage);
  end else
  begin
    s:= Settings.Homepage;
  end;

  Result:= s;
end;


end.

