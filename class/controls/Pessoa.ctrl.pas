unit Pessoa.ctrl;


interface

uses
  Db_ctrl, Pessoa.model, Endereco.ctrl;

Type TPessoa_ctrl = Class(TObject)

  public
    db : TDb_ctrl;
    Model : TPessoa_model;
    Endereco : TEndereco_ctrl;

    constructor Create(_db: TDb_ctrl=nil);
    destructor Destroy; override;

    function executa_sql: boolean;
    function insert: boolean;
    function delete: boolean;

    procedure getItem;
  private
    function geraID: Integer;

End;

implementation

uses
  System.SysUtils, Vcl.Forms, Winapi.Windows, FireDAC.Comp.Client;

{ TPessoa_ctrl }


{ TPessoa_ctrl }

constructor TPessoa_ctrl.Create(_db: TDb_ctrl);
begin
  if _db = nil then
   db := TDb_ctrl.Create
  else
   db := _db;

  Model := TPessoa_model.Create;
  Endereco := TEndereco_ctrl.Create;
end;

function TPessoa_ctrl.delete: boolean;
begin
  Try
    Endereco.Model.idPessoa := model.idPessoa;
    if not Endereco.delete then
     begin
       Result := False;
       db.Conexao.Rollback;
       Exit;
     end;

    db.qryTemp.Close;
    db.qryTemp.SQL.Clear;
    db.qryTemp.SQL.Add('DELETE FROM PESSOA');

    if Model.idPessoa > 0 then
      db.qryTemp.SQL.Add('WHERE idPessoa = '+IntToStr(Model.idPessoa));

    db.qryTemp.ExecSQL();
    db.Conexao.Commit;
    Result := True;
  Except
    On e: Exception do
     begin
       db.Conexao.Rollback;
       Result := False;
        Application.MessageBox('Erro ao excluir PESSOA! ' + sLineBreak +
         'Entre em contato com o Administrador do Sistema!',
         'SISTEMA wk', MB_OK
         + MB_ICONSTOP);

          Application.Terminate;
     end;
  End;
end;

destructor TPessoa_ctrl.Destroy;
begin
  FreeAndnil(Model);
  FreeAndNil(Endereco);
  inherited;
end;

function TPessoa_ctrl.executa_sql: boolean;
begin
  Try
    db.qryTemp.Close;
    db.qryTemp.SQL.Clear;
    db.qryTemp.SQL.Add('SELECT * FROM PESSOA');

    if Model.idPessoa > 0 then
      db.qryTemp.SQL.Add('WHERE idPessoa = '+IntToStr(Model.idPessoa));

    db.qryTemp.Open();
    Result := True;
  Except
    On e: Exception do
     begin
       Result := False;
        Application.MessageBox('Erro ao carregar PESSOA! ' + sLineBreak +
         'Entre em contato com o Administrador do Sistema!',
         'SISTEMA wk', MB_OK
         + MB_ICONSTOP);

          Application.Terminate;
     end;
  End;
end;

function TPessoa_ctrl.geraID: Integer;
Var
  qTemp : TFDQuery;
begin
  qTemp := TFDQuery.Create(nil);
  Try
    qTemp.Connection := db.Conexao;
    qTemp.Close;
    qTemp.SQL.Clear;
    qTemp.SQL.Add('SELECT (Coalesce(max(idPessoa),0)+1) as id FROM PESSOA');
    qTemp.Open();
    Result := qTemp.FieldByName('id').AsInteger;
  Finally
    FreeAndNil(qTemp);
  End;
end;

procedure TPessoa_ctrl.getItem;
begin
  Model.idPessoa := db.qryTemp.FieldByName('idPessoa').AsInteger;
  Model.flnatureza := db.qryTemp.FieldByName('flnatureza').AsInteger;
  Model.dsdocumento := db.qryTemp.FieldByName('dsdocumento').AsString;
  Model.nmprimeiro := db.qryTemp.FieldByName('nmprimeiro').AsString;
  Model.nmsegundo := db.qryTemp.FieldByName('nmsegundo').AsString;
  Model.dtregistro := db.qryTemp.FieldByName('dtregistro').AsString;
end;

function TPessoa_ctrl.insert: boolean;
begin
  Try
    db.qryTemp.Close;
    db.qryTemp.SQL.Clear;
    db.qryTemp.SQL.Add('SELECT * FROM PESSOA');
    db.qryTemp.SQL.Add('WHERE idPessoa = :idPessoa');
    db.qryTemp.ParamByName('idPessoa').AsInteger := model.idPessoa;
    db.qryTemp.Open();

    if db.qryTemp.IsEmpty then
     begin
       model.idPessoa := geraID;
       db.qryTemp.Insert;
       db.qryTemp.FieldByName('idPessoa').AsInteger := model.idPessoa;
     end
    else
      db.qryTemp.Edit;

    db.qryTemp.FieldByName('flnatureza').AsInteger := model.flnatureza;
    db.qryTemp.FieldByName('dsdocumento').AsString := model.dsdocumento;
    db.qryTemp.FieldByName('nmprimeiro').AsString := model.nmprimeiro;
    db.qryTemp.FieldByName('nmsegundo').AsString := model.nmsegundo;
    db.qryTemp.FieldByName('dtregistro').AsDateTime := date;//model.dtregistro;
    db.qryTemp.Post;

    Endereco.Model.idPessoa :=  model.idPessoa;
    if Endereco.insert then // poderia criar uma lista de endereços mas não foi possivel devido ao tempo disponivel
      begin
        Result := True;
        db.Conexao.Commit;
      end
    else
     begin
       db.Conexao.Rollback;
       Result := False;
     end;
  Except
       On e: Exception do
     begin
        db.Conexao.Rollback;
        Result := False;
        Application.MessageBox('Erro ao inserir PESSOA! ' + sLineBreak +
         'Entre em contato com o Administrador do Sistema!',
         'SISTEMA wk', MB_OK
         + MB_ICONSTOP);

          Application.Terminate;
     end;
  End;
end;

end.
