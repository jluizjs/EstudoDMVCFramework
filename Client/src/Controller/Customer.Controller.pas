unit Customer.Controller;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  MVCFramework.RESTClient,
  MVCFramework.DataSet.Utils,
  MVCFramework.Serializer.Commons;

type
  TdmCustomerController = class(TDataModule)
    fdmCustomer: TFDMemTable;
    fdmCustomerid: TIntegerField;
    fdmCustomercode: TStringField;
    fdmCustomerdescription: TStringField;
    fdmCustomercity: TStringField;
    fdmCustomernote: TStringField;
    fdmCustomerrating: TIntegerField;
    procedure fdmCustomerBeforePost(DataSet: TDataSet);
    procedure fdmCustomerBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
    FLoading: Boolean;

    function doGetRESTClient : TRESTClient;
    function doGetAll: String;
  public
    { Public declarations }

    procedure doRefreshData;
    procedure doSalveData(ADataSet: TDataSet);
    procedure doDeleteData(ADataSet: TDataSet);
  end;

var
  dmCustomerController: TdmCustomerController;

const
  HOST = 'localhost';
  PORT = 8081;
  ENDPOINT = '/api/customers';


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TdmCustomerController.doDeleteData(ADataSet: TDataSet);
var
  lRESTClient : TRESTClient;
begin
  lRESTClient := doGetRESTClient;
  try
    lRESTClient.DataSetDelete(ENDPOINT, ADataSet.FieldByName('id').AsString);
  finally
    lRESTClient.DisposeOf;
  end;
end;

function TdmCustomerController.doGetAll: String;
var
  lRESTClient : TRESTClient;
  lRESTResponse : IRESTResponse;
begin
  lRESTClient := doGetRESTClient;
  try
    lRESTResponse := lRESTClient.doGET(ENDPOINT, []);

    Result := lRESTResponse.BodyAsString;
  finally
    lRESTClient.DisposeOf;
  end;
end;

function TdmCustomerController.doGetRESTClient: TRESTClient;
begin
  Result := TRESTClient.Create(HOST, PORT);
end;

procedure TdmCustomerController.doRefreshData;
begin
  fdmCustomer.Close;
  fdmCustomer.Open;
  FLoading := True;
  try
    fdmCustomer.LoadFromJSONArray(doGetAll, TMVCNameCase.ncAsIs);
  finally
    FLoading := False;
  end;
end;

procedure TdmCustomerController.doSalveData(ADataSet: TDataSet);
var
  lRESTClient : TRESTClient;
begin
  if FLoading then
    Exit;

  lRESTClient := doGetRESTClient;
  try
    if ADataSet.State = dsInsert then
    begin
       lRESTClient.DataSetInsert(EndPoint, ADataSet);

       Exit;
    end;

    if ADataSet.State = dsEdit then
    begin
       lRESTClient.DataSetUpdate(
        EndPoint,
        ADataSet,
        ADataSet.FieldByName('id').AsString
       );
       Exit;
    end;
  finally
    lRESTClient.DisposeOf;
  end;

end;

procedure TdmCustomerController.fdmCustomerBeforeDelete(DataSet: TDataSet);
begin
  doDeleteData(DataSet);
end;

procedure TdmCustomerController.fdmCustomerBeforePost(DataSet: TDataSet);
begin
  doSalveData(DataSet);
end;

end.
