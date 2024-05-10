object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmOptions'
  ClientHeight = 415
  ClientWidth = 669
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    669
    415)
  PixelsPerInch = 96
  TextHeight = 13
  object shape_titlebar: TShape
    Left = 0
    Top = 0
    Width = 669
    Height = 35
    Align = alTop
    Brush.Color = 5460799
    Pen.Color = 6776659
    Pen.Width = 2
    OnMouseDown = shape_titlebarMouseDown
    ExplicitLeft = -223
    ExplicitWidth = 868
  end
  object Shape2: TShape
    Left = 0
    Top = 35
    Width = 669
    Height = 380
    Align = alClient
    Brush.Color = 15180635
    Pen.Color = 6776659
    Pen.Width = 3
    ExplicitLeft = -223
    ExplicitWidth = 868
    ExplicitHeight = 201
  end
  object btn_close: TShuImgBtn
    Left = 617
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
    ExplicitLeft = 609
  end
  object label_title: TLabel
    Left = 8
    Top = 4
    Width = 601
    Height = 29
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Options - OpenLoco Launcher'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -16
    Font.Name = 'Onesize'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    OnMouseDown = shape_titlebarMouseDown
    ExplicitWidth = 593
  end
  object btn_save: TShuImgBtn
    Left = 453
    Top = 361
    Width = 200
    Height = 40
    Anchors = [akLeft, akBottom]
    Enabled = True
    OnClick = btn_saveClick
    Caption = 'Save'
    CaptionShow = True
    CaptionPen.Style = psClear
    CaptionPen.Width = 0
    CaptionBrush.Color = clYellow
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -21
    CaptionFont.Name = 'Onesize'
    CaptionFont.Style = []
    ExplicitTop = 398
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 184
    Width = 637
    Height = 153
    Caption = ' OpenLoco options '
    Color = 15180635
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Onesize'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      637
      153)
    object chk_openloco_intro_enabled: TCheckBox
      Left = 24
      Top = 24
      Width = 597
      Height = 25
      Cursor = crHandPoint
      Hint = 
        'If enabled, when starting OpenLoco it will show the original Loc' +
        'omotion startup screens'
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Show the game intro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object chk_openloco_override_loglevel: TCheckBox
      Left = 24
      Top = 87
      Width = 597
      Height = 25
      Cursor = crHandPoint
      Hint = 
        'By enabling this option you can change what information OpenLoco' +
        ' will log.'
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Override log level (default: info, warning, error)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object chk_openloco_log_info: TCheckBox
      Left = 24
      Top = 118
      Width = 130
      Height = 17
      Cursor = crHandPoint
      Alignment = taLeftJustify
      Caption = 'Info . . . . . . .'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object chk_openloco_log_warning: TCheckBox
      Left = 176
      Top = 118
      Width = 130
      Height = 17
      Cursor = crHandPoint
      Alignment = taLeftJustify
      Caption = 'Warning . . .'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object chk_openloco_log_error: TCheckBox
      Left = 336
      Top = 118
      Width = 130
      Height = 17
      Cursor = crHandPoint
      Alignment = taLeftJustify
      Caption = 'Error . . . . .'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object chk_openloco_log_verbose: TCheckBox
      Left = 491
      Top = 118
      Width = 130
      Height = 17
      Cursor = crHandPoint
      Alignment = taLeftJustify
      Caption = 'Verbose . . .'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object chk_openloco_minimized: TCheckBox
      Left = 24
      Top = 55
      Width = 597
      Height = 25
      Cursor = crHandPoint
      Hint = 
        'If enabled, when starting OpenLoco, the console window will be m' +
        'inimized by default'
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Start with the console hidden'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 56
    Width = 637
    Height = 105
    Caption = ' Launcher options '
    Color = 15180635
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Onesize'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      637
      105)
    object lbl_time_autostart: TLabel
      Left = 24
      Top = 55
      Width = 549
      Height = 28
      Hint = 
        'How long will the launcher wait before automatically starting th' +
        'e game'
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Time in seconds before automatically starting the game'
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
      ExplicitWidth = 513
    end
    object chk_autostart: TCheckBox
      Left = 24
      Top = 24
      Width = 597
      Height = 25
      Cursor = crHandPoint
      Hint = 
        'If enabled, the launcher will automatically start the game if th' +
        'ere are no updates available (will apply next time you start)'
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Automatically start OpenLoco if no updates available'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object edit_time_autostart: TSpinEdit
      Left = 579
      Top = 55
      Width = 41
      Height = 28
      Anchors = [akTop, akRight]
      MaxValue = 60
      MinValue = 1
      TabOrder = 1
      Value = 5
    end
  end
end
