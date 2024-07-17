object FormReport: TFormReport
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1054#1090#1095#1077#1090#1099
  ClientHeight = 381
  ClientWidth = 766
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
  object Label1: TLabel
    Left = 20
    Top = 20
    Width = 83
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
  end
  object Label2: TLabel
    Left = 20
    Top = 60
    Width = 77
    Height = 13
    Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
  end
  object DateTimePickerStart: TDateTimePicker
    Left = 150
    Top = 20
    Width = 587
    Height = 21
    Date = 45488.562104861110000000
    Format = 'dd.MM.yyyy'
    Time = 45488.562104861110000000
    TabOrder = 0
  end
  object DateTimePickerEnd: TDateTimePicker
    Left = 150
    Top = 60
    Width = 587
    Height = 21
    Date = 45488.562105034730000000
    Format = 'dd.MM.yyyy'
    Time = 45488.562105034730000000
    TabOrder = 1
  end
  object ButtonGenerateReport: TButton
    Left = 20
    Top = 100
    Width = 717
    Height = 25
    Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1095#1077#1090
    TabOrder = 2
    OnClick = ButtonGenerateReportClick
  end
  object DBGridReport: TDBGrid
    Left = 20
    Top = 140
    Width = 717
    Height = 220
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
