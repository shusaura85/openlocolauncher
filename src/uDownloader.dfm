object frmDownloader: TfrmDownloader
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'OpenLoco Downloader'
  ClientHeight = 236
  ClientWidth = 868
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    868
    236)
  PixelsPerInch = 96
  TextHeight = 25
  object Shape2: TShape
    Left = 0
    Top = 35
    Width = 868
    Height = 201
    Align = alClient
    Brush.Color = 9748868
    Pen.Color = 4418357
    Pen.Width = 3
    ExplicitLeft = 208
    ExplicitTop = 216
    ExplicitWidth = 65
    ExplicitHeight = 65
  end
  object shape_titlebar: TShape
    Left = 0
    Top = 0
    Width = 868
    Height = 35
    Align = alTop
    Brush.Color = 4418357
    Pen.Color = 3563052
    Pen.Width = 2
    OnMouseDown = shape_titlebarMouseDown
    ExplicitTop = -10
    ExplicitWidth = 862
  end
  object btn_close: TShuImgBtn
    Left = 815
    Top = 2
    Width = 50
    Height = 31
    Hint = 'Exit launcher'
    Anchors = [akTop, akRight]
    AutoSize = True
    Enabled = True
    ParentShowHint = False
    ShowHint = True
    OnClick = btn_closeClick
    Caption = 'X'
    CaptionShow = True
    CaptionBrush.Color = clYellow
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -21
    CaptionFont.Name = 'Onesize'
    CaptionFont.Style = [fsBold]
    ExplicitLeft = 809
  end
  object label_title: TLabel
    Left = 8
    Top = 6
    Width = 801
    Height = 26
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'OpenLoco Downloader'
    Layout = tlCenter
    OnMouseDown = shape_titlebarMouseDown
    ExplicitWidth = 795
  end
  object lbl_status: TLabel
    Left = 16
    Top = 56
    Width = 58
    Height = 25
    Caption = 'Status'
  end
  object img_pbe: TImage
    Left = -443
    Top = 190
    Width = 495
    Height = 30
  end
  object lbl_extract_status: TLabel
    Left = 16
    Top = 148
    Width = 130
    Height = 25
    Caption = 'Extract Status'
  end
  object img_track: TImage
    Left = 2
    Top = 123
    Width = 863
    Height = 7
  end
  object img_tracke: TImage
    Left = 2
    Top = 219
    Width = 863
    Height = 7
  end
  object img_pb: TImage
    Left = -449
    Top = 94
    Width = 495
    Height = 30
  end
  object IdHTTP1: TIdHTTP
    OnStatus = IdHTTP1Status
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    OnWork = IdHTTP1Work
    OnWorkBegin = IdHTTP1WorkBegin
    OnWorkEnd = IdHTTP1WorkEnd
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.CacheControl = 'no-cache'
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; OpenLoco Launcher)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams, hoNoProtocolErrorException]
    Left = 808
    Top = 56
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 808
    Top = 136
  end
  object DownloadTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = DownloadTimerTimer
    Left = 736
    Top = 56
  end
  object ExtractTimer: TTimer
    Enabled = False
    Interval = 1500
    OnTimer = ExtractTimerTimer
    Left = 656
    Top = 56
  end
  object CloseTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = CloseTimerTimer
    Left = 576
    Top = 56
  end
end
