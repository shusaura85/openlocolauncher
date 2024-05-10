unit uDownloader;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, ImageButton, Vcl.StdCtrls, System.Math,
  server_handling, paths, gfx_utils, IdComponent, Vcl.Imaging.pngimage,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  System.Zip;

type
  TfrmDownloader = class(TForm)
    Shape2: TShape;
    shape_titlebar: TShape;
    btn_close: TShuImgBtn;
    label_title: TLabel;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    img_track: TImage;
    lbl_status: TLabel;
    DownloadTimer: TTimer;
    ExtractTimer: TTimer;
    img_tracke: TImage;
    img_pbe: TImage;
    lbl_extract_status: TLabel;
    CloseTimer: TTimer;
    img_pb: TImage;
    procedure shape_titlebarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IdHTTP1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure DownloadTimerTimer(Sender: TObject);
    procedure ExtractTimerTimer(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
  private
    { Private declarations }
    pb_max : Int64;
    pb_perc: Int64;

    real_max: Int64;
    real_perc: Int64;

    procedure Start_Download;

    procedure OnZipExtract(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);  // used when extracting zip
  public
    { Public declarations }
    target_name: string;
    target_url: string;
    save_to: string;
    extract_to: string;
    zip_size: Integer;
  end;

var
  frmDownloader: TfrmDownloader;

implementation

{$R *.dfm}

uses uLauncher;

procedure TfrmDownloader.Start_Download;
var
  s: TFileStream;
begin
Application.ProcessMessages;

lbl_status.Caption := 'Downloading '+target_url;

s := TFileStream.Create(save_to, fmCreate);
try
    IdHTTP1.Get(target_url, s);
finally
    s.Free;
end;
//lbl_status.Caption := 'Download complete!';

Application.ProcessMessages;

ExtractTimer.Enabled := true;
end;


procedure TfrmDownloader.OnZipExtract(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
begin
Application.ProcessMessages;
end;



procedure TfrmDownloader.btn_closeClick(Sender: TObject);
begin
Close;
end;

procedure TfrmDownloader.CloseTimerTimer(Sender: TObject);
begin
Close;
end;

procedure TfrmDownloader.DownloadTimerTimer(Sender: TObject);
begin
DownloadTimer.Enabled := false;
Start_Download;
end;

procedure TfrmDownloader.ExtractTimerTimer(Sender: TObject);
var zip : TZipFile;
    i : integer;
    perc_width: integer;
    perc_done: Integer;
begin
ExtractTimer.Enabled := false;
try
  zip := TZipFile.Create;
  zip.Open(save_to, zmRead);

  if not DirectoryExists(extract_to) then ForceDirectories(extract_to);

  zip.OnProgress := OnZipExtract;

  lbl_extract_status.Caption := 'Checking archive...';

//perc_width := Round(Header.UncompressedSize / 100);
//if Header.UncompressedSize > 0 then perc_done := Position div Header.UncompressedSize;

//img_pbe.Left := (perc_width * perc_done) - img_pbe.Width;


//lbl_extract_status.Caption := 'Extracting... ';

  perc_width := img_tracke.Width div 100;
  perc_done := 0;

  for i := 0 to Zip.FileCount - 1 do
      begin
      perc_done := Round( (i / (zip.FileCount-1))*100 );
      img_pbe.Left := (perc_width * perc_done) - img_pbe.Width;

//      Memo1.Lines.Add(zip.FileNames[i] + ': ' + IntToStr(zip.FileInfo[i].UncompressedSize));
      lbl_extract_status.Caption := '[' + IntToStr(i+1) + ' / ' + IntToStr(zip.FileCount) + '] Extracting... ' + zip.FileNames[i];
      zip.Extract(zip.FileNames[i], extract_to, true);
      end;
  // set at 100%
  img_pbe.Left := img_tracke.Width - img_pbe.Width;

  //zip.ExtractAll(extract_to);
finally
       zip.Close;
       zip.Free;
  end;

  lbl_extract_status.Caption := 'Game extracted! Ready to play!';

  // auto close downloader
  CloseTimer.Enabled := true;
end;

procedure TfrmDownloader.FormCreate(Sender: TObject);
var train_no: integer;
begin
Font.Assign(frmLauncher.Font);

btn_close.LoadPNGFromResource('BTN_TB_UP', bsUp);
btn_close.LoadPNGFromResource('BTN_TB_DOWN', bsDown);
btn_close.LoadPNGFromResource('BTN_TB_HOVER', bsHover);

img_track.Picture.LoadFromPNGResourceName(0, 'TRACKS');
img_tracke.Picture.LoadFromPNGResourceName(0, 'TRACKS');

Randomize;
train_no := System.Math.RandomRange(1, RES_TRAIN_COUNT+1);
img_pb.Picture.LoadFromPNGResourceName(0, 'TRAIN_'+IntToStr(train_no));
train_no := System.Math.RandomRange(1, RES_TRAIN_COUNT+1);
img_pbe.Picture.LoadFromPNGResourceName(0, 'TRAIN_'+IntToStr(train_no));

target_url := '';
save_to := '';

img_pb.Left := 0 - img_pb.Width;
end;

procedure TfrmDownloader.FormShow(Sender: TObject);
begin
img_pb.Left := 0 - img_pb.Width;
img_pbe.Left := 0 - img_pbe.Width;

lbl_Status.Caption := 'Preparing to download...';
lbl_extract_Status.Caption := 'Waiting for download to complete...';

DownloadTimer.Enabled := true;
end;

procedure TfrmDownloader.IdHTTP1Status(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: string);
begin
lbl_Status.Caption := AStatusText;
end;

procedure TfrmDownloader.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
var pb_pos: Integer;
    real_pos: integer;
begin
real_pos := Round(AWorkCount / real_perc);

pb_pos := pb_perc * real_pos;
//img_pb.Left := (0 - img_pb.Width) + pb_pos;
img_pb.Left := pb_pos - img_pb.Width;

lbl_Status.Caption := 'Downloading... '+ConvertBytes(AWorkCount)+' / '+ConvertBytes(real_max);
Application.ProcessMessages;

end;

procedure TfrmDownloader.IdHTTP1WorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
//img_pb.Left := (0 - img_pb.Width);
pb_max := img_track.Width;// + (img_pb.Width);
pb_perc := pb_max div 100;

real_max := AWorkCountMax;
real_perc := real_max div 100;

lbl_Status.Caption := 'Downloading... 0 / '+ConvertBytes(real_max);

Application.ProcessMessages;
end;

procedure TfrmDownloader.IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
img_pb.Left := img_track.Width - img_pb.Width;

lbl_Status.Caption := 'Download complete! '+ConvertBytes(real_max);
Application.ProcessMessages;
end;

procedure TfrmDownloader.shape_titlebarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

end.
