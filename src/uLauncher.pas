unit uLauncher;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls, System.IOUtils, System.Math,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, System.DateUtils,
  IdHeaderList, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdBaseComponent,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  superdate, superobject, supertimezone, supertypes,
  gfx_utils, paths, server_handling, ImageButton, iniFiles, ShellApi
  ;

type
  TfrmLauncher = class(TForm)
    img_BG: TImage;
    lbl_cur_ver: TLabel;
    panel_titlebar: TPanel;
    shape_titlebar: TShape;
    label_title: TLabel;
    img_logo: TImage;
    img_logo_title: TImage;
    Button1: TButton;
    shape_window_frame: TShape;
    lbl_locomotion_path: TLabel;
    lbl_locomotion_path1: TLabel;
    lbl_latest_ver: TLabel;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTP1: TIdHTTP;
    img_train: TImage;
    img_train_tracks: TImage;
    LocoAnimationTimer: TTimer;
    btn_close: TShuImgBtn;
    btn_minimize: TShuImgBtn;
    panel_no_openloco: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    btn_dl_openloco: TShuImgBtn;
    btn_Play: TShuImgBtn;
    btn_options: TShuImgBtn;
    btn_launcher_update: TShuImgBtn;
    btnUpdateOpenLoco: TShuImgBtn;
    panel_no_locomotion: TPanel;
    Shape3: TShape;
    lbl_no_locomotion_title: TLabel;
    Shape4: TShape;
    lbl_no_locomotion_text: TLabel;
    lbl_autostart: TLabel;
    timerAutostart: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_titlebar_closeClick(Sender: TObject);
    procedure btn_titlebar_minimizeClick(Sender: TObject);
    procedure panel_titlebarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure LocoAnimationTimerTimer(Sender: TObject);
    procedure btn_dl_openlocoClick(Sender: TObject);
    procedure btn_PlayClick(Sender: TObject);
    procedure btn_launcher_updateClick(Sender: TObject);
    procedure btn_optionsClick(Sender: TObject);
    procedure timerAutostartTimer(Sender: TObject);
    procedure lbl_autostartClick(Sender: TObject);
  private
    { Private declarations }
    latest_json : string;
    latest_launcher_json: string;

    openloco_cur_ver: string;
    openloco_new_ver: string;

    autostart_timer: integer;

    // Font handles
    ttf_title: NativeUInt;
    ttf_text: NativeUInt;
    procedure LoadFonts;
    procedure UnLoadFonts();
  protected
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
  public
    { Public declarations }
    cfg : TMemIniFile;

    ol_install_in: string; // openloco installation path (either launcher dir + subdirs or %appdata%+subdirs


    openloco_path: string;
    openloco_exe : string;
    openloco_ver : string;

    openloco_ver_path: string; // will be empty in case of same dir, otherwise will contain subdir for active version
  end;

const
  LAUNCHER_VERSION = 'v0.7';
  RES_TRAIN_COUNT = 5;      // how many train images are available (res PNG TRAIN_x)

var
  frmLauncher: TfrmLauncher;

implementation

{$R *.dfm}

uses uDownloader, uOptions;

procedure TfrmLauncher.LoadFonts();  // Note: using "1" to refer to Font #1
var
  ResStream1 : TResourceStream;
  FontsCount1 : DWORD;
  Result1 : Boolean;
begin
  ResStream1 := TResourceStream.CreateFromID(hInstance, 1, RT_FONT); // This is Resource ID 1
  try
    ttf_title := AddFontMemResourceEx(ResStream1.Memory, ResStream1.Size, nil, @FontsCount1);
    Result1 := (ttf_title <> 0);
    // If you want to show a message box on failure, you can check Result1
    // otherwise the font is loaded now; ttf_title is ready
  finally
    ResStream1.Free;
  end;

  ResStream1 := TResourceStream.CreateFromID(hInstance, 2, RT_FONT); // This is Resource ID 2
  try
    ttf_text := AddFontMemResourceEx(ResStream1.Memory, ResStream1.Size, nil, @FontsCount1);
    Result1 := (ttf_text <> 0);
    // If you want to show a message box on failure, you can check Result1
    // otherwise the font is loaded now; ttf_text is ready
  finally
    ResStream1.Free;
  end;

