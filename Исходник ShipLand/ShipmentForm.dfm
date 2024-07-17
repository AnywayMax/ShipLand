object FormShipment: TFormShipment
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1055#1088#1080#1077#1084#1082#1072' '#1087#1086#1089#1090#1072#1074#1086#1082
  ClientHeight = 446
  ClientWidth = 602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 20
    Width = 57
    Height = 13
    Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
  end
  object Label2: TLabel
    Left = 20
    Top = 60
    Width = 26
    Height = 13
    Caption = #1044#1072#1090#1072
  end
  object lbCurrentOrder: TLabel
    Left = 20
    Top = 279
    Width = 162
    Height = 13
    Caption = #1057#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1087#1086#1089#1090#1072#1074#1082#1080
  end
  object ComboBoxSuppliers: TComboBox
    Left = 150
    Top = 20
    Width = 400
    Height = 21
    Style = csDropDownList
    TabOrder = 0
    OnChange = ComboBoxSuppliersChange
  end
  object DateTimePicker: TDateTimePicker
    Left = 150
    Top = 60
    Width = 400
    Height = 21
    Date = 45488.559706400460000000
    Format = 'dd.MM.yyyy'
    Time = 45488.559706400460000000
    TabOrder = 1
  end
  object DBGridProducts: TDBGrid
    Left = 20
    Top = 100
    Width = 560
    Height = 133
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ButtonAddProduct: TButton
    Left = 20
    Top = 248
    Width = 200
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1088#1086#1076#1091#1082#1090
    TabOrder = 3
    OnClick = ButtonAddProductClick
  end
  object ButtonSaveShipment: TButton
    Left = 380
    Top = 248
    Width = 200
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1086#1089#1090#1072#1074#1082#1091
    TabOrder = 4
    OnClick = ButtonSaveShipmentClick
  end
  object DBGridAddedProducts: TDBGrid
    Left = 20
    Top = 298
    Width = 559
    Height = 107
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ButtonClearShipment: TButton
    Left = 20
    Top = 413
    Width = 560
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1089#1090#1072#1074#1082#1091
    TabOrder = 6
    OnClick = ButtonClearShipmentClick
  end
end
