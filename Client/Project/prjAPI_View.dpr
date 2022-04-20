program prjAPI_View;

uses
  Vcl.Forms,
  frmMain in '..\src\View\frmMain.pas' {frmViewCustomer},
  Customer.Controller in '..\src\Controller\Customer.Controller.pas' {dmCustomerController: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmViewCustomer, frmViewCustomer);
  Application.Run;
end.
