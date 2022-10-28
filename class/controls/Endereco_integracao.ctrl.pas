unit Endereco_integracao.ctrl;

interface

uses
  Db_ctrl, Endereco_integracao.model;

Type TEndereco_integracao_ctrl = Class(TObject)

  public
    db : TDb_ctrl;
    Model : Tendereco_integracao_model;

    constructor Create(_db: TDb_ctrl=nil);
    destructor Destroy; override;

    function executa_sql: boolean;
    function insert: boolean;
    function delete: boolean;
  private


End;

implementation

uses
  System.SysUtils, Vcl.Forms, Winapi.Windows, FireDAC.Comp.Client;

{ TPessoa_ctrl }


{ TPessoa_ctrl }

constructor TEndereco_integracao_ctrl.Create(_db: TDb_ctrl);
begin
  if _db = nil then
   db := TDb_ctrl.Create
  else
   db := _db;

  Model := TEndereco_integracao_model.Create;
end;

function TEndereco_integracao_ctrl.delete: boolean;
begin
  Try
    db.qryTemp.Close;
    db.qryTemp.SQL.Clear;
    db.qryTemp.SQL.Add('DELETE FROM endereco');

    if Model.idendereco > 0 then
      db.qryTemp.SQL.Add('WHERE idendereco = '+IntToStr(Model.idendereco));

    db.qryTemp.ExecSQL();
    db.Conexao.Commit;
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

destructor TEndereco_integracao_ctrl.Destroy;
begin
  FreeAndnil(Model);

  inherited;
end;

function TEndereco_integracao_ctrl.executa_sql: boolean;
begin
  Try
    db.qryTemp.Close;
    db.qryTemp.SQL.Clear;
    db.qryTemp.SQL.Add('SELECT * FROM endereco');

    if Model.idendereco > 0 then
      db.qryTemp.SQL.Add('WHERE idendereco = '+IntToStr(Model.idendereco));

    db.qryTemp.Open();
    Result := True;
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

function TEndereco_integracao_ctrl.insert: boolean;
begin
  Try
    db.qryTemp.Close;
    db.qryTemp.SQL.Clear;
    db.qryTemp.SQL.Add('SELECT * FROM endereco_inetgracao');
    db.qryTemp.SQL.Add('WHERE idendereco = :idendereco');
    db.qryTemp.ParamByName('idendereco').AsInteger := model.idendereco;
    db.qryTemp.Open();

    if db.qryTemp.IsEmpty then
     begin
       db.qryTemp.Insert;
       db.qryTemp.FieldByName('idendereco').AsInteger := model.idendereco;
     end
    else
      db.qryTemp.Edit;

    db.qryTemp.FieldByName('dsuf').AsString := model.dsuf;
    db.qryTemp.FieldByName('nmcidade').AsString := model.nmcidade;
    db.qryTemp.FieldByName('nmbairro').AsString := model.nmbairro;
    db.qryTemp.FieldByName('nmlogradouro').AsString := model.nmlogradouro;
    db.qryTemp.FieldByName('dscomplemento').AsString := model.dscomplemento;
    db.qryTemp.Post;
    Result := True;
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
end;

end.
