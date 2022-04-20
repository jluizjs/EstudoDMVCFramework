unit frmMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  System.Actions,
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  MVCFramework.RESTClient,
  Customer.Controller, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TfrmViewCustomer = class(TForm)
    pnlMain: TPanel;
    pnlTop: TPanel;
    pnlCenter: TPanel;
    btnGetAll: TButton;
    actManageCustomers: TActionManager;
    actGetAll: TAction;
    dbgCustomer: TDBGrid;
    dsCustomer: TDataSource;
    dbnCustomer: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure actGetAllExecute(Sender: TObject);
  private
    { Private declarations }
    FController : TdmCustomerController;
  public
    { Public declarations }
  end;

var
  frmViewCustomer: TfrmViewCustomer;

implementation

{$R *.dfm}

{ TfrmViewCustomer }

procedure TfrmViewCustomer.actGetAllExecute(Sender: TObject);
begin
  FController.doRefreshData;
end;

procedure TfrmViewCustomer.FormCreate(Sender: TObject);
begin
  FController := TdmCustomerController.Create(self);
end;

end.
