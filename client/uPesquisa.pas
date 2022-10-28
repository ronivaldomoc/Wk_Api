unit uPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfPesquisa = class(TForm)
    DBGrid1: TDBGrid;
    dsPessoa: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPesquisa: TfPesquisa;

implementation

{$R *.dfm}

uses uDm;

procedure TfPesquisa.DBGrid1DblClick(Sender: TObject);
begin
  Close;
end;

procedure TfPesquisa.FormShow(Sender: TObject);
begin
  dm.getPessoas;
end;

end.
