unit DAPlatform;

interface

uses
  SysUtils, StrUtils, fileUtil, LCLIntf, lazfileutils;

type
  TDAPlatform = class
    class procedure Open(sCommand: string);
    class procedure LaunchUrl(sUrl : String);
    class function GetApplicationDataFolder():string;overload;
    class function GetTempFolder():string;overload;
    class function GetApplicationFolder():string;overload;
    class function GetApplicationDataFolder(Path : String):string;overload;
    class function GetTempFolder(Path : String):string;overload;
    class function GetApplicationFolder(Path : String):string;overload;
    class function OpenTextFileFromAppPath(Path : String):String;
    class function OpenTextFile(Path : String):String;
    class function GetLanguage():String;
    class function GetHomeDir():String;
  end;

const
  OSX_RES_PATH = 'app/Contents/Resources';
  OSX_APP_PATH = 'app/Contents/MacOS';
  CRLF = #13#10;

implementation

class function TDAPlatform.GetApplicationDataFolder: string;
var
  str : String;
begin
  str:= GetAppConfigDirUTF8(false);
  //str:= str + prefix + DA_APPLICATION_NAME; //momentan nicht benötigt

  Result:= str;
end;

class function TDAPlatform.GetApplicationFolder: string;
var
  Path : String;
begin
  Path := ExtractFilePath(ParamStr(0));

  {$IFDEF Darwin}
  // unter OSX brauchen wir den Resources Folder
  Path:= AnsiReplaceStr(Path, OSX_APP_PATH, OSX_RES_PATH);
  {$ENDIF Darwin}

  Result := Path;
end;

class function TDAPlatform.GetHomeDir: String;
begin
  Result:= GetUserDir();
end;

class function TDAPlatform.GetTempFolder: string;
begin
  Result := GetTempDir(true);
end;

class procedure TDAPlatform.Open(sCommand: string);
begin
  OpenDocument(sCommand);
end;

class procedure TDAPlatform.LaunchUrl(sUrl: String);
begin
  OpenUrl(sUrl);
end;

class function TDAPlatform.OpenTextFile(Path: String): String;
var
  F: TextFile;
  T,Content : String;
begin
  AssignFile(F, Path);
  Reset(F);
  repeat
    Readln(F, T);
    Content:= Content + T + CRLF;
  until (EOF(F));
  CloseFile(F);

  Result:= Content;
end;

class function TDAPlatform.OpenTextFileFromAppPath(Path: String): String;
var
  FileName, Content : String;
begin
  FileName:= GetApplicationFolder(Path);
  Content:= OpenTextFile(FileName);
  Result:= Content;
end;

class function TDAPlatform.GetApplicationDataFolder(Path: String): string;
begin
  Result := GetApplicationDataFolder() + Path;
end;

class function TDAPlatform.GetApplicationFolder(Path: String): string;
begin
  Result := GetApplicationFolder() + Path;
end;

class function TDAPlatform.GetLanguage: String;
begin
  Result:= 'Deutsch';
end;


class function TDAPlatform.GetTempFolder(Path: String): string;
begin
  Result := GetTempFolder() + Path;
end;

end.

