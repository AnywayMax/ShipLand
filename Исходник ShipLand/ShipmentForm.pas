unit ShipmentForm;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Dialogs, Data.DB, Vcl.Graphics;

type
  TFormShipment = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ComboBoxSuppliers: TComboBox;
    DateTimePicker: TDateTimePicker;
    DBGridProducts: TDBGrid;
    ButtonAddProduct: TButton;
    ButtonSaveShipment: TButton;
    ButtonClearShipment: TButton;
    DBGridAddedProducts: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBoxSuppliersChange(Sender: TObject);
    procedure ButtonAddProductClick(Sender: TObject);
    procedure ButtonSaveShipmentClick(Sender: TObject);
    procedure ButtonClearShipmentClick(Sender: TObject);
  private
    procedure LoadSuppliers;
    procedure LoadProducts(SupplierID: Integer);
    procedure LoadAddedProducts;
    procedure AdjustGridColumnWidths(DBGrid: TDBGrid; DataSet: TDataSet);
    procedure ShowDebugMessage(const Msg: string);
  public
  end;

var
  FormShipment: TFormShipment;


implementation

{$R *.dfm}

uses
  DataModule1, MainForm;

procedure TFormShipment.FormCreate(Sender: TObject);
begin
  LoadSuppliers;
  LoadAddedProducts;
  DateTimePicker.Format := 'dd.MM.yyyy';  // Установка формата даты
end;

procedure TFormShipment.FormShow(Sender: TObject);
begin
  LoadSuppliers;
  // Загрузить продукты для первого поставщика по умолчанию
  if ComboBoxSuppliers.Items.Count > 0 then
  begin
    ComboBoxSuppliers.ItemIndex := 0;
    LoadProducts(ComboBoxSuppliers.ItemIndex + 1);
  end;
  LoadAddedProducts;
end;

procedure TFormShipment.LoadSuppliers;
begin
  ComboBoxSuppliers.Items.Clear;
  DataModule1Instance.QuerySuppliers.Close;
  DataModule1Instance.QuerySuppliers.Open;

  // Проверим, есть ли данные в запросе
  if DataModule1Instance.QuerySuppliers.IsEmpty then
  begin
    ShowDebugMessage('Запрос QuerySuppliers не вернул результатов');
    Exit;
  end;

  while not DataModule1Instance.QuerySuppliers.Eof do
  begin
    ComboBoxSuppliers.Items.Add(DataModule1Instance.QuerySuppliers.FieldByName('Name').AsString);
    DataModule1Instance.QuerySuppliers.Next;
  end;

  ShowDebugMessage('Загружено поставщиков: ' + IntToStr(ComboBoxSuppliers.Items.Count));
end;

