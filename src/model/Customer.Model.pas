unit Customer.Model;

interface

uses MVCFramework.ActiveRecord;

type
  [MVCTable('customers')]
  TCustomer = class(TMVCActiveRecord)
  private
    [MVCTableField('id', [foPrimaryKey, foAutoGenerated])]
    Fid: Integer;
    [MVCTableField('code', [])]
    Fcode: String;
    [MVCTableField('rating',[])]
    Frating: Integer;
    [MVCTableField('note',[])]
    Fnote: String;
    [MVCTableField('description', [])]
    Fdescription: String;
    [MVCTableField('city', [])]
    Fcity: String;
    procedure Setcity(const Value: String);
    procedure Setcode(const Value: String);
    procedure Setdescription(const Value: String);
    procedure Setid(const Value: Integer);
    procedure Setnote(const Value: String);
    procedure Setrating(const Value: Integer);
    public
      property id: Integer read Fid write Setid;
      property code: String read Fcode write Setcode;
      property description: String read Fdescription write Setdescription;
      property city: String read Fcity write Setcity;
      property note: String read Fnote write Setnote;
      property rating: Integer read Frating write Setrating;
  end;

implementation

{ TCustomer }

procedure TCustomer.Setcity(const Value: String);
begin
  Fcity := Value;
end;

procedure TCustomer.Setcode(const Value: String);
begin
  Fcode := Value;
end;

procedure TCustomer.Setdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TCustomer.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TCustomer.Setnote(const Value: String);
begin
  Fnote := Value;
end;

procedure TCustomer.Setrating(const Value: Integer);
begin
  Frating := Value;
end;

end.
