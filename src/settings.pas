unit settings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8, IniFiles, DAPlatform;


type

{ TSettings }

 TSettings = class
  private
    IniFile: TIniFile;
    FShowToolBar: Boolean;
    FTitle: String;
    FHomepage: String;
    FWindowWidth: Integer;
    FWindowHeight: Integer;
    FWindowLeft: Integer;
    FWindowTop: Integer;
    FWindowCenter: Boolean;
    FStartMaximized: Boolean;

  public
    procedure LoadSettings;
    property ShowToolbar: Boolean read FShowToolBar write FShowToolBar;
    property WindowCenter: Boolean read FWindowCenter write FWindowCenter;
    property Title: String read FTitle write FTitle;
    property Homepage: String read FHomepage write FHomepage;
    property WindowWidth: Integer read FWindowWidth write FWindowWidth;
    property WindowHeight: Integer read FWindowHeight write FWindowHeight;
    property WindowLeft: Integer read FWindowLeft write FWindowLeft;
    property WindowTop: Integer read FWindowTop write FWindowTop;
    property StartMaximized: Boolean read FStartMaximized write FStartMaximized;
end;


const
  SECTION = 'Settings';
  SETTINGS_FILENAME = 'settings.ini';

implementation

{ TSettings }

procedure TSettings.LoadSettings;
var
  FileName: String;
begin
  FileName:= TDAPlatform.GetApplicationFolder('content\\' + SETTINGS_FILENAME);
  FileName:= UTF8ToSys(FileName);
  IniFile:= TIniFile.Create(FileName);

  Title:= IniFile.ReadString(SECTION, 'Title', 'Help Explorer');
  Homepage:= IniFile.ReadString(SECTION, 'Homepage', 'index.html');

  WindowWidth:= IniFile.ReadInteger(SECTION, 'WindowWidth', 800);
  WindowHeight:= IniFile.ReadInteger(SECTION, 'WindowHeight', 800);
  WindowLeft:= IniFile.ReadInteger(SECTION, 'WindowLeft', 800);
  WindowTop:= IniFile.ReadInteger(SECTION, 'WindowTop', 800);

  WindowCenter:= IniFile.ReadBool(SECTION, 'WindowCenter', TRUE);
  ShowToolbar:= IniFile.ReadBool(SECTION, 'ShowToolbar', TRUE);

  StartMaximized:= IniFile.ReadBool(SECTION, 'StartMaximized', FALSE);
end;

end.