procedure TFormShipment.LoadProducts(SupplierID: Integer);
begin
  try
    DataModule1Instance.QueryProducts.Close;
    DataModule1Instance.QueryProducts.SQL.Text := 'SELECT p.ProductID, p.Name, p.Type, pr.Price ' +
                                                  'FROM Products p ' +
                                                  'JOIN Prices pr ON p.ProductID = pr.ProductID ' +
                                                  'WHERE pr.SupplierID = :SupplierID AND :Date BETWEEN pr.StartDate AND pr.EndDate';

    // Проверка на наличие значения SupplierID
    if SupplierID = 0 then
    begin
      ShowMessage('Пожалуйста, выберите поставщика');
      Exit;
    end;

    DataModule1Instance.QueryProducts.ParamByName('SupplierID').AsInteger := SupplierID;
    DataModule1Instance.QueryProducts.ParamByName('Date').AsDate := DateTimePicker.Date;

    // Отладочный вывод SQL-запроса
    DataModule1Instance.ShowQuery(DataModule1Instance.QueryProducts);

    DataModule1Instance.QueryProducts.Open;

    ShowDebugMessage('Количество записей: ' + IntToStr(DataModule1Instance.QueryProducts.RecordCount));

    if DataModule1Instance.QueryProducts.IsEmpty then
      ShowDebugMessage('Запрос QueryProducts не вернул результатов')
    else
      ShowDebugMessage('Запрос QueryProducts выполнен успешно');

    // Убедимся, что DBGrid имеет нужное количество столбцов перед их настройкой
    DBGridProducts.Columns.Clear;
    DBGridProducts.Columns.Add;
    DBGridProducts.Columns.Add;
    DBGridProducts.Columns.Add;
    DBGridProducts.Columns.Add;

    DBGridProducts.Columns[0].Title.Caption := 'ID Продукта';
    DBGridProducts.Columns[0].FieldName := 'ProductID';
    DBGridProducts.Columns[1].Title.Caption := 'Название';
    DBGridProducts.Columns[1].FieldName := 'Name';
    DBGridProducts.Columns[2].Title.Caption := 'Тип';
    DBGridProducts.Columns[2].FieldName := 'Type';
    DBGridProducts.Columns[3].Title.Caption := 'Цена';
    DBGridProducts.Columns[3].FieldName := 'Price';

    DBGridProducts.DataSource := DataModule1Instance.DataSourceProducts;
    AdjustGridColumnWidths(DBGridProducts, DataModule1Instance.QueryProducts);
  except
    on E: Exception do
      ShowMessage('Ошибка выполнения запроса: ' + E.Message);
  end;
end;


procedure TFormShipment.ComboBoxSuppliersChange(Sender: TObject);
begin
  if ComboBoxSuppliers.ItemIndex >= 0 then
    LoadProducts(ComboBoxSuppliers.ItemIndex + 1)
  else
    ShowMessage('Пожалуйста, выберите поставщика');
end;

procedure TFormShipment.LoadAddedProducts;
begin
  try
    DataModule1Instance.QueryShipmentDetails.Close;
    DataModule1Instance.QueryShipmentDetails.SQL.Text := 'SELECT sd.ShipmentDetailID, sd.ProductID, p.Name, p.Type, sd.Quantity, sd.ShipmentID ' +
                                                         'FROM ShipmentDetails sd ' +
                                                         'JOIN Products p ON sd.ProductID = p.ProductID ' +
                                                         'WHERE sd.ShipmentID IS NULL';

    // Отладочный вывод SQL-запроса
    DataModule1Instance.ShowQuery(DataModule1Instance.QueryShipmentDetails);

    DataModule1Instance.QueryShipmentDetails.Open;

    DBGridAddedProducts.Columns.Clear;
    DBGridAddedProducts.Columns.Add;
    DBGridAddedProducts.Columns.Add;
    DBGridAddedProducts.Columns.Add;
    DBGridAddedProducts.Columns.Add;
    DBGridAddedProducts.Columns.Add;
    DBGridAddedProducts.Columns.Add;

    DBGridAddedProducts.Columns[0].Title.Caption := 'ID Детали Поставки';
    DBGridAddedProducts.Columns[0].FieldName := 'ShipmentDetailID';
    DBGridAddedProducts.Columns[1].Title.Caption := 'ID Продукта';
    DBGridAddedProducts.Columns[1].FieldName := 'ProductID';
    DBGridAddedProducts.Columns[2].Title.Caption := 'Название';
    DBGridAddedProducts.Columns[2].FieldName := 'Name';
    DBGridAddedProducts.Columns[3].Title.Caption := 'Тип';
    DBGridAddedProducts.Columns[3].FieldName := 'Type';
    DBGridAddedProducts.Columns[4].Title.Caption := 'Количество';
    DBGridAddedProducts.Columns[4].FieldName := 'Quantity';
    DBGridAddedProducts.Columns[5].Title.Caption := 'ID Поставки';
    DBGridAddedProducts.Columns[5].FieldName := 'ShipmentID';

    DBGridAddedProducts.DataSource := DataModule1Instance.DataSourceShipmentDetails;
    AdjustGridColumnWidths(DBGridAddedProducts, DataModule1Instance.QueryShipmentDetails);
  except
    on E: Exception do
      ShowMessage('Ошибка загрузки добавленных продуктов: ' + E.Message);
  end;
