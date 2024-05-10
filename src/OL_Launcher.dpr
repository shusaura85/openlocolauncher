program OL_Launcher;







{$R *.dres}

uses
  Vcl.Forms,
  uLauncher in 'uLauncher.pas' {frmLauncher},
  gfx_utils in 'inc\gfx_utils.pas',
  paths in 'inc\paths.pas',
  superdate in 'inc\superobject\superdate.pas',
  superdbg in 'inc\superobject\superdbg.pas',
  superobject in 'inc\superobject\superobject.pas',
  supertimezone in 'inc\superobject\supertimezone.pas',
  supertypes in 'inc\superobject\supertypes.pas',
  server_handling in 'inc\server_handling.pas',
  uDownloader in 'uDownloader.pas' {frmDownloader},
  uOptions in 'uOptions.pas' {frmOptions};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLauncher, frmLauncher);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.Run;
end.
