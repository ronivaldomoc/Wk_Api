unit Db_ctrl;

interface

uses
  FireDAC.Phys.PG, FireDAC.Comp.Client, Data.FireDACJSONReflect;

Type
 //Parâmetros de conexão
 TParams = RECORD
   public
    database,
    userName,
    password,
    server,
    driverID,
    port,
    vedorLib: string;
  end;

  TDB_ctrl = class(TObject)

  public
    PhathApp : String;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    Conexao : TFDConnection;
    Transacao : TFDTransaction;
    qryTemp : TFDQuery;
    Tabela: TFDMemTable;
    Params : TParams;

    constructor Create;
    destructor Destroy; override;
  private
    procedure executa_conexao;
    procedure ler_parametros;
End;

implementation

uses
  System.SysUtils, Vcl.Forms, System.IniFiles, Winapi.Windows,
  FireDAC.Stan.Option;

{ TDB_ctrl }

procedure TDB_ctrl.ler_parametros;
var
  zArqConfig  : TIniFile;
  zArquivo    : TextFile;
begin
  PhathApp := ExtractFilePath(Application.ExeName) + 'Config.ini';

  if (not fileexists(PhathApp)) then
    begin
       Application.MessageBox('Erro ao carregar as configurações! ' + sLineBreak +
         'Entre em contato com o Administrador do Sistema!', 'SISTEMA wk', MB_OK
         + MB_ICONSTOP);
       Application.Terminate;
    end;

    zArqConfig := TIniFile.Create(PhathApp);
    Try
      Params.server := zArqConfig.ReadString('DADOS','server', '127.0.0.1');
      Params.database := zArqConfig.ReadString('DADOS','database', '');
      Params.userName := zArqConfig.ReadString('DADOS','userName', '');
      Params.password := zArqConfig.ReadString('DADOS','password', '');
      Params.driverID := zArqConfig.ReadString('DADOS','driverID', 'PG');
      Params.port := zArqConfig.ReadString('DADOS','port', '5432');
      Params.vedorLib := zArqConfig.ReadString('DADOS','VedorLib', '');

      if (Params.database = '') or
         (Params.userName = '') or
         (Params.password = '') or
         (Params.server = '') or
         (Params.driverID = '') then
       begin
          Application.MessageBox('Erro ao carregar as configurações! ' + sLineBreak +
         'Entre em contato com o Administrador do Sistema!', 'SISTEMA wk', MB_OK
         + MB_ICONSTOP);

          Application.Terminate;
       end;
    Finally
      zArqConfig.Free;
    end;
end;

constructor TDB_ctrl.Create;
begin
  FDPhysPgDriverLink1:= TFDPhysPgDriverLink.Create(nil);
  Conexao := TFDConnection.Create(nil);
  Transacao := TFDTransaction.Create(nil);
  qryTemp := TFDQuery.Create(nil);

  Transacao.Connection := Conexao;
  qryTemp.Connection := Conexao;
  //qryTemp.UpdateOptions.ReadOnly := True;
  qryTemp.FieldOptions.UpdatePersistent := True;
  qryTemp.FormatOptions.MaxBcdPrecision := 20;

  ler_parametros;
  executa_conexao;
end;

destructor TDB_ctrl.Destroy;
begin
  FreeAndNil(qryTemp);
  FreeAndNil(Transacao);
  FreeAndNil(Conexao);
  FreeAndNil(FDPhysPgDriverLink1);

  inherited;
end;

procedure TDB_ctrl.executa_conexao;
begin
   Try
     Conexao.Params.Database := Params.database;
     Conexao.Params.UserName := Params.userName;
     Conexao.Params.Password := Params.password;
     Conexao.Params.DriverID := Params.driverID;

     Conexao.Params.Values['Server'] := Params.server;
     Conexao.Params.Values['Port'] := Params.port;
     FDPhysPgDriverLink1.VendorLib := Params.vedorLib;

     Conexao.ResourceOptions.AssignedValues := [rvSilentMode];
     Conexao.ResourceOptions.SilentMode := True;
     Conexao.LoginPrompt := False;
     Conexao.Transaction := Transacao;
     Conexao.UpdateOptions.AutoCommitUpdates := False;
     Conexao.UpdateOptions.FastUpdates := False;
     Conexao.UpdateOptions.UpdateNonBaseFields := False;
     Conexao.UpdateTransaction := Transacao;

     Conexao.Connected := True;
   Except
     On e: Exception do
      begin
        Application.MessageBox('Não foi possível abrir o banco de dados ' +sLineBreak+
        'Entre em contato com o Administrador do Sistema!', 'SISTEMA WK', MB_OK
        + MB_ICONSTOP);

        Application.Terminate;
      end;

   End;

end;

end.
