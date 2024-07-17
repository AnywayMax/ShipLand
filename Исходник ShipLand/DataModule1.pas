unit DataModule1;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Uni, MemDS, UniProvider,
  SQLiteUniProvider, DBAccess, Dialogs;

type
  TDataModule1 = class(TDataModule)
    UniConnection: TUniConnection;
    SQLTransaction: TUniTransaction;
    QuerySuppliers: TUniQuery;
    QueryProducts: TUniQuery;
    QueryPrices: TUniQuery;
    QueryShipments: TUniQuery;
    QueryShipmentDetails: TUniQuery;
    QueryReport: TUniQuery;
    DataSourceSuppliers: TDataSource;
    DataSourceProducts: TDataSource;
    DataSourcePrices: TDataSource;
    DataSourceShipments: TDataSource;
    DataSourceShipmentDetails: TDataSource;
    DataSourceReport: TDataSource;
    SQLiteUniProvider1: TSQLiteUniProvider;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    procedure ShowQuery(SQLQuery: TUniQuery);
  end;

var
  DataModule1Instance: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses MainForm;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  UniConnection.ProviderName := 'SQLite';
  UniConnection.Database := 'suppliers.db';
  UniConnection.LoginPrompt := False;
  UniConnection.Connected := True;

 // Настройки QueryReport
  QueryReport.Connection := UniConnection;
  QueryReport.Transaction := SQLTransaction;

  // Настройка полей
  QueryReport.FieldDefs.Clear;
  QueryReport.FieldDefs.Add('ShipmentID', ftInteger);
  QueryReport.FieldDefs.Add('SupplierName', ftString, 50);
  QueryReport.FieldDefs.Add('ShipmentDate', ftString, 50);
  QueryReport.FieldDefs.Add('ProductName', ftString, 50);
  QueryReport.FieldDefs.Add('ProductType', ftString, 50);
  QueryReport.FieldDefs.Add('Quantity', ftFloat);
  QueryReport.FieldDefs.Add('Price', ftFloat);
  QueryReport.FieldDefs.Add('Total', ftFloat);

  QueryReport.Open;

  // Настройки DataSource
  DataSourceReport.DataSet := QueryReport;
end;


procedure TDataModule1.ShowQuery(SQLQuery: TUniQuery);
var
  i: Integer;
  ParamsText: string;
begin
  if DebugMode then
  begin
    ParamsText := '';
    for i := 0 to SQLQuery.Params.Count - 1 do
    begin
      ParamsText := ParamsText + Format('%s = %s', [SQLQuery.Params[i].Name, SQLQuery.Params[i].AsString]) + sLineBreak;
    end;
    ShowMessage('SQL-запрос: ' + SQLQuery.SQL.Text + sLineBreak + 'Параметры: ' + sLineBreak + ParamsText);
  end;
end;

end.
