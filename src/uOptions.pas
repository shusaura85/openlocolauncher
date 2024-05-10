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
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBox7: TCheckBox;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    btn_save: TShuImgBtn;
    procedure FormCreate(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure shape_titlebarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
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

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
Font.Assign(frmLauncher.Font);

btn_close.LoadPNGFromResource('BTN_TB_UP', bsUp);
btn_close.LoadPNGFromResource('BTN_TB_DOWN', bsDown);
btn_close.LoadPNGFromResource('BTN_TB_HOVER', bsHover);

btn_save.LoadPNGFromResource('BTN_MD_UP', bsUp);
btn_save.LoadPNGFromResource('BTN_MD_DOWN', bsDown);
btn_save.LoadPNGFromResource('BTN_MD_HOVER', bsHover);
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
