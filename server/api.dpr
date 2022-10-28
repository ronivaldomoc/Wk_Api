program api;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uPrincipal in 'view\uPrincipal.pas' {fServidor},
  ServerMethodsUnit1 in 'bin\ServerMethodsUnit1.pas' {ServerMethods1: TDataModule},
  ServerContainerUnit1 in 'bin\ServerContainerUnit1.pas' {ServerContainer1: TDataModule},
  WebModuleUnit1 in 'bin\WebModuleUnit1.pas' {WebModule1: TWebModule},
  Db_ctrl in '..\class\controls\Db_ctrl.pas',
  Pessoa.ctrl in '..\class\controls\Pessoa.ctrl.pas',
  Pessoa.model in '..\class\models\Pessoa.model.pas',
  Endereco.model in '..\class\models\Endereco.model.pas',
  Endereco.ctrl in '..\class\controls\Endereco.ctrl.pas',
  Endereco_integracao.ctrl in '..\class\controls\Endereco_integracao.ctrl.pas',
  Endereco_integracao.model in '..\class\models\Endereco_integracao.model.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfServidor, fServidor);
  Application.Run;
end.
