object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1043#1083#1072#1074#1085#1086#1077' '#1084#1077#1085#1102
  ClientHeight = 210
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonShipment: TButton
    Left = 50
    Top = 50
    Width = 300
    Height = 50
    Caption = #1055#1088#1080#1077#1084#1082#1072' '#1087#1086#1089#1090#1072#1074#1086#1082
    TabOrder = 0
    OnClick = ButtonShipmentClick
  end
  object ButtonReport: TButton
    Left = 50
    Top = 120
    Width = 300
    Height = 50
    Caption = #1043#1077#1085#1077#1088#1072#1094#1080#1103' '#1086#1090#1095#1077#1090#1086#1074
    TabOrder = 1
    OnClick = ButtonReportClick
  end
  object CheckBoxDebug: TCheckBox
    Left = 8
    Top = 8
    Width = 121
    Height = 17
    Caption = #1044#1077#1073#1072#1075'-'#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
    TabOrder = 2
    OnClick = CheckBoxDebugClick
  end
end
