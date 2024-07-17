object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 300
  Width = 450
  object UniConnection: TUniConnection
    ProviderName = 'SQLite'
    Database = 'suppliers.db'
    DefaultTransaction = SQLTransaction
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 24
  end
  object SQLTransaction: TUniTransaction
    DefaultConnection = UniConnection
    Left = 24
    Top = 64
  end
  object QuerySuppliers: TUniQuery
    Connection = UniConnection
    SQL.Strings = (
      'SELECT * FROM Suppliers')
    Left = 24
    Top = 104
  end
  object QueryProducts: TUniQuery
    Connection = UniConnection
    SQL.Strings = (
      'SELECT * FROM Products')
    Left = 24
    Top = 144
  end
  object QueryPrices: TUniQuery
    Connection = UniConnection
    SQL.Strings = (
      'SELECT * FROM Prices')
    Left = 24
    Top = 184
  end
  object QueryShipments: TUniQuery
    Connection = UniConnection
    SQL.Strings = (
      'SELECT * FROM Shipments')
    Left = 24
    Top = 224
  end
  object QueryShipmentDetails: TUniQuery
    Connection = UniConnection
    SQL.Strings = (
      'SELECT * FROM ShipmentDetails')
    Left = 24
    Top = 264
  end
  object QueryReport: TUniQuery
    Connection = UniConnection
    SQL.Strings = (
      
        'SELECT s.SupplierID, s.Date, p.Name, d.Quantity, d.Quantity * pr' +
        '.Price AS TotalPrice '
      'FROM Shipments s '
      'JOIN ShipmentDetails d ON s.ShipmentID = d.ShipmentID '
      'JOIN Products p ON d.ProductID = p.ProductID '
      
        'JOIN Prices pr ON (s.SupplierID = pr.SupplierID AND d.ProductID ' +
        '= pr.ProductID) '
      'WHERE s.Date BETWEEN :StartDate AND :EndDate')
    Left = 24
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'StartDate'
      end
      item
        DataType = ftUnknown
        Name = 'EndDate'
      end>
  end
  object DataSourceSuppliers: TDataSource
    DataSet = QuerySuppliers
    Left = 184
    Top = 104
  end
  object DataSourceProducts: TDataSource
    DataSet = QueryProducts
    Left = 184
    Top = 144
  end
  object DataSourcePrices: TDataSource
    DataSet = QueryPrices
    Left = 184
    Top = 184
  end
  object DataSourceShipments: TDataSource
    DataSet = QueryShipments
    Left = 184
    Top = 224
  end
  object DataSourceShipmentDetails: TDataSource
    DataSet = QueryShipmentDetails
    Left = 184
    Top = 264
  end
  object DataSourceReport: TDataSource
    DataSet = QueryReport
    Left = 184
    Top = 304
  end
  object SQLiteUniProvider1: TSQLiteUniProvider
    Left = 184
    Top = 48
  end
end
