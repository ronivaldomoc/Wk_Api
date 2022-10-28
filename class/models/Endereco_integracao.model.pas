unit Endereco_integracao.model;

interface

Type TEndereco_integracao_model = class (TObject)
 private
    fIdendereco: Integer;
    fnmcidade: String;
    fnmlogradouro: String;
    fnmbairro: String;
    fdsuf: String;
    fdscomplemento: String;
    procedure Setdscomplemento(const Value: String);
    procedure Setdsuf(const Value: String);
    procedure Setidendereco(const Value: Integer);
    procedure Setnmbairro(const Value: String);
    procedure Setnmcidade(const Value: String);
    procedure Setnmlogradouro(const Value: String);

 public
    property idendereco: Integer read fidendereco write Setidendereco;
    property dsuf : String read fdsuf write Setdsuf;
    property nmcidade : String read fnmcidade write Setnmcidade;
    property nmbairro : String read fnmbairro write Setnmbairro;
    property nmlogradouro : String read fnmlogradouro write Setnmlogradouro;
    property dscomplemento : String read fdscomplemento write Setdscomplemento;

end;

implementation


{ TEndereco_inetgracao_model }

procedure TEndereco_integracao_model.Setdscomplemento(const Value: String);
begin
  fdscomplemento := Value;
end;

procedure TEndereco_integracao_model.Setdsuf(const Value: String);
begin
  fdsuf := Value;
end;

procedure TEndereco_integracao_model.Setidendereco(const Value: Integer);
begin
  fidendereco := Value;
end;

procedure TEndereco_integracao_model.Setnmbairro(const Value: String);
begin
  fnmbairro := Value;
end;

procedure TEndereco_integracao_model.Setnmcidade(const Value: String);
begin
  fnmcidade := Value;
end;

procedure TEndereco_integracao_model.Setnmlogradouro(const Value: String);
begin
  fnmlogradouro := Value;
end;

end.