{
  ResStream1 := TResourceStream.Create(hInstance, 'CONSTRUCTION_BOLD', 'OTF');
  try
    ttf_title := AddFontMemResourceEx(ResStream1.Memory, ResStream1.Size, nil, @FontsCount1);
    Result1 := (ttf_title <> 0);
    // If you want to show a message box on failure, you can check Result1
    // otherwise the font is loaded now; ttf_text is ready
  finally
    ResStream1.Free;
  end;

  ResStream1 := TResourceStream.Create(hInstance, 'CONSTRUCTION_LIGHT', 'OTF');
  try
    ttf_text := AddFontMemResourceEx(ResStream1.Memory, ResStream1.Size, nil, @FontsCount1);
    Result1 := (ttf_text <> 0);
    // If you want to show a message box on failure, you can check Result1
    // otherwise the font is loaded now; ttf_text is ready
  finally
    ResStream1.Free;
  end;
}

end;


procedure TfrmLauncher.UnLoadFonts();
var
  Result1: Boolean;
begin
  if ttf_title > 0 then
    Result1 := RemoveFontMemResourceEx(ttf_title);
    // once again you can check Result1 and show any failure messages if desired
  if ttf_text > 0 then
    Result1 := RemoveFontMemResourceEx(ttf_text);
    // once again you can check Result1 and show any failure messages if desired
end;


procedure TfrmLauncher.panel_titlebarMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

procedure TfrmLauncher.timerAutostartTimer(Sender: TObject);
begin
autostart_timer := autostart_timer - 1;
if autostart_timer > 0 then lbl_autostart.Caption := 'Autostarting in '+IntToStr(autostart_timer)+' seconds...'
else
  begin
  timerAutostart.Enabled := false;
  btn_PlayClick(Sender);
  end;

end;

procedure TfrmLauncher.LocoAnimationTimerTimer(Sender: TObject);
var train_no:integer;
begin
img_train.Left := img_train.Left + 3;
if img_train.Left >= ClientWidth + img_train.Width then
   begin
   img_train.Left := 0 - img_train.Width - 20;
   train_no := System.Math.RandomRange(1, RES_TRAIN_COUNT+1);
   img_train.Picture.LoadFromPNGResourceName(0, 'TRAIN_'+IntToStr(train_no));
   end;

end;

procedure TfrmLauncher.WMNCHitTest(var Msg: TWMNCHitTest);
//const EDGEDETECT = 7; // adjust - how many pixels from the edge to react to
//var deltaRect: TRect;
begin
  inherited;
// the following code would allow resizing when not showing borders
{
   if BorderStyle = TFormBorderStyle.bsNone then
    with Msg, deltaRect do
    begin
     Left := XPos - BoundsRect.Left;
      Right := BoundsRect.Right - XPos;
      Top := YPos - BoundsRect.Top;
      Bottom := BoundsRect.Bottom - YPos;
      if (Top < EDGEDETECT) and (Left < EDGEDETECT) then
        Result := HTTOPLEFT
      else if (Top < EDGEDETECT) and (Right < EDGEDETECT) then
        Result := HTTOPRIGHT
      else if (Bottom < EDGEDETECT) and (Left < EDGEDETECT) then
        Result := HTBOTTOMLEFT
      else if (Bottom < EDGEDETECT) and (Right < EDGEDETECT) then
        Result := HTBOTTOMRIGHT
      else if (Top < EDGEDETECT) then
        Result := HTTOP
      else if (Left < EDGEDETECT) then
        Result := HTLEFT
      else if (Bottom < EDGEDETECT) then
        Result := HTBOTTOM
      else if (Right < EDGEDETECT) then
        Result := HTRIGHT
    end;
     }

