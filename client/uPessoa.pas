unit uPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinsDefaultPainters, Vcl.StdCtrls, Vcl.ExtCtrls,
  cxDropDownEdit, cxCalendar, cxDBEdit, cxTextEdit, cxMaskEdit, cxSpinEdit,
  ACBrBase, ACBrEnterTab, Vcl.Buttons;

type
  TfPessoas = class(TForm)
    dsPessoa: TDataSource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cxDBSpinEdit2: TcxDBSpinEdit;
    Label3: TLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    Label4: TLabel;
    cxDBTextEdit2: TcxDBTextEdit;
    Label5: TLabel;
    cxDBTextEdit3: TcxDBTextEdit;
    Label6: TLabel;
    Label7: TLabel;
    cxDBTextEdit4: TcxDBTextEdit;
    Label8: TLabel;
    cxDBTextEdit5: TcxDBTextEdit;
    Label9: TLabel;
    cxDBTextEdit6: TcxDBTextEdit;
    Label10: TLabel;
    dbeEndereco: TcxDBTextEdit;
    Label11: TLabel;
    cxDBTextEdit8: TcxDBTextEdit;
    Panel1: TPanel;
    btNovo: TButton;
    btGravar: TButton;
    btCancelar: TButton;
    btExcluir: TButton;
    btPesquisar: TButton;
    cxDBTextEdit9: TcxDBTextEdit;
    cxDBTextEdit10: TcxDBTextEdit;
    dbedtCep: TcxDBTextEdit;
    Label12: TLabel;
    btnBuscarEndreco: TButton;
    ACBrEnterTab1: TACBrEnterTab;
    procedure btNovoClick(Sender: TObject);
    procedure dsPessoaDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
    procedure btnBuscarEndrecoClick(Sender: TObject);
    procedure dbedtCepExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPessoas: TfPessoas;

implementation

{$R *.dfm}

uses uDm, uPesquisa, System.JSON;

procedure TfPessoas.btGravarClick(Sender: TObject);
begin
  dm.updtePessoa;
  dm.getPessoas;
  DM.tbPessoa.DisableControls;
  DM.tbPessoa.Last;
  DM.tbPessoa.EnableControls;
end;

procedure TfPessoas.btnBuscarEndrecoClick(Sender: TObject);
begin
  if Length(Trim(dbedtCep.Text)) < 8 then
   begin
     MessageDlg('Digite um CEP!', mtInformation, [mbOK],0);
     dbedtCep.SetFocus;
     exit;
   end;

  Dm.getEndereco(dm.tbPessoaidendereco.AsString.trim);
end;

procedure TfPessoas.btNovoClick(Sender: TObject);
begin
  dm.tbPessoa.Insert;
  dm.tbPessoaidpessoa.AsInteger := 0;
  dm.tbPessoadtregistro.AsString := DateToStr(Date);
  cxDBTextEdit1.SetFocus;
end;

procedure TfPessoas.btCancelarClick(Sender: TObject);
begin
  dm.tbPessoa.Cancel;
end;

procedure TfPessoas.btExcluirClick(Sender: TObject);
begin
  if dm.tbPessoaidpessoa.AsInteger < 1 then
   Exit;

  if (MessageDlg('Confirmar a exclusão?', mtConfirmation,[ mbYes,MbNo ], 0) = mrYes) then
    begin
      dm.deletePessoas;
      dm.getPessoas;
    end;
end;

procedure TfPessoas.btPesquisarClick(Sender: TObject);
begin
  fPesquisa := TfPesquisa.Create(Application);
  Try
    fPesquisa.ShowModal;
    if not dm.tbPessoa.IsEmpty then
      dm.tbPessoa.Edit;
  Finally
    FreeAndNil(fPesquisa);
  End;
end;

procedure TfPessoas.dbedtCepExit(Sender: TObject);
begin
  if (Trim(dbeEndereco.Text) = '') And
     (MessageDlg('Buscar o endereço pelo CEP?', mtConfirmation,[ mbYes,MbNo ], 0) = mrYes) then
    btnBuscarEndreco.Click;
end;

procedure TfPessoas.dsPessoaDataChange(Sender: TObject; Field: TField);
begin
  btGravar.Enabled := dm.tbPessoa.State in[dsInsert, dsEdit];
  GroupBox1.Enabled := btGravar.Enabled;
  GroupBox2.Enabled := btGravar.Enabled;
  btCancelar.Enabled := btGravar.Enabled;
  btExcluir.Enabled := not btGravar.Enabled;
  btNovo.Enabled := not btGravar.Enabled;
  btPesquisar.Enabled := not btGravar.Enabled;
end;

procedure TfPessoas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.tbPessoa.Close;
end;

procedure TfPessoas.FormShow(Sender: TObject);
begin
  dm.tbPessoa.CreateDataSet;
end;

end.
