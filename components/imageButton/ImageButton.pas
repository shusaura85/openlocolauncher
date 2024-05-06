unit ImageButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Vcl.Imaging.pngimage;

type
  TShuImgBtnState = (bsUp, bsDown, bsHover, bsDisabled);

type
  TShuImgBtn = class(TImage)
  private
    { Private declarations }
    DBOverPict: TPicture;
    DBDownPict: TPicture;
    DBUpPict:   TPicture;
    DBDisPict:  TPicture;

    FEnabled: Boolean;

    FInit: boolean;
    FBtnState: TShuImgBtnState;

    FCaption: string;
    FCaptionShow: boolean;
    FCaptionPen: TPen;
    FCaptionBrush: TBrush;
    FCaptionFont: TFont;

    procedure SetDownPict(Value: TPicture);
    procedure SetOverPict(Value: TPicture);
    procedure SetUpPict(Value: TPicture);
    procedure SetDisPict(Value: TPicture);

    procedure SetBtnState(Value: TShuImgBtnState);

    procedure SetCaption(Value: string);
    procedure SetCaptionShow(Value: boolean);
    procedure SetCaptionPen(Value: TPen);
    procedure SetCaptionBrush(Value: TBrush);
    procedure SetCaptionFont(Value: TFont);
  protected
    procedure MsgMouseEnter(var Message: TMessage); message CM_MouseEnter;
    procedure MsgMouseLeave(var Message: TMessage); message CM_MouseLeave;

    procedure Paint; override;

    procedure PaintCaption;

  public
    { Public declarations }
    procedure UpdateImgBtn;

    procedure SetEnabled(Value: Boolean);  override;

    procedure LoadPNGFromResource(ResName: string; forState: TShuImgBtnState);

    constructor Create(AOwner: TComponent); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
                      override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property PictureUp: TPicture read DBUpPict write SetUpPict;
    property PictureDown: TPicture read DBDownPict write SetDownPict;
    property PictureHover: TPicture read DBOverPict write SetOverPict;
    property PictureDisabled: TPicture read DBDisPict write SetDisPict;
    property Enabled: Boolean read FEnabled write SetEnabled;

    property State: TShuImgBtnState read FBtnState;

    property Caption: string read FCaption write SetCaption;
    property CaptionShow: boolean read FCaptionShow write SetCaptionShow;
    property CaptionPen: TPen read FCaptionPen write SetCaptionPen;
    property CaptionBrush: TBrush read FCaptionBrush write SetCaptionBrush;
    property CaptionFont: TFont read FCaptionFont write SetCaptionFont;
  end;

procedure Register;

implementation

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


procedure Register;
begin
  RegisterComponents('Shu', [TShuImgBtn]);
end;

procedure TShuImgBtn.SetEnabled(Value: Boolean);
begin
 if Value = True then SetBtnState(bsUp) //Picture:=DBUpPict
                 else SetBtnState(bsDisabled); //Picture:=DBDisPict;

 FEnabled := Value;
 UpdateImgbtn;
end;

procedure TShuImgBtn.LoadPNGFromResource(ResName: string; forState: TShuImgBtnState);
Var
  rs: TResourceStream;
Begin
  rs := TResourceStream.Create(0, ResName, 'PNG');
  Try
    case forState of
      bsUp: DBUpPict.LoadFromStream(rs);
      bsDown: DBDownPict.LoadFromStream(rs);
      bsHover: DBOverPict.LoadFromStream(rs);
      bsDisabled: DBDisPict.LoadFromStream(rs);
    end;
  Finally
    rs.Free;
  End;
end;

constructor TShuImgBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 100;
  Height := 30;
  DBOverPict := TPicture.Create;
  DBDownPict := TPicture.Create;
  DBUpPict := TPicture.Create;
  DBDisPict := TPicture.Create;
  Picture := DBUpPict;

//  Down := False;


  FEnabled := true;
  SetEnabled(Enabled);

  FInit := false;
  FBtnState := bsUp;

  FCaption := '';
  FCaptionShow := false;

  FCaptionPen := TPen.Create;
  FCaptionBrush := TBrush.Create;
  FCaptionFont := TFont.Create;

  UpdateImgBtn;
end;

procedure TShuImgBtn.SetUpPict(Value: TPicture);
begin
  DBUpPict.Assign(Value);
  Picture.Assign(Value);
  UpdateImgBtn;
end;

procedure TShuImgBtn.SetDownPict(Value: TPicture);
begin
  DBDownPict.Assign(Value);