//if Msg.Result = htClient then Msg.Result := htCaption;
end;

procedure TfrmLauncher.btn_dl_openlocoClick(Sender: TObject);
var obj:ISuperObject;
    frm: TfrmDownloader;
    s: string;
begin

obj := SO(latest_json);

s := cfg.ReadString('LAUNCHER', 'openloco.base.path', get_launcher_config_path())+'download\';
if not DirectoryExists(s) then ForceDirectories(s);

frm := TfrmDownloader.Create(frmLauncher);
frm.target_name := obj.AsObject.S['name'];
frm.target_url := obj.O['assets'].AsArray[0].S['browser_download_url'];
frm.save_to := s+ obj.O['assets'].AsArray[0].S['name'];
frm.extract_to := cfg.ReadString('LAUNCHER', 'openloco.base.path', get_launcher_config_path()) + obj.AsObject.S['name'] + '\';
frm.zip_size := obj.O['assets'].AsArray[0].I['size'];
frm.ShowModal;
// set new version as active version
cfg.WriteString('LAUNCHER', 'openloco.active.version', obj.AsObject.S['name']);

s:= obj.AsObject.S['name'];
cfg.WriteString(s, 'version', obj.AsObject.S['name']);
cfg.WriteString(s, 'updated', obj.O['assets'].AsArray[0].S['updated_at']);
cfg.WriteString(s, 'install_path', cfg.ReadString('LAUNCHER', 'openloco.base.path', get_launcher_config_path()) + obj.AsObject.S['name'] + '\' );
cfg.WriteBool(s, 'is_prelease', obj.AsObject.B['prerelease']);

// update current version
openloco_cur_ver := obj.AsObject.S['name'];
frm.Free;

panel_no_openloco.Visible := false;

btn_play.Visible := true;
btn_play.Caption := 'Play OpenLoco '+openloco_cur_ver;
btn_play.UpdateImgBtn;

btnUpdateOpenLoco.Visible := false;
end;

procedure TfrmLauncher.btn_launcher_updateClick(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://github.com/shusaura85/openlocolauncher/releases/latest', nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmLauncher.btn_optionsClick(Sender: TObject);
var frm:TfrmOptions;
begin
if timerAutostart.Enabled then
   begin
   timerAutostart.Enabled := false;
   lbl_autostart.Visible := false;
   end;
frm := TfrmOptions.Create(frmLauncher);
frm.ShowModal;
frm.Free;
end;

procedure TfrmLauncher.btn_PlayClick(Sender: TObject);
var path, exe, params, s: string;
    same_dir: boolean;
    openmode: integer;
begin
same_dir := cfg.ReadBool('LAUNCHER', 'openloco.samedir', false);

if same_dir then
   begin
   path := IncludeTrailingPathDelimiter( ExtractFilePath(ParamStr(0)) );
   end
else
   begin
   path := IncludeTrailingPathDelimiter( cfg.ReadString('LAUNCHER', 'openloco.base.path', get_launcher_config_path()) + cfg.ReadString('LAUNCHER', 'openloco.active.version', '') );
   end;

exe := path + 'openloco.exe';

params := '';
if cfg.ReadBool('LAUNCHER', 'openloco.intro.enabled', false) = true then params := '--intro';

if cfg.ReadBool('LAUNCHER', 'openloco.logs.use_custom', false) then
   begin
   s := '"';
   if cfg.ReadBool('LAUNCHER', 'openloco.logs.info', true) then
      begin
      if s = '"' then s := s + 'info'
                 else s := s + ', info';
      end;
   if cfg.ReadBool('LAUNCHER', 'openloco.logs.warning', true) then
      begin
      if s = '"' then s := s + 'warning'
                 else s := s + ', warning';
      end;
   if cfg.ReadBool('LAUNCHER', 'openloco.logs.error', true) then
      begin
      if s = '"' then s := s + 'error'
                 else s := s + ', error';
      end;
   if cfg.ReadBool('LAUNCHER', 'openloco.logs.verbose', false) then
      begin
      if s = '"' then s := s + 'verbose'
                 else s := s + ', verbose';
      end;
   s := s+ '"';

   params := params + ' --log_levels '+s;
   end;

openmode := SW_SHOWNORMAL;
if cfg.ReadBool('LAUNCHER', 'openloco.console.minimized', false) then openmode:= SW_SHOWMINIMIZED;

ShellExecute(0,'open',PChar(exe),PChar(params), PChar(ExtractFilePath(exe)), openmode);
Close;
end;

procedure TfrmLauncher.btn_titlebar_closeClick(Sender: TObject);
begin
Close;
end;

procedure TfrmLauncher.btn_titlebar_minimizeClick(Sender: TObject);
begin
Application.Minimize;
end;

procedure TfrmLauncher.Button1Click(Sender: TObject);
//var obj:ISuperObject;
begin
{if not validate_locomotion_path() then
   begin
   ShowMessage('Loco path invalid - fixing it');
   set_locomotion_path();
   end
else ShowMessage('Loco path valid - no changes done');
}
end;

procedure TfrmLauncher.FormCreate(Sender: TObject);
var obj:ISuperObject;
    jtime: TDateTime;
    utime: Int64;
    no_check: boolean;
    s: string;
    train_no: integer;
begin
LoadFonts();

Randomize;
train_no := System.Math.RandomRange(1, RES_TRAIN_COUNT+1);

// make sure launcher config path exists
if not DirectoryExists(get_launcher_config_path()) then ForceDirectories(get_launcher_config_path());
// open launcher config
cfg := TMemIniFile.Create(get_launcher_config_path() + 'launcher.config', TEncoding.UTF8);

img_BG.Picture.LoadFromPNGResourceName(0, 'BG');

img_logo.Picture.LoadFromPNGResourceName(0, 'OPENLOCO');
img_logo_title.Picture.LoadFromPNGResourceName(0, 'OPENLOCO');

img_train_tracks.Picture.LoadFromPNGResourceName(0, 'TRACKS');
img_train.Picture.LoadFromPNGResourceName(0, 'TRAIN_'+IntToStr(train_no));

btn_close.LoadPNGFromResource('BTN_TB_UP', bsUp);
btn_close.LoadPNGFromResource('BTN_TB_DOWN', bsDown);
btn_close.LoadPNGFromResource('BTN_TB_HOVER', bsHover);

btn_minimize.LoadPNGFromResource('BTN_TB_UP', bsUp);
btn_minimize.LoadPNGFromResource('BTN_TB_DOWN', bsDown);
btn_minimize.LoadPNGFromResource('BTN_TB_HOVER', bsHover);


btn_dl_openloco.LoadPNGFromResource('BTN_DL_UP', bsUp);
btn_dl_openloco.LoadPNGFromResource('BTN_DL_DOWN', bsDown);
btn_dl_openloco.LoadPNGFromResource('BTN_DL_HOVER', bsHover);

btn_play.LoadPNGFromResource('BTN_DL_UP', bsUp);
btn_play.LoadPNGFromResource('BTN_DL_DOWN', bsDown);
btn_play.LoadPNGFromResource('BTN_DL_HOVER', bsHover);

btnUpdateOpenLoco.LoadPNGFromResource('BTN_SM_UP', bsUp);
btnUpdateOpenLoco.LoadPNGFromResource('BTN_SM_DOWN', bsDown);
btnUpdateOpenLoco.LoadPNGFromResource('BTN_SM_HOVER', bsHover);

btn_launcher_update.LoadPNGFromResource('BTN_SM_UP', bsUp);
btn_launcher_update.LoadPNGFromResource('BTN_SM_DOWN', bsDown);
btn_launcher_update.LoadPNGFromResource('BTN_SM_HOVER', bsHover);

btn_options.LoadPNGFromResource('BTN_SM_UP', bsUp);
btn_options.LoadPNGFromResource('BTN_SM_DOWN', bsDown);
btn_options.LoadPNGFromResource('BTN_SM_HOVER', bsHover);




Font.Name := 'Onesize'; // 'Construction Sans Bold'; //
Font.Color := clYellow;

panel_titlebar.Font.Style := [fsBold];

label_title.Font.Size := 16;

openloco_cur_ver := cfg.ReadString('LAUNCHER', 'openloco.active.version', 'none');
openloco_new_ver := ''; // to be filled later

lbl_cur_ver.Caption := 'Current version: ' + openloco_cur_ver;

// check for latest version of OpenLoco (once an hour)
no_check := false;
if FileExists( get_launcher_config_path() + 'latest.json') then
   begin
   FileAge(get_launcher_config_path() + 'latest.json', jtime);
   utime := DateTimeToUnix(jtime);
   if utime > (DateTimeToUnix(Now()) - 3600) then
      begin
      no_check := true;
      // last checked less than 1 hour ago, use already cached file
      latest_json := System.IOUtils.TFile.ReadAllText( get_launcher_config_path() + 'latest.json', TEncoding.UTF8 );
      obj := SO(latest_json);
      openloco_new_ver := obj.AsObject.S['name'];
      lbl_latest_ver.Caption := 'Latest version: ' + openloco_new_ver;
      end;
   end;

if not no_check then
  begin
    try
       latest_json := GetUrlContent('https://api.github.com/repos/OpenLoco/OpenLoco/releases/latest');

       System.IOUtils.TFile.WriteAllText( get_launcher_config_path() + 'latest.json', latest_json );

       obj := SO(latest_json);
       openloco_new_ver := obj.AsObject.S['name'];
       lbl_latest_ver.Caption := 'Latest version: ' + openloco_new_ver;
    except
//       lbl_latest_ver.Caption := 'Latest version: unable to connect';
       on E : Exception do
          ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
    end;

  end;


// check for newer launcher version (once a day only)
no_check := false;
if FileExists( get_launcher_config_path() + 'latest-launcher.json') then
   begin
   FileAge(get_launcher_config_path() + 'latest-launcher.json', jtime);
   utime := DateTimeToUnix(jtime);
   if utime > (DateTimeToUnix(Now()) - 86400) then
      begin
      no_check := true;
      // last checked less than 1 day ago, use already cached file
      latest_launcher_json := System.IOUtils.TFile.ReadAllText( get_launcher_config_path() + 'latest-launcher.json', TEncoding.UTF8 );
      if latest_launcher_json <> '' then
         begin
         obj := SO(latest_launcher_json);
         if obj.AsObject.Exists('name') then
            begin
            s := obj.AsObject.S['name'];
            if s <> LAUNCHER_VERSION then btn_launcher_update.Visible := true
                                     else btn_launcher_update.Visible := false;
            end;
         end;
      end;
   end;

if not no_check then
  begin
    try
       latest_launcher_json := GetUrlContent('https://api.github.com/repos/shusaura85/openlocolauncher/releases/latest');

      if latest_launcher_json <> '' then
         begin
         System.IOUtils.TFile.WriteAllText( get_launcher_config_path() + 'latest-launcher.json', latest_launcher_json );

         obj := SO(latest_launcher_json);
         if obj.AsObject.Exists('name') then
            begin
            s := obj.AsObject.S['name'];
            if s <> LAUNCHER_VERSION then btn_launcher_update.Visible := true
                                     else btn_launcher_update.Visible := false;
            end;
         end;
    except
//       lbl_latest_ver.Caption := 'Latest version: unable to connect';
       on E : Exception do
          ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
    end;

  end;


btn_dl_openloco.Caption := 'Download OpenLoco '+ openloco_new_ver;
btn_dl_openloco.UpdateImgBtn;

btn_play.Left := (ClientWidth div 2) - (btn_play.Width div 2);
btn_play.Caption := 'Play OpenLoco '+ openloco_cur_ver;
btn_play.UpdateImgBtn;

if openloco_cur_ver <> openloco_new_ver then btnUpdateOpenLoco.Visible := true
                                        else btnUpdateOpenLoco.Visible := false;

btnUpdateOpenLoco.Left := (ClientWidth div 2) - (btnUpdateOpenLoco.Width div 2);
end;


procedure DrawTextOutline(const Canvas: TCanvas; const X, Y: Integer;
  const Text: string);
var
  OldBkMode: Integer;  // stores previous background mode
begin
  OldBkMode := SetBkMode(Canvas.Handle, TRANSPARENT);
  BeginPath(Canvas.Handle);
  Canvas.TextOut(X, Y, Text);
  EndPath(Canvas.Handle);
  StrokeAndFillPath(Canvas.Handle);
  SetBkMode(Canvas.Handle, OldBkMode);
end;

procedure TfrmLauncher.FormDestroy(Sender: TObject);
begin
UnLoadFonts();

cfg.UpdateFile;
cfg.Free;
end;

procedure TfrmLauncher.FormPaint(Sender: TObject);
{var x, y, w: Integer;
const cText = 'OpenLoco'; }
begin
{with (img_BG.Picture.Graphic as TPngImage) do
     begin
  Canvas.Font.Name := 'Onesize Reverse';   // custom font loaded at runtime
  Canvas.Font.Style := [fsBold];
  Canvas.Font.Size := 60;
  Canvas.Brush.Color := clSkyBlue;  // $F0CAA6
  Canvas.Brush.Style := TBrushStyle.bsSolid; //bsDiagCross;
  Canvas.Pen.Color := clGreen;
  Canvas.Pen.Style := TPenStyle.psSolid;
  Canvas.Pen.Width := 1;
  // this ensures that no matter what font settings are used, the text is centered
  w := Canvas.TextWidth(cText);
  x := (Width div 2) - (w div 2);
  y := 30;
  DrawTextOutline(Canvas, x, y, cText);

  w := Canvas.TextWidth('v24.03');
  x := (Width div 2) - (w div 2);
  y := 120;
  DrawTextOutline(Canvas, x, y, 'v24.03');
     end;
}
end;

procedure TfrmLauncher.FormShow(Sender: TObject);
var ts: TStringList;
    act_ver: string;
begin
if validate_locomotion_path then
   begin
   lbl_locomotion_path.Caption := '[ OK ]';
   lbl_locomotion_path.Font.Color := clLime;
   end
else
if set_locomotion_path() then
   begin
   lbl_locomotion_path.Caption := '[ FIXED ]';
   lbl_locomotion_path.Hint := 'OpenLoco path was invalid - updated to correct path';
   lbl_locomotion_path.ShowHint := true;
   lbl_locomotion_path.Font.Color := clLime;
   end
else
   begin
   lbl_locomotion_path.Caption := 'FAIL';
   lbl_locomotion_path.Font.Color := $000000D2;
   lbl_locomotion_path.Font.Style := [fsBold];

   btn_play.Visible := false;
   btnUpdateOpenLoco.Visible := false;

   panel_no_locomotion.Visible := true;
   panel_no_locomotion.Top := (ClientHeight div 2) - (panel_no_locomotion.Height div 2);
   panel_no_locomotion.Left := (ClientWidth div 2) - (panel_no_locomotion.Width div 2);
   exit; // don't go pass this step
   end;

// check if launcher is placed in the same dir as the game
if is_openloco_samedir() then
   begin
   openloco_path:= IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
   openloco_exe := openloco_path+'openloco.exe';
   openloco_ver := '???';
   openloco_ver_path := '';
   if FileExists(openloco_path+'CHANGELOG.md') then
      begin
      ts := TStringList.Create;
      ts.LoadFromFile(openloco_path+'CHANGELOG.md');
      ts.Text := Trim(ts.Text);
      openloco_ver := Trim(ts.Strings[0]);
      end;

   lbl_cur_ver.Caption := 'Current version: '+openloco_ver;

   cfg.WriteBool('LAUNCHER', 'openloco.samedir', true);
   cfg.WriteString('LAUNCHER', 'openlooc.base.path', '');
   end
else
   begin
   // openloco is not in the same dir as ol launcher

   ol_install_in := cfg.ReadString('LAUNCHER', 'openloco.base.path', '');
   if ol_install_in = '' then
       begin
       if IsDirectoryWritable(ExtractFilePath(ParamStr(0))) then ol_install_in := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))
                                                            else ol_install_in := get_launcher_config_path();

       cfg.WriteBool('LAUNCHER', 'openloco.samedir', false);
       cfg.WriteString('LAUNCHER', 'openloco.base.path', ol_install_in);
       end;

   act_ver := cfg.ReadString('LAUNCHER', 'openloco.active.version', '');
   if act_ver <> '' then
       begin
       openloco_exe := ol_install_in + act_ver + '\openloco.exe';
       openloco_ver := act_ver;
       openloco_ver_path := ol_install_in+act_ver + '\';

       if not FileExists(openloco_exe) then
          begin
          btn_play.Visible := false;

          panel_no_openloco.Top := (ClientHeight div 2) - (panel_no_openloco.Height div 2);
          panel_no_openloco.Left := (ClientWidth div 2) - (panel_no_openloco.Width div 2);
          panel_no_openloco.Visible := true;

          btnUpdateOpenLoco.Visible := false;
          exit;
          end;
       end
   else
       begin
       btn_play.Visible := false;
       // no active version of openloco - request download
       panel_no_openloco.Top := (ClientHeight div 2) - (panel_no_openloco.Height div 2);
       panel_no_openloco.Left := (ClientWidth div 2) - (panel_no_openloco.Width div 2);
       panel_no_openloco.Visible := true;

       btnUpdateOpenLoco.Visible := false;
       exit;
       end;

   end;

