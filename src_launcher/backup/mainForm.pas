unit mainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Process, Forms, Controls, Graphics,
  Dialogs, ComCtrls, DAPlatform;

type

  { TFormMain }

  TFormMain = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
var
  launchPath,s: string;
begin
     launchPath:= TDAPlatform.GetApplicationFolder('content\helpexplorer.exe');
     RunCommand(launchPath,s);
     Application.Terminate;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
end;


procedure TFormMain.FormShow(Sender: TObject);
begin

end;


end.

