object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmOptions'
  ClientHeight = 452
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
    452)
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
    Height = 417
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
    Top = 398
    Width = 200
    Height = 40
    Enabled = True
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
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 264
    Width = 637
    Height = 121
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
      121)
    object CheckBox1: TCheckBox
      Left = 24
      Top = 24
      Width = 597
      Height = 25
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Run the game intro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 561
    end
    object CheckBox2: TCheckBox
      Left = 24
      Top = 55
      Width = 597
      Height = 25
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Override log level (default: info, warning, error)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitWidth = 561
    end
    object CheckBox3: TCheckBox
      Left = 24
      Top = 86
      Width = 130
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Info'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 176
      Top = 86
      Width = 130
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Warning'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object CheckBox5: TCheckBox
      Left = 336
      Top = 86
      Width = 130
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Error'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object CheckBox6: TCheckBox
      Left = 491
      Top = 86
      Width = 130
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Verbose'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 56
    Width = 637
    Height = 169
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
      169)
    object Label1: TLabel
      Left = 24
      Top = 55
      Width = 549
      Height = 28
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Time in seconds before automatically starting the game'
      Layout = tlCenter
      ExplicitWidth = 513
    end
    object CheckBox7: TCheckBox
      Left = 24
      Top = 24
      Width = 597
      Height = 25
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Automatically start OpenLoco if no updates available'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Onesize'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 561
    end
    object SpinEdit1: TSpinEdit
      Left = 579
      Top = 55
      Width = 41
      Height = 28
      Anchors = [akTop, akRight]
      MaxValue = 60
      MinValue = 1
      TabOrder = 1
      Value = 5
      ExplicitLeft = 543
    end
  end
end