if ( cfg.ReadBool('LAUNCHER', 'openloco.autostart.enabled', false) ) AND (openloco_cur_ver = openloco_new_ver) then
   begin
   autostart_timer := cfg.ReadInteger('LAUNCHER', 'openloco.autostart.time', 5);
   lbl_autostart.Visible := true;
   lbl_autostart.Caption := 'Autostarting in '+IntToStr(autostart_timer)+' seconds...';
   timerAutostart.Enabled := true;
   end;
end;

procedure TfrmLauncher.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
//var pb_pos: Integer;
begin
//pb_pos := AWorkCount div pb_perc;
//img_pb.Left := (0 - img_pb.Width) + pb_pos;

//ProgressBar1.Position := AWorkCount;
Application.ProcessMessages;
end;

procedure TfrmLauncher.IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
//img_pb.Left := (0 - img_pb.Width);
//pb_max := progressbar1.Width + (img_pb.Width);
//pb_perc := pb_max div 100;
Application.ProcessMessages;

//ProgressBar1.Max := AWorkCountMax;
//ProgressBar1.Position := 0;
//ProgressBar1.Visible := true;
Application.ProcessMessages;
end;

procedure TfrmLauncher.IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
//img_pb.Left := progressbar1.Width - img_pb.Width;

//ProgressBar1.Visible := false;
Application.ProcessMessages;
end;

procedure TfrmLauncher.lbl_autostartClick(Sender: TObject);
begin
timerAutostart.Enabled := false;
lbl_autostart.Visible := false;
end;

end.
