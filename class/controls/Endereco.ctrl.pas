unit Endereco.ctrl;

interface

uses
  Db_ctrl, Endereco.model, Endereco_integracao.ctrl;

Type TEndereco_ctrl = Class(TObject)

  public
    db : TDb_ctrl;
    Model : TEndereco_model;
    Endereco_integra : TEndereco_integracao_ctrl;

    constructor Create(_db: TDb_ctrl=nil);
    destructor Destroy; override;

    function getEndereco: boolean;
    function insert: boolean;
    function delete: boolean;

  private
    procedure populaProps;

End;

implementation

uses
  System.SysUtils, Vcl.Forms, Winapi.Windows, FireDAC.Comp.Client;

{ TPessoa_ctrl }


{ TPessoa_ctrl }

constructor TEndereco_ctrl.Create(_db: TDb_ctrl);
begin
  if _db = nil then
   db := TDb_ctrl.Create
  else
   db := _db;

  Model := TEndereco_model.Create;
  Endereco_integra := Tendereco_integracao_ctrl.Create;
end;

function TEndereco_ctrl.delete: boolean;
begin
  Try
    db.qryTemp.Close;
    db.qryTemp.SQL.Clear;
    db.qryTemp.SQL.Add('DELETE FROM endereco');

    if Model.idPessoa > 0 then
      db.qryTemp.SQL.Add('WHERE idPessoa = '+IntToStr(Model.idPessoa));

    db.qryTemp.ExecSQL();
    Result := True;
  Except
    On e: Exception do
     begin
       db.Conexao.Rollback;
       Result := False;
        Application.MessageBox('Erro ao excluir! ' + sLineBreak +
         'Entre em contato com o Administrador do Sistema!',
         'SISTEMA wk', MB_OK
         + MB_ICONSTOP);

          Application.Terminate;
     end;
  End;
end;

destructor TEndereco_ctrl.Destroy;
begin
  FreeAndnil(Model);
  FreeAndNil(Endereco_integra);
  inherited;
end;

function TEndereco_ctrl.getEndereco: boolean;
begin
  Try
    db.qryTemp.Close;
    db.qryTemp.SQL.Clear;
    db.qryTemp.SQL.Add('SELECT endereco.idpessoa, endereco.dscep, ei.*');
    db.qryTemp.SQL.Add('FROM endereco');
    db.qryTemp.SQL.Add('inner join endereco_inetgracao ei on ei.idendereco = endereco.idendereco');

    if Model.idPessoa > 0 then
      db.qryTemp.SQL.Add('WHERE idPessoa = '+IntToStr(Model.idPessoa));

    db.qryTemp.Open();
    populaProps;
    Result := not db.qryTemp.IsEmpty;
  Except
    On e: Exception do
     begin
       Result := False;
        Application.MessageBox('Erro ao carregar! ' + sLineBreak +
         'Entre em contato com o Administrador do Sistema!',
         'SISTEMA wk', MB_OK
         + MB_ICONSTOP);

          Application.Terminate;
     end;
  End;
end;

function TEndereco_ctrl.insert: boolean;
begin
  if Model.idendereco > 0 then
   begin
    Try
      Endereco_integra.Model.idendereco := Model.idendereco;
      if not Endereco_integra.insert then
        begin
          Result := False;
          db.Conexao.Rollback;
          Exit;
        end;

      db.qryTemp.Close;
      db.qryTemp.SQL.Clear;
      db.qryTemp.SQL.Add('SELECT * FROM endereco');
      db.qryTemp.SQL.Add('WHERE idendereco = :idendereco');
      db.qryTemp.SQL.Add('  and idpessoa = :idpessoa');
      db.qryTemp.ParamByName('idendereco').AsInteger := model.idendereco;
      db.qryTemp.ParamByName('idpessoa').AsInteger := model.idpessoa;
      db.qryTemp.Open();

      if db.qryTemp.IsEmpty then
       begin
         db.qryTemp.Insert;
         db.qryTemp.FieldByName('idendereco').AsInteger := model.idendereco;
         db.qryTemp.FieldByName('idpessoa').AsInteger := model.idpessoa;
       end
      else
        db.qryTemp.Edit;

      db.qryTemp.FieldByName('dscep').AsString := model.dscep;
      db.qryTemp.Post;
    Except
         On e: Exception do
       begin
          db.Conexao.Rollback;
          Result := False;
          Application.MessageBox('Erro ao inserir! ' + sLineBreak +
           'Entre em contato com o Administrador do Sistema!',
           'SISTEMA wk', MB_OK
           + MB_ICONSTOP);

            Application.Terminate;
       end;
    End;
   end
  else
   Result := true;
end;

procedure TEndereco_ctrl.populaProps;
begin
  model.idPessoa  := db.qryTemp.FieldByName('idPessoa').AsInteger;
  model.idendereco  := db.qryTemp.FieldByName('idendereco').AsInteger;
  model.dscep  := db.qryTemp.FieldByName('dscep').AsString;
  Endereco_integra.Model.idendereco := db.qryTemp.FieldByName('idendereco').AsInteger;
  Endereco_integra.Model.nmcidade := db.qryTemp.FieldByName('nmcidade').AsString;
  Endereco_integra.Model.nmbairro := db.qryTemp.FieldByName('nmbairro').AsString;
  Endereco_integra.Model.nmlogradouro := db.qryTemp.FieldByName('nmlogradouro').AsString;
  Endereco_integra.Model.dscomplemento := db.qryTemp.FieldByName('dscomplemento').AsString;
  Endereco_integra.Model.dsuf := db.qryTemp.FieldByName('dsuf').AsString;
end;

end.
