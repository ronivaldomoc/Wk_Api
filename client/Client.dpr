program Client;

uses
  Vcl.Forms,
  Pessoa.model in '..\class\models\Pessoa.model.pas',
  Db_ctrl in '..\class\controls\Db_ctrl.pas',
  uPessoa in 'uPessoa.pas' {fPessoas},
  uDm in 'uDm.pas' {dm: TDataModule},
  uPesquisa in 'uPesquisa.pas' {fPesquisa},
  Endereco.model in '..\class\models\Endereco.model.pas',
  uInicial in 'uInicial.pas' {fInicial};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfInicial, fInicial);
  Application.Run;
end.
