unit gfx_utils;

interface

uses
  Windows, Messages, Dialogs, Types, Variants, SysUtils, Classes, IniFiles, System.UITypes,
  Vcl.ExtCtrls, Vcl.Graphics, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

Type
  TImageResHelper = Class Helper For TPicture
    Procedure LoadFromPNGResourceName(Instance: HInst; Const Name: String);
    Procedure LoadFromJPEGResourceName(Instance: HInst; Const Name: String);
  End;

implementation

Procedure TImageResHelper.LoadFromPNGResourceName(Instance: HInst; Const Name: String);
Var
  rs: TResourceStream;
Begin
  rs := TResourceStream.Create(Instance, PChar(Name), 'PNG');
  Try
    LoadFromStream(rs);
  Finally
    rs.Free;
  End;
End;


Procedure TImageResHelper.LoadFromJPEGResourceName(Instance: HInst; Const Name: String);
Var
  rs: TResourceStream;
Begin
  rs := TResourceStream.Create(Instance, PChar(Name), 'JPEG');
  Try
    LoadFromStream(rs);
  Finally
    rs.Free;
  End;
End;

end.
