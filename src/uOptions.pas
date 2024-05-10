unit uOptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ImageButton, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin;

type
  TfrmOptions = class(TForm)
    label_title: TLabel;
    shape_titlebar: TShape;
    Shape2: TShape;
    btn_close: TShuImgBtn;
    chk_openloco_intro_enabled: TCheckBox;
    GroupBox1: TGroupBox;
    chk_openloco_override_loglevel: TCheckBox;
    chk_openloco_log_info: TCheckBox;
    chk_openloco_log_warning: TCheckBox;
    chk_openloco_log_error: TCheckBox;
    chk_openloco_log_verbose: TCheckBox;
    GroupBox2: TGroupBox;
    chk_autostart: TCheckBox;
    lbl_time_autostart: TLabel;
    edit_time_autostart: TSpinEdit;
    btn_save: TShuImgBtn;
    chk_openloco_minimized: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure shape_titlebarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_saveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

{$R *.dfm}

uses uLauncher;

procedure TfrmOptions.btn_closeClick(Sender: TObject);
begin
Close;
end;

procedure TfrmOptions.btn_saveClick(Sender: TObject);
begin
frmLauncher.cfg.WriteBool('LAUNCHER', 'openloco.autostart.enabled', chk_autostart.Checked);
frmLauncher.cfg.WriteInteger('LAUNCHER', 'openloco.autostart.time', edit_time_autostart.Value);
frmLauncher.cfg.WriteBool('LAUNCHER', 'openloco.intro.enabled', chk_openloco_intro_enabled.Checked);
frmLauncher.cfg.WriteBool('LAUNCHER', 'openloco.console.minimized', chk_openloco_minimized.Checked);
frmLauncher.cfg.WriteBool('LAUNCHER', 'openloco.logs.use_custom', chk_openloco_override_loglevel.Checked);
frmLauncher.cfg.WriteBool('LAUNCHER', 'openloco.logs.info', chk_openloco_log_info.Checked);
frmLauncher.cfg.WriteBool('LAUNCHER', 'openloco.logs.warning', chk_openloco_log_warning.Checked);
frmLauncher.cfg.WriteBool('LAUNCHER', 'openloco.logs.error', chk_openloco_log_error.Checked);
frmLauncher.cfg.WriteBool('LAUNCHER', 'openloco.logs.verbose', chk_openloco_log_verbose.Checked);
frmLauncher.cfg.UpdateFile;
Close;
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
Font.Assign(frmLauncher.Font);

btn_close.LoadPNGFromResource('BTN_TB_UP', bsUp);
btn_close.LoadPNGFromResource('BTN_TB_DOWN', bsDown);
btn_close.LoadPNGFromResource('BTN_TB_HOVER', bsHover);

btn_save.LoadPNGFromResource('BTN_MD_UP', bsUp);
btn_save.LoadPNGFromResource('BTN_MD_DOWN', bsDown);
btn_save.LoadPNGFromResource('BTN_MD_HOVER', bsHover);


chk_autostart.Checked     := frmLauncher.cfg.ReadBool('LAUNCHER', 'openloco.autostart.enabled', false);
edit_time_autostart.Value := frmLauncher.cfg.ReadInteger('LAUNCHER', 'openloco.autostart.time', 5);

chk_openloco_intro_enabled.Checked     := frmLauncher.cfg.ReadBool('LAUNCHER', 'openloco.intro.enabled', false);
chk_openloco_minimized.Checked         := frmLauncher.cfg.ReadBool('LAUNCHER', 'openloco.console.minimized', false);
chk_openloco_override_loglevel.Checked := frmLauncher.cfg.ReadBool('LAUNCHER', 'openloco.logs.use_custom', false);

chk_openloco_log_info.Checked    := frmLauncher.cfg.ReadBool('LAUNCHER', 'openloco.logs.info', true);
chk_openloco_log_warning.Checked := frmLauncher.cfg.ReadBool('LAUNCHER', 'openloco.logs.warning', true);
chk_openloco_log_error.Checked   := frmLauncher.cfg.ReadBool('LAUNCHER', 'openloco.logs.error', true);
chk_openloco_log_verbose.Checked := frmLauncher.cfg.ReadBool('LAUNCHER', 'openloco.logs.verbose', false);

end;

procedure TfrmOptions.shape_titlebarMouseDown(Sender: TObject;
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
