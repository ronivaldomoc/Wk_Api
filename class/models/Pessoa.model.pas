unit Pessoa.model;

interface

Type TPessoa_model = class (TObject)
 private
    fNmprimeiro: String;
    fDtregistro: String;
    fNmsegundo: String;
    fDsdocumento: String;
    fIdpessoa: Integer;
    fFlnatureza: Integer;
    procedure SetDsdocumento(const Value: String);
    procedure SetDtregistro(const Value: String);
    procedure SetFlnatureza(const Value: Integer);
    procedure SetIdpessoa(const Value: Integer);
    procedure SetNmprimeiro(const Value: String);
    procedure SetNmsegundo(const Value: String);
 public
    property idPessoa: Integer read fIdpessoa write SetIdpessoa;
    property flnatureza : Integer read fFlnatureza write SetFlnatureza;
    property dsdocumento: String read fDsdocumento write SetDsdocumento;
    property nmprimeiro: String read fNmprimeiro write SetNmprimeiro;
    property nmsegundo: String read fNmsegundo write SetNmsegundo;
    property dtregistro : String read fDtregistro write SetDtregistro;
end;

implementation

{ TPessoa_model }

procedure TPessoa_model.SetDsdocumento(const Value: String);
begin
  fDsdocumento := Value;
end;

procedure TPessoa_model.SetDtregistro(const Value: String);
begin
  fDtregistro := Value;
end;

procedure TPessoa_model.SetFlnatureza(const Value: Integer);
begin
  fFlnatureza := Value;
end;

procedure TPessoa_model.SetIdpessoa(const Value: Integer);
begin
  fIdpessoa := Value;
end;

procedure TPessoa_model.SetNmprimeiro(const Value: String);
begin
  fNmprimeiro := (Value);
end;

procedure TPessoa_model.SetNmsegundo(const Value: String);
begin
  fNmsegundo := (Value);
end;

end.
