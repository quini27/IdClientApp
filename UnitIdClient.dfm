object FormIdClient: TFormIdClient
  Left = 0
  Top = 0
  Caption = 'Indy Client'
  ClientHeight = 322
  ClientWidth = 869
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LedSha2: TShape
    Left = 565
    Top = 37
    Width = 22
    Height = 22
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Brush.Color = clGray
    Pen.Color = clGray
    Shape = stCircle
  end
  object TitleLabel: TLabel
    Left = 24
    Top = 8
    Width = 222
    Height = 19
    Caption = 'VCL Indy Client Application'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelConn: TLabel
    Left = 520
    Top = 72
    Width = 101
    Height = 16
    Caption = 'Connection status'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LedShape: TShape
    Left = 568
    Top = 40
    Width = 16
    Height = 16
    Brush.Color = clMaroon
    Shape = stCircle
  end
  object Mess2SendLabel: TLabel
    Left = 32
    Top = 120
    Width = 96
    Height = 16
    Caption = 'Message to send'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 24
    Top = 33
    Width = 93
    Height = 13
    Caption = 'Client disconnected'
  end
  object connect_btn: TButton
    Left = 149
    Top = 57
    Width = 97
    Height = 41
    Caption = 'Connect'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = connect_btnClick
  end
  object disconnect_btn: TButton
    Left = 261
    Top = 57
    Width = 97
    Height = 41
    Caption = 'Disconnect'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = disconnect_btnClick
  end
  object EditMess: TEdit
    Left = 8
    Top = 142
    Width = 761
    Height = 21
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object send_btn: TButton
    Left = 786
    Top = 141
    Width = 75
    Height = 24
    Caption = 'Send Message'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = send_btnClick
  end
  object MemoLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 190
    Width = 863
    Height = 129
    Align = alBottom
    BorderStyle = bsNone
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 4
    OnChange = MemoLogChange
  end
  object setIPbtn: TButton
    Left = 32
    Top = 59
    Width = 97
    Height = 41
    Caption = 'Set IP Address'
    TabOrder = 5
    OnClick = setIPbtnClick
  end
  object IdTCPClient1: TIdTCPClient
    OnDisconnected = IdTCPClient1Disconnected
    OnConnected = IdTCPClient1Connected
    ConnectTimeout = 5000
    Host = '192.168.0.200'
    IPVersion = Id_IPv4
    Port = 100
    ReadTimeout = 50000
    Left = 736
    Top = 40
  end
end
