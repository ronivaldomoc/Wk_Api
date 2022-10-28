unit Endereco.model;

interface

Type TEndereco_model = class (TObject)
 private
    fidendereco: Integer;
    fdscep: String;
    fIdpessoa: Integer;
    procedure Setdscep(const Value: String);
    procedure SetIdendereco(const Value: Integer);
    procedure SetIdpessoa(const Value: Integer);

 public
    property idPessoa: Integer read fIdpessoa write SetIdpessoa;
    property idendereco: Integer read fidendereco write Setidendereco;
    property dscep : String read fdscep write Setdscep;
end;

implementation

{ TEndereco_model }

procedure TEndereco_model.Setdscep(const Value: String);
begin
  fdscep := Value;
end;

procedure TEndereco_model.SetIdendereco(const Value: Integer);
begin
  fIdendereco := Value;
end;

procedure TEndereco_model.SetIdpessoa(const Value: Integer);
begin
  fIdpessoa := Value;
end;

end.
