unit uInicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfInicial = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fInicial: TfInicial;

implementation

{$R *.dfm}

uses uPessoa;

procedure TfInicial.Button1Click(Sender: TObject);
begin
  fPessoas := TfPessoas.Create(Application);
  Try
    fPessoas.ShowModal;
  Finally
    FreeAndNil(fPessoas);
  End;
end;

end.
