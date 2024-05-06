unit paths;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.StrUtils, System.IOUtils, registry, iniFiles, VCL.Dialogs;

function IsDirectoryWritable(const AName: string): Boolean;


function get_launcher_config_path():string;
function is_openloco_samedir(): boolean;

function get_openloco_config_path():string;         // returns the %appdata%\OpenLoco\ path
function get_openloco_config():TStringList;         // returns the contents of %appdata%\OpenLoco\openloco.yml

function validate_locomotion_path(): boolean;       // returns true if the configured path contains the Locomotion install

function get_loco_gog_path():string;                // return locomotion path if installed by gog or cd

function get_steam_install_path():string;           // returns steam install path (usually %programfiles%\steam) / called by get_steam_libraryfolders()
function get_steam_libraryfolders():TStringList;    // returns the list of all steam libraries (as found in %programfiles%\steam\steamapps\libraryfolders.vdf)
function get_loco_steam_path():string;              // return locomotion path if installed by steam

function get_locomotion_path(): string;             // searches and returns the locomotion install path
function set_locomotion_path(): boolean;            // updates openloco.yml with locomotion path

implementation
{
function IsDirectoryWritable(const Dir: String): Boolean;
var
  TempFile: array[0..MAX_PATH] of Char;
begin
  if GetTempFileName(PChar(Dir), 'OLL', 0, TempFile) <> 0 then
    Result := DeleteFile(TempFile)
  else
    Result := False;
end; }

function IsDirectoryWritable(const AName: string): Boolean;
var
  FileName: String;
  H: THandle;
begin
  FileName := IncludeTrailingPathDelimiter(AName) + 'ollauncher-chk.tmp';
  H := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0, nil,
    CREATE_NEW, FILE_ATTRIBUTE_TEMPORARY or FILE_FLAG_DELETE_ON_CLOSE, 0);
  Result := H <> INVALID_HANDLE_VALUE;
  if Result then CloseHandle(H);
end;

function get_launcher_config_path():string;
begin
Result := IncludeTrailingPathDelimiter(System.IOUtils.TPath.GetHomePath()) + 'OpenLoco Launcher\';
end;

function is_openloco_samedir(): boolean;
begin
if FileExists(IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'openloco.exe') then Result := true
                                                                                         else Result := false;

end;


function get_openloco_config_path():string;
begin
Result := IncludeTrailingPathDelimiter(System.IOUtils.TPath.GetHomePath()) + 'OpenLoco\';
end;

function get_openloco_config():TStringList;
var cfg: string;
begin
cfg := get_openloco_config_path() + 'openloco.yml';
Result := TStringList.Create;
if FileExists(cfg) then Result.LoadFromFile(cfg);
end;

function validate_locomotion_path(): boolean;
var ts: TStringList;
    i, ipl: integer;
    path: string;
begin
ts := get_openloco_config();

path := '';
ipl := -1;
for i := 0 to ts.Count-1 do
    begin
    if ContainsText(Lowercase(ts.Strings[i]), 'loco_install_path') then ipl:= i;
    end;

if ipl < 0 then
   begin
   Result := false;
   exit;
   end;

path := Trim(Copy(ts.Strings[ipl], 20, Length(ts.Strings[ipl]) - 19));

if FileExists(IncludeTrailingPathDelimiter(path)+'Data\g1.DAT') then Result := true
                                                                else Result := false;

ts.Free;
end;



// return locomotion path if installed by gog or cd
function get_loco_gog_path():string;
var reg: TRegistry;
    path: string;
begin
reg:= TRegistry.Create();
reg.RootKey:= HKEY_LOCAL_MACHINE;
{$IFDEF WIN32}
path:= 'SOFTWARE\Atari\Locomotion Setup\';
{$ELSE}
path:= 'SOFTWARE\WOW6432Node\Atari\Locomotion Setup\';
{$ENDIF}
if reg.OpenKeyReadOnly(path) then
   begin
   Result := IncludeTrailingPathDelimiter(reg.ReadString('Path'));
   reg.CloseKey();
   end
else
   begin
   Result := '';
   end;

reg.Free;
end;



// called by get_steam_libraryfolders() - no need to call manually
function get_steam_install_path():string;
var reg: TRegistry;
begin
reg:= TRegistry.Create();
reg.RootKey:= HKEY_CURRENT_USER;
if reg.OpenKeyReadOnly('SOFTWARE\Valve\Steam\') then
   begin
   Result := IncludeTrailingPathDelimiter(StringReplace(reg.ReadString('SteamPath'), '/', '\', [rfReplaceAll]));
   reg.CloseKey();
   end
else
   begin
   Result := '';
   end;
reg.Free;
end;


// called by get_loco_steam_path()
function get_steam_libraryfolders():TStringList;
var t: TStringList;
    s, s2:string;
    i:integer;
begin
s := get_steam_install_path() + 'steamapps\libraryfolders.vdf';

t := TStringList.Create;
t.LoadFromFile(s);

Result := TStringList.Create;

for i := 0 to t.Count-1 do
    begin
    if ContainsText(t.Strings[i], '"path"') then
       begin
       s2 := StringReplace(t.Strings[i], '"path"', '', [rfReplaceAll,rfIgnoreCase]);
       s2 := StringReplace(s2, #9, '', [rfReplaceAll]);     // remove tabs
       s2 := StringReplace(s2, '"', '', [rfReplaceAll]);    // remove quotes
       s2 := StringReplace(s2, '\\', '\', [rfReplaceAll]);  // replace escapes for slash
       Result.Add(IncludeTrailingPathDelimiter(s2)+'steamapps\common\Locomotion');
       end;
    end;

t.Free;

end;


// return locomotion path if installed in steam
function get_loco_steam_path():string;
var t: TStringList;
    i: integer;
    s: string;
begin
t := get_steam_libraryfolders();

Result := '';

for i := 0 to t.Count-1 do
    begin
    s := IncludeTrailingPathDelimiter(t.Strings[i]) + 'loco.exe';
    if DirectoryExists(t.Strings[i]) and (FileExists(s)) then Result:= t.Strings[i];
    end;

end;



// searches and returns the locomotion install path
// prefers GOG version to steam version
function get_locomotion_path(): string;
begin
// try GOG install
Result := get_loco_gog_path();
// if not GOG then try Steam
if Result = '' then Result := get_loco_steam_path();
end;


function set_locomotion_path(): boolean;
var path: string;
var i, ipl: integer;
    s: string;
    ts: TStringList;
begin
// get loco path
path := get_locomotion_path();
if path = '' then
   begin
   // unable to locate locomotion path - abort
   Result := false;
   exit;
   end;

// load openloco.yml
ts := get_openloco_config();
ipl := -1;
for i := 0 to ts.Count-1 do
    begin
    if ContainsText(Lowercase(ts.Strings[i]), 'loco_install_path') then ipl:= i;
    end;

if ipl < 0 then ts.Add('loco_install_path: '+path)                 // either openloco.yml is missing or install line not set
           else ts.Strings[ipl] := 'loco_install_path: '+path;     // replace existing line with the proper install path

// save config
ts.SaveToFile(get_openloco_config_path() + 'openloco.yml');

ts.Free;
Result := true;
end;

end.