end;

procedure TShuImgBtn.SetOverPict(Value: TPicture);
begin
  DBOverPict.Assign(Value);
end;

procedure TShuImgBtn.SetDisPict(Value: TPicture);
begin
  DBDisPict.Assign(Value);
end;

procedure TShuImgBtn.SetBtnState(Value: TShuImgBtnState);
begin
  FBtnState := Value;
//  UpdateImgBtn;
end;

procedure TShuImgBtn.SetCaption(Value: string);
begin
  FCaption := Value;
  UpdateImgBtn;
end;

procedure TShuImgBtn.SetCaptionShow(Value: Boolean);
begin
  FCaptionShow := Value;
  UpdateImgBtn;
end;

procedure TShuImgBtn.SetCaptionPen(Value: TPen);
begin
  FCaptionPen.Assign(Value);
  UpdateImgBtn;
end;

procedure TShuImgBtn.SetCaptionBrush(Value: TBrush);
begin
  FCaptionBrush.Assign(Value);
  UpdateImgBtn;
end;

procedure TShuImgBtn.SetCaptionFont(Value: TFont);
begin
  FCaptionFont.Assign(Value);
  UpdateImgBtn;
end;

procedure TShuImgBtn.MsgMouseEnter(var Message: TMessage);
begin
  if FEnabled = True then
     begin
     SetBtnState(bsHover);
     //Picture := PictureHover;
     UpdateImgBtn;
     end;
end;

procedure TShuImgBtn.MsgMouseLeave(var Message: TMessage);
begin
  if FEnabled = True then
     begin
     SetBtnState(bsUp);
     //Picture := PictureUp;
     UpdateImgBtn;
     end;
end;


procedure TShuImgBtn.UpdateImgBtn;
begin
case FBtnState of
  bsUp: Picture := PictureUp;
  bsDown: Picture := PictureDown;
  bsHover: Picture := PictureHover;
  bsDisabled: Picture := PictureDisabled;
end;

PaintCaption;
end;


procedure TShuImgBtn.Paint;
begin
if not FInit then
   begin
   UpdateImgbtn;
   FInit := true;
   end;

inherited Paint;
end;

procedure TShuImgBtn.PaintCaption;
var x, y, w: Integer;
begin
if FCaptionShow then
   begin
   if not (Picture.Graphic is TPngImage) then exit;

   with (Picture.Graphic as TPngImage) do
        begin
        Canvas.Font.Assign(CaptionFont);// := FCaptionFont;
        Canvas.Brush.Assign(CaptionBrush); // := FCaptionBrush;
        Canvas.Pen.Assign(CaptionPen); // := FCaptionPen;

        // this ensures that no matter what font settings are used, the text is centered
        w := Canvas.TextWidth(FCaption);
        x := (Width div 2) - (w div 2);
        y := (Height div 2) - (Canvas.TextHeight(FCaption) div 2);
        DrawTextOutline(Canvas, x, y, FCaption);
     end;
   end;
end;

procedure TShuImgBtn.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
 inherited;
 if (FEnabled = True) and (FBtnState = bsUp) then
  if (X<0)or(X>Width)or(Y<0)or(Y>Height) then
  begin
    SetCaptureControl(Self);
    SetBtnState(bsUp);
//    Picture := DBUpPict;
    UpdateImgBtn;
   end;
end;

procedure TShuImgBtn.MouseDown(Button: TMouseButton; Shift: TShiftState;
                                 X, Y: Integer);
begin
 if (Button = mbLeft) and (FEnabled = True) then
  begin
   SetBtnState(bsDown);
//   Picture := PictureDown;
//   Down:=True;
   UpdateImgBtn;
  end;
 inherited MouseDown(Button, Shift, X, Y);
end;

procedure TShuImgBtn.MouseUp(Button: TMouseButton; Shift: TShiftState;
     X, Y: Integer);
begin
 if (Button = mbLeft) and (FEnabled = True) then
  begin
   SetBtnState(bsHover);
   //Picture := PictureHover; //Normal;
   SetCaptureControl(nil);
   UpdateImgBtn;
  end;
 inherited  MouseUp(Button, Shift, X, Y);
// Down:=False;
end;

destructor TShuImgBtn.Destroy;
begin
  DBDownPict.Free;
  DBOverPict.Free;
  DBUpPict.Free;
  DBDisPict.Free;

  FCaptionFont.Free;
  FCaptionPen.Free;
  FCaptionBrush.Free;


  inherited Destroy;
end;

end.
 