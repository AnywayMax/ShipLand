unit MainForm;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    ButtonShipment: TButton;
    ButtonReport: TButton;
    CheckBoxDebug: TCheckBox;
    procedure ButtonShipmentClick(Sender: TObject);
    procedure ButtonReportClick(Sender: TObject);
    procedure CheckBoxDebugClick(Sender: TObject);
  end;

var
  MainFormInstance: TMainForm;
  DebugMode: Boolean = False;

implementation

{$R *.dfm}

uses
  ShipmentForm, ReportForm;

procedure TMainForm.ButtonShipmentClick(Sender: TObject);
begin
  FormShipment := TFormShipment.Create(Self);
  try
    FormShipment.ShowModal;
  finally
    FormShipment.Free;
  end;
end;

procedure TMainForm.CheckBoxDebugClick(Sender: TObject);
begin
  DebugMode := CheckBoxDebug.Checked;
end;

procedure TMainForm.ButtonReportClick(Sender: TObject);
begin
  FormReport := TFormReport.Create(Self);
  try
    FormReport.ShowModal;
  finally
    FormReport.Free;
  end;
end;

end.

