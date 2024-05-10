object frmLauncher: TfrmLauncher
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 240
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = 'OpenLoco Launcher'
  ClientHeight = 515
  ClientWidth = 804
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnShow = FormShow
  DesignSize = (
    804
    515)
  PixelsPerInch = 96
  TextHeight = 19
  object shape_window_frame: TShape
    Left = 0
    Top = 33
    Width = 804
    Height = 482
    Align = alClient
    Brush.Style = bsClear
    Pen.Color = 3563052
    Pen.Width = 2
    OnMouseDown = panel_titlebarMouseDown
    ExplicitTop = 0
    ExplicitWidth = 1204
    ExplicitHeight = 600
  end
  object img_BG: TImage
    AlignWithMargins = True
    Left = 2
    Top = 33
    Width = 800
    Height = 480
    Margins.Left = 2
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Center = True
    Proportional = True
    Transparent = True
    ExplicitLeft = -3
    ExplicitTop = 34
    ExplicitWidth = 863
    ExplicitHeight = 559
  end
  object lbl_cur_ver: TLabel
    Left = 26
    Top = 457
    Width = 199
    Height = 19
    Anchors = [akLeft, akBottom]
    Caption = 'Current version: UNKNOWN'
    ExplicitTop = 576
  end
  object img_logo: TImage
    Left = 2
    Top = 0
    Width = 200
    Height = 200
    Proportional = True
    Transparent = True
  end
  object lbl_locomotion_path: TLabel
    Left = 728
    Top = 457
    Width = 39
    Height = 19
    Anchors = [akRight, akBottom]
    Caption = 'check'
    ExplicitLeft = 888
    ExplicitTop = 576
  end
  object lbl_locomotion_path1: TLabel
    Left = 547
    Top = 457
    Width = 183
    Height = 19
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = 'Locomotion path check... '
    ExplicitLeft = 707
    ExplicitTop = 576
  end
  object lbl_latest_ver: TLabel
    Left = 26
    Top = 432
    Width = 184
    Height = 19
    Anchors = [akLeft, akBottom]
    Caption = 'Latest version: checking...'
  end
  object img_train: TImage
    Left = -458
    Top = 476
    Width = 495
    Height = 30
    Anchors = [akLeft, akBottom]
  end
  object img_train_tracks: TImage
    Left = 2
    Top = 505
    Width = 960
    Height = 7
    Anchors = [akLeft, akBottom]
    ExplicitTop = 627
  end
  object btn_Play: TShuImgBtn
    Left = 203
    Top = 344
    Width = 440
    Height = 50
    Enabled = True
    OnClick = btn_PlayClick
    Caption = 'Play'
    CaptionShow = True
    CaptionPen.Color = clGreen
    CaptionPen.Style = psClear
    CaptionBrush.Color = clYellow
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -21
    CaptionFont.Name = 'Onesize'
    CaptionFont.Style = []
    CaptionFont.Quality = fqNonAntialiased
  end
  object btn_options: TShuImgBtn
    Left = 576
    Top = 39
    Width = 220
    Height = 25
    Enabled = True
    OnClick = btn_optionsClick
    Caption = 'Options'
    CaptionShow = True
    CaptionPen.Style = psClear
    CaptionPen.Width = 0
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -16
    CaptionFont.Name = 'Onesize'
    CaptionFont.Style = []
  end
  object btn_launcher_update: TShuImgBtn
    Left = 576
    Top = 66
    Width = 220
    Height = 25
    Enabled = True
    Visible = False
    OnClick = btn_launcher_updateClick
    Caption = 'Update launcher'
    CaptionShow = True
    CaptionPen.Style = psClear
    CaptionPen.Width = 0
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -16
    CaptionFont.Name = 'Onesize'
    CaptionFont.Style = []
  end
  object btnUpdateOpenLoco: TShuImgBtn
    Left = 307
    Top = 400
    Width = 220
    Height = 25
    Enabled = True
    OnClick = btn_dl_openlocoClick
    Caption = 'Update OpenLoco'
    CaptionShow = True
    CaptionPen.Style = psClear
    CaptionPen.Width = 0
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -16
    CaptionFont.Name = 'Onesize'
    CaptionFont.Style = []
  end
  object panel_titlebar: TPanel
    Left = 0
    Top = 0
    Width = 804
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Caption = 'OpenLoco Launcher'
    ParentBackground = False
    TabOrder = 0
    OnMouseDown = panel_titlebarMouseDown
    DesignSize = (
      804
      33)
    object shape_titlebar: TShape
      Left = 0
      Top = 0
      Width = 804
      Height = 35
      Anchors = [akLeft, akTop, akRight]
      Brush.Color = 4418357
      Pen.Color = 3563052
      Pen.Width = 2
      OnMouseDown = panel_titlebarMouseDown
      ExplicitWidth = 1200
    end
    object label_title: TLabel
      Left = 96
      Top = 8
      Width = 616
      Height = 19
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'OpenLoco Launcher'
      Layout = tlCenter
      OnMouseDown = panel_titlebarMouseDown
      ExplicitWidth = 711
    end
    object img_logo_title: TImage
      Left = 2
      Top = 0
      Width = 200
      Height = 200
      Proportional = True
      Transparent = True
      OnMouseDown = panel_titlebarMouseDown
    end
    object btn_close: TShuImgBtn
      Left = 752
      Top = 2
      Width = 50
      Height = 31
      Hint = 'Exit launcher'
      Anchors = [akTop, akRight]
      AutoSize = True
      Enabled = True
      ParentShowHint = False
      ShowHint = True
      OnClick = btn_titlebar_closeClick
      Caption = 'X'
      CaptionShow = True
      CaptionBrush.Color = clYellow
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -21
      CaptionFont.Name = 'Onesize'
      CaptionFont.Style = [fsBold]
    end
    object btn_minimize: TShuImgBtn
      Left = 702
      Top = 2
      Width = 50
      Height = 31
      Hint = 'Minimize launcher'
      Anchors = [akTop, akRight]
      AutoSize = True
      Enabled = True
      ParentShowHint = False
      ShowHint = True
      OnClick = btn_titlebar_minimizeClick
      Caption = '-'
      CaptionShow = True
      CaptionPen.Style = psClear
      CaptionPen.Width = 0
      CaptionBrush.Color = clYellow
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clYellow
      CaptionFont.Height = -16
      CaptionFont.Name = 'Onesize'
      CaptionFont.Style = [fsBold]
    end
  end
  object Button1: TButton
    Left = 8
    Top = 290
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    Visible = False
    OnClick = Button1Click
  end
  object panel_no_openloco: TPanel
    Left = 54
    Top = 41
    Width = 480
    Height = 227
    BevelOuter = bvNone
    Caption = 'OpenLoco not found'
    TabOrder = 2
    Visible = False
    DesignSize = (
      480
      227)
    object Shape1: TShape
      Left = 0
      Top = 0
      Width = 480
      Height = 25
      Align = alTop
      Brush.Color = 176
      Pen.Color = clMaroon
      Pen.Width = 2
      ExplicitWidth = 329
    end
    object Label1: TLabel
      Left = 5
      Top = 2
      Width = 469
      Height = 19
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'OpenLoco not found!'
      Layout = tlCenter
    end
    object Shape2: TShape
      Left = 0
      Top = 25
      Width = 480
      Height = 202
      Margins.Top = 20
      Align = alClient
      Brush.Color = 10855889
      Pen.Color = clMaroon
      Pen.Width = 2
    end
    object Label2: TLabel
      Left = 20
      Top = 45
      Width = 440
      Height = 101
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 
        'Launcher was unable to locate OpenLoco. '#13#10#13#10'Use the download but' +
        'ton to download the latest version from Github.'
      WordWrap = True
    end
    object btn_dl_openloco: TShuImgBtn
      Left = 20
      Top = 152
      Width = 440
      Height = 50
      Enabled = True
      OnClick = btn_dl_openlocoClick
      Caption = 'Download OpenLoco'
      CaptionShow = True
      CaptionPen.Color = clGreen
      CaptionPen.Style = psClear
      CaptionBrush.Color = clYellow
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -21
      CaptionFont.Name = 'Onesize'
      CaptionFont.Style = []
    end
  end
  object panel_no_locomotion: TPanel
    Left = 702
    Top = 198
    Width = 480
    Height = 227
    BevelOuter = bvNone
    Caption = 'OpenLoco not found'
    TabOrder = 3
    Visible = False
    DesignSize = (
      480
      227)
    object Shape3: TShape
      Left = 0
      Top = 0
      Width = 480
      Height = 25
      Align = alTop
      Brush.Color = 176
      Pen.Color = clMaroon
      Pen.Width = 2
      ExplicitWidth = 329
    end
    object lbl_no_locomotion_title: TLabel
      Left = 5
      Top = 2
      Width = 469
      Height = 19
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Locomotion not found!'
      Layout = tlCenter
    end
    object Shape4: TShape
      Left = 0
      Top = 25
      Width = 480
      Height = 202
      Margins.Top = 20
      Align = alClient
      Brush.Color = 10855889
      Pen.Color = clMaroon
      Pen.Width = 2
    end
    object lbl_no_locomotion_text: TLabel
      Left = 20
      Top = 45
      Width = 440
      Height = 148
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 
        'Launcher was unable to locate your Locomotion install!'#13#10#13#10'OpenLo' +
        'co requires an original installation of Locomotion present on yo' +
        'ur system in order to work.'#13#10#13#10'Please install Locomotion either ' +
        'from GoG or Steam (or CD) before starting the launcher.'
      WordWrap = True
    end
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
    Left = 696
    Top = 136
  end
  object IdHTTP1: TIdHTTP
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
    Left = 696
    Top = 72
  end
  object LocoAnimationTimer: TTimer
    Interval = 16
    OnTimer = LocoAnimationTimerTimer
    Left = 16
    Top = 376
  end
end
