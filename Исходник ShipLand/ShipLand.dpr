program ShipLand;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {MainFormInstance},
  ShipmentForm in 'ShipmentForm.pas' {FormShipment},
  ReportForm in 'ReportForm.pas' {FormReport},
  DataModule1 in 'DataModule1.pas' {DataModule1Instance: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainFormInstance);
  Application.CreateForm(TDataModule1, DataModule1Instance);
  Application.Run;
end.
