unit Customer.Controller;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  firedac.phys.SQLite,
  MVCFramework,
  MVCFramework.SQLGenerators.Sqlite,
  MVCFramework.ActiveRecord,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  Customer.Model,
  MVCFramework.Logger;

type

  [MVCPath('/api')]
  TCustomerController = class(TMVCController)
  private
    FDConn : TFDConnection;
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

    [MVCPath('/reversedstrings/($Value)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetReversedString(const Value: String);
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public
    //Sample CRUD Actions for a "Customer" entity
    [MVCPath('/customers')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomers;

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomer(id: Integer);

    [MVCPath('/customers-array')]
    [MVCHTTPMethod([httpPOST])]
    procedure GetCustomerArray();

    [MVCPath('/customers')]
    [MVCHTTPMethod([httpPOST])]
    procedure CreateCustomer;

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateCustomer(id: Integer);

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteCustomer(id: Integer);

    Constructor Create; override;

  end;

implementation

uses
  System.JSON;

procedure TCustomerController.Index;
begin
  //use Context property to access to the HTTP request and response 
  Render('Olá! Vamos codar?');
end;

procedure TCustomerController.GetReversedString(const Value: String);
begin
  Render(System.StrUtils.ReverseString(Value.Trim));
end;

procedure TCustomerController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  { Executed after each action }
  inherited;
end;

procedure TCustomerController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

//Sample CRUD Actions for a "Customer" entity
procedure TCustomerController.GetCustomers;
var
  lCustomers : TObjectList<TCustomer>;
begin
  try
    lCustomers := TMVCActiveRecord.Select<TCustomer>('SELECT * FROM CUSTOMERS', []);
    Render<TCustomer>(lCustomers);
  finally
    //lCustomers.Free;
  end;
end;

procedure TCustomerController.GetCustomer(id: Integer);
var
  lCustomer : TCustomer;
begin
  try
    lCustomer := TMVCActiveRecord.GetByPK<TCustomer>(id);

    Render(lCustomer);
  finally
    //lCustomer.DisposeOf;
  end;
end;

procedure TCustomerController.GetCustomerArray();
var
  lCustomer : TCustomer;
  i : Integer;
begin
  lCustomer := Context.Request.BodyAs<TCustomer>;

  Render(lCustomer);
end;

constructor TCustomerController.Create;
begin
  inherited;
  FDConn := TFDConnection.Create(nil);
  FDConn.Params.Clear;
  FDConn.Params.Database := 'C:\Users\jluiz\OneDrive\Programacao\Delphi\DMVCFramework\src\db\activerecorddb.db';
  FDConn.DriverName := 'SQLite';
  FDConn.Connected := True;

  ActiveRecordConnectionsRegistry.AddDefaultConnection(FDConn);
end;

procedure TCustomerController.CreateCustomer;
var
  lCustomer : TCustomer;
begin
  //todo: create a new customer
  try
    lCustomer := Context.Request.BodyAs<TCustomer>;

    lCustomer.Insert;
  finally
    //lCustomer.DisposeOf;
  end;
end;

procedure TCustomerController.UpdateCustomer(id: Integer);
var
  lCustomer : TCustomer;
begin
  //todo: update customer by id
  try
    lCustomer := Context.Request.BodyAs<TCustomer>;
    lCustomer.id := id;
    lCustomer.Update;
  finally

  end;
end;

procedure TCustomerController.DeleteCustomer(id: Integer);
var
  lCustomer : TCustomer;
begin
  //todo: delete customer by id
  lCustomer := TMVCActiveRecord.GetByPK<TCustomer>(id);
  lCustomer.Delete;

  Render(TJSONObject.Create(TJSONPair.Create('result','Registro Deletado')));
end;



end.