end;

procedure TFormShipment.AdjustGridColumnWidths(DBGrid: TDBGrid; DataSet: TDataSet);
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

procedure TFormShipment.ButtonAddProductClick(Sender: TObject);
var
  ProductID, Quantity: Integer;
begin
  if DBGridProducts.DataSource.DataSet.IsEmpty then
  begin
    ShowMessage('Выберите продукт для добавления');
    Exit;
  end;

  ProductID := DBGridProducts.DataSource.DataSet.FieldByName('ProductID').AsInteger;
  Quantity := StrToInt(InputBox('Введите количество', 'Количество:', '1'));

  if ProductID = 0 then
  begin
    ShowMessage('Некорректный продукт');
    Exit;
  end;

  if Quantity <= 0 then
  begin
    ShowMessage('Некорректное количество');
    Exit;
  end;

  try
    if not DataModule1Instance.QueryShipmentDetails.Active then
      DataModule1Instance.QueryShipmentDetails.Open;

    DataModule1Instance.QueryShipmentDetails.Append;
    DataModule1Instance.QueryShipmentDetails.FieldByName('ProductID').AsInteger := ProductID;
    DataModule1Instance.QueryShipmentDetails.FieldByName('Quantity').AsFloat := Quantity;
    DataModule1Instance.QueryShipmentDetails.Post;

    LoadAddedProducts; // Обновить таблицу добавленных продуктов
  except
    on E: Exception do
      ShowMessage('Ошибка добавления продукта: ' + E.Message);
  end;
end;

procedure TFormShipment.ButtonSaveShipmentClick(Sender: TObject);
var
  NewShipmentID: Integer;
begin
  if not DataModule1Instance.QueryShipments.Active then
    DataModule1Instance.QueryShipments.Open;

  DataModule1Instance.QueryShipments.Append;
  DataModule1Instance.QueryShipments.FieldByName('SupplierID').AsInteger := ComboBoxSuppliers.ItemIndex + 1;
  DataModule1Instance.QueryShipments.FieldByName('Date').AsDateTime := DateTimePicker.Date;

  // Отладочный вывод SQL-запроса
  DataModule1Instance.ShowQuery(DataModule1Instance.QueryShipments);

  DataModule1Instance.QueryShipments.Post;

  NewShipmentID := DataModule1Instance.QueryShipments.FieldByName('ShipmentID').AsInteger;

  DataModule1Instance.QueryShipmentDetails.First;
  while not DataModule1Instance.QueryShipmentDetails.Eof do
  begin
    DataModule1Instance.QueryShipmentDetails.Edit;
    DataModule1Instance.QueryShipmentDetails.FieldByName('ShipmentID').AsInteger := NewShipmentID;
    DataModule1Instance.QueryShipmentDetails.Post;
    DataModule1Instance.QueryShipmentDetails.Next;
  end;

  ShowMessage('Приемка сохранена');
  LoadAddedProducts; // Очистить таблицу добавленных продуктов после сохранения
end;

procedure TFormShipment.ButtonClearShipmentClick(Sender: TObject);
begin
  if not DataModule1Instance.QueryShipmentDetails.Active then
    DataModule1Instance.QueryShipmentDetails.Open;

  DataModule1Instance.QueryShipmentDetails.First;
  while not DataModule1Instance.QueryShipmentDetails.Eof do
  begin
    DataModule1Instance.QueryShipmentDetails.Delete;
  end;

  LoadAddedProducts; // Обновить таблицу добавленных продуктов
end;

procedure TFormShipment.ShowDebugMessage(const Msg: string);
begin
  if DebugMode then
    ShowMessage(Msg);
end;

end.
