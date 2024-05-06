unit server_handling;

interface

uses
  Windows, Messages, Dialogs, Types, Variants, SysUtils, Classes, Forms, Graphics,
  IniFiles, DateUtils, Math,
  {begin indy components}
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP
  {end indy components};

function GetUrlContent(s: string): string;

function ConvertBytes(Bytes: Int64): string;

implementation

uses uLauncher;

function GetUrlContent(s: string): string;
var
  IdHTTP1: TIdHTTP;
begin
Application.ProcessMessages;

  IdHTTP1 := TIdHTTP.Create;
  {properties}
  IdHTTP1.AllowCookies := frmLauncher.IdHTTP1.AllowCookies;
  IdHTTP1.Compressor := frmLauncher.IdHTTP1.Compressor;
  IdHTTP1.CookieManager := frmLauncher.IdHTTP1.CookieManager;
  IdHTTP1.HandleRedirects := frmLauncher.IdHTTP1.HandleRedirects;
  IdHTTP1.HTTPOptions := frmLauncher.IdHTTP1.HTTPOptions;
  IdHTTP1.Intercept := frmLauncher.IdHTTP1.Intercept;
  IdHTTP1.IOHandler := frmLauncher.IdHTTP1.IOHandler;
  IdHTTP1.MaxAuthRetries := frmLauncher.IdHTTP1.MaxAuthRetries;
  IdHTTP1.ProtocolVersion := frmLauncher.IdHTTP1.ProtocolVersion;
  IdHTTP1.RedirectMaximum := frmLauncher.IdHTTP1.RedirectMaximum;
  IdHTTP1.Request := frmLauncher.IdHTTP1.Request;
  {events}
  IdHTTP1.OnAuthorization := frmLauncher.IdHTTP1.OnAuthorization;
  IdHTTP1.OnConnected := frmLauncher.IdHTTP1.OnConnected;
  IdHTTP1.OnDisconnected := frmLauncher.IdHTTP1.OnDisconnected;
  IdHTTP1.OnHeadersAvailable := frmLauncher.IdHTTP1.OnHeadersAvailable;
  IdHTTP1.OnRedirect := frmLauncher.IdHTTP1.OnRedirect;
  IdHTTP1.OnSelectAuthorization := frmLauncher.IdHTTP1.OnSelectAuthorization;
  IdHTTP1.OnStatus := frmLauncher.IdHTTP1.OnStatus;
  IdHTTP1.OnWork := frmLauncher.IdHTTP1.OnWork;
  IdHTTP1.OnWorkBegin := frmLauncher.IdHTTP1.OnWorkBegin;
  IdHTTP1.OnWorkEnd := frmLauncher.IdHTTP1.OnWorkEnd;

  try
    Result := IdHTTP1.Get(s);
  finally
    IdHTTP1.Free;
  end;

Application.ProcessMessages;

Result := trim(Result);
end;



function ConvertBytes(Bytes: Int64): string;
const
  Description: Array [0 .. 8] of string = ('Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB');
var
  i: Integer;
begin
  i := 0;

  while Bytes > IntPower(1024, i + 1) do
    Inc(i);

  Result := FormatFloat('###0.##', Bytes / IntPower(1024, i)) + ' ' + Description[i];
end;

end.
