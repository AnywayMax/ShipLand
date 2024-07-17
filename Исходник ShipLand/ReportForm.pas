unit ReportForm;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Data.DB, Dialogs;

type
  TFormReport = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DateTimePickerStart: TDateTimePicker;
    DateTimePickerEnd: TDateTimePicker;
    ButtonGenerateReport: TButton;
    DBGridReport: TDBGrid;
    procedure ButtonGenerateReportClick(Sender: TObject);
  private
    procedure AdjustGridColumnWidths(DBGrid: TDBGrid; DataSet: TDataSet);
    procedure ShowDebugMessage(const Msg: string);
  public
  end;

var
  FormReport: TFormReport;

implementation

{$R *.dfm}

uses
  DataModule1, MainForm;

procedure TFormReport.ButtonGenerateReportClick(Sender: TObject);
begin
    if DateTimePickerStart.Date = 0 then
    begin
      ShowMessage('Пожалуйста, выберите начальную дату');
      Exit;
    end;

    if DateTimePickerEnd.Date = 0 then
    begin
      ShowMessage('Пожалуйста, выберите конечную дату');
      Exit;
    end;

    DataModule1Instance.QueryReport.Close;
    DataModule1Instance.QueryReport.SQL.Text :=
      'SELECT sh.ShipmentID, ' +
      'sp.Name AS SupplierName, ' +
      'sh.Date AS ShipmentDate, ' +
      'p.Name AS ProductName, ' +
      'p.Type AS ProductType, ' +
      'sd.Quantity, pr.Price, ' +
      '(sd.Quantity * pr.Price) AS Total ' +
      'FROM Shipments sh ' +
      'JOIN Suppliers sp ON sh.SupplierID = sp.SupplierID ' +
      'JOIN ShipmentDetails sd ON sh.ShipmentID = sd.ShipmentID ' +
      'JOIN Products p ON sd.ProductID = p.ProductID ' +
      'JOIN Prices pr ON sd.ProductID = pr.ProductID AND pr.SupplierID = sh.SupplierID ' +
      'AND sh.Date BETWEEN pr.StartDate AND pr.EndDate ' +
      'WHERE sh.Date BETWEEN :StartDate AND :EndDate ' +
      'ORDER BY sh.ShipmentID';

    DataModule1Instance.QueryReport.ParamByName('StartDate').AsString := FormatDateTime('yyyy-MM-dd', DateTimePickerStart.Date);
    DataModule1Instance.QueryReport.ParamByName('EndDate').AsString := FormatDateTime('yyyy-MM-dd', DateTimePickerEnd.Date);

    // Отладочный вывод SQL-запроса
    DataModule1Instance.ShowQuery(DataModule1Instance.QueryReport);

    DataModule1Instance.QueryReport.Open;

    // Убедимся, что DBGrid имеет нужное количество столбцов перед их настройкой
    DBGridReport.Columns.Clear;
    DBGridReport.Columns.Add;
    DBGridReport.Columns.Add;
    DBGridReport.Columns.Add;
    DBGridReport.Columns.Add;
    DBGridReport.Columns.Add;
    DBGridReport.Columns.Add;
    DBGridReport.Columns.Add;
    DBGridReport.Columns.Add;

    DBGridReport.Columns[0].Title.Caption := 'ID Поставки';
    DBGridReport.Columns[0].FieldName := 'ShipmentID';
    DBGridReport.Columns[1].Title.Caption := 'Поставщик';
    DBGridReport.Columns[1].FieldName := 'SupplierName';
    DBGridReport.Columns[2].Title.Caption := 'Дата';
    DBGridReport.Columns[2].FieldName := 'ShipmentDate';
    DBGridReport.Columns[3].Title.Caption := 'Название Продукта';
    DBGridReport.Columns[3].FieldName := 'ProductName';
    DBGridReport.Columns[4].Title.Caption := 'Тип';
    DBGridReport.Columns[4].FieldName := 'ProductType';
    DBGridReport.Columns[5].Title.Caption := 'Количество';
    DBGridReport.Columns[5].FieldName := 'Quantity';
    DBGridReport.Columns[6].Title.Caption := 'Цена';
    DBGridReport.Columns[6].FieldName := 'Price';
    DBGridReport.Columns[7].Title.Caption := 'Сумма';
    DBGridReport.Columns[7].FieldName := 'Total';

    DBGridReport.DataSource := DataModule1Instance.DataSourceReport;
    AdjustGridColumnWidths(DBGridReport, DataModule1Instance.QueryReport);
end;

procedure TFormReport.AdjustGridColumnWidths(DBGrid: TDBGrid; DataSet: TDataSet);
var
  i, MaxWidth, TextWidth: Integer;
  Column: TColumn;
  DataField: TField;
begin
  for i := 0 to DBGrid.Columns.Count - 1 do
  begin
    Column := DBGrid.Columns[i];
    if Assigned(Column.Field) then
    begin
      DataField := Column.Field;
      MaxWidth := DBGrid.Canvas.TextWidth(DataField.DisplayLabel);

      DataSet.First;
      while not DataSet.Eof do
      begin
        TextWidth := DBGrid.Canvas.TextWidth(DataField.DisplayText);
        if TextWidth > MaxWidth then
          MaxWidth := TextWidth;
        DataSet.Next;
      end;

      Column.Width := MaxWidth + 10;  // Добавим немного места для отступов
    end;
  end;
end;

procedure TFormReport.ShowDebugMessage(const Msg: string);
begin
  if DebugMode then
    ShowMessage(Msg);
end;

end.

