unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,
  FireDAC.Stan.Def,FireDAC.DApt,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  REST.Response.Adapter, FireDAC.Stan.Intf, FireDAC.VCLUI.Wait, FireDAC.FMXUI.Wait,
  FireDAC.ConsoleUI.Wait, Vcl.Buttons, FireDAC.Stan.StorageJSON;

type
  TForm1 = class(TForm)
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.JSON, REST.Json, Data.FireDACJSONReflect,
  Data.DBXJSONReflect, Pessoa.model, Endereco.model;


{$R *.dfm}



procedure TForm1.BitBtn1Click(Sender: TObject);
var
    jsonObjPed, jsonObjItem: TJSONObject;
    jsonArrayItem, jsonArrayPed: TJSONArray;
    x, y : integer;
begin
    try
        jsonArrayPed := TJSONArray.Create;

        // Pedidos...
        for x := 1 to 2 do
        begin
            jsonObjPed := TJSONObject.Create;
            jsonObjPed.AddPair('idpessoa', tbPessoa.FieldByName('flnatureza').AsString);
            jsonObjPed.AddPair('flnatureza', tbPessoa.FieldByName('flnatureza').AsString);
            jsonObjPed.AddPair('dsdocumento', tbPessoa.FieldByName('dsdocumento').AsString);
            jsonObjPed.AddPair('nmprimeiro', tbPessoa.FieldByName('nmprimeiro').AsString);
            jsonObjPed.AddPair('nmsegundo', tbPessoa.FieldByName('nmsegundo').AsString);

            //jsonObjPed.AddPair('dtregistro', TJSONDate.Create(tbPessoa.FieldByName('dtregistro').AsString));
//            jsonObjPed.AddPair('total', TJSONNumber.Create(500.25));
//            jsonObjPed.AddPair('pendente', TJSONBool.Create(true));

            // Itens...

            jsonArrayItem := TJSONArray.Create;
            for y := 1 to 2 do
            begin
              jsonObjItem := TJSONObject.Create;
              jsonObjItem.AddPair('idendereco', tbPessoa.FieldByName('idendereco').AsString);
              jsonObjItem.AddPair('dsuf',  tbPessoa.FieldByName('dsuf').AsString);
              jsonObjItem.AddPair('nmcidade', tbPessoa.FieldByName('nmcidade').AsString);
              jsonObjItem.AddPair('nmbairro',  tbPessoa.FieldByName('nmbairro').AsString);
              jsonObjItem.AddPair('nmlogradouro', tbPessoa.FieldByName('nmlogradouro').AsString);
              jsonObjItem.AddPair('dscomplemento', tbPessoa.FieldByName('nmlogradouro').AsString);

           //jsonObjItem.AddPair('nmcidade', TJSONNumber.Create(y));

              jsonArrayItem.AddElement(jsonObjItem);
            end;

            jsonObjPed.AddPair('itens', jsonArrayItem);


            jsonArrayPed.AddElement(jsonObjPed);
        end;

        Memo2.Lines.Clear;
        Memo2.Lines.Add(jsonArrayPed.ToString);

    finally
        jsonArrayPed.DisposeOf;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  jValue : TJSONValue;
begin
  RESTRequest.Execute;
  jValue := RESTResponse.JSONValue;
  tbPessoa.Open;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  lParams: TCollectionItem;
  lJSONObject: TJSONObject;
begin
  lJSONObject := TJSONObject.Create;
  try
    RESTClient.BaseURL := 'http://localhost:8080/datasnap/rest/TServerMethods1';
    RESTRequest.Method := TRESTRequestMethod.rmPOST;
    RESTRequest.Resource := '/pessoa';
    RESTRequest.AddBody(Memo1.Lines.Text);

    RESTRequest.Execute;
    ShowMessage(RestResponse.StatusText);
  finally
    FreeAndNil(lJSONObject);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  zObjPessoa : TPessoa_model;
  zObjEndereco : TEndereco_model;

  zJSONObject, zJSONObjEnd : TJSONObject;
  zJSONArray, zJSONArrayEnd : TJSONArray;

  zJsonStr : string;
  zEndereco : String;
begin
  zObjPessoa := TPessoa_model.Create;
  zJSONObject := TJSONObject.Create;
  zJSONObjEnd  := TJSONObject.Create;
  zJSONArray := TJSONArray.Create;
  zJSONArrayEnd := TJSONArray.Create;
  zObjEndereco := TEndereco_model.Create;

  Try
    zObjPessoa.idPessoa:= 0;
    zObjPessoa.flnatureza:= tbPessoa.FieldByName('flnatureza').AsInteger;
    zObjPessoa.nmsegundo:= tbPessoa.FieldByName('nmsegundo').AsString;
    zObjPessoa.nmsegundo:= tbPessoa.FieldByName('nmsegundo').AsString;
    zObjPessoa.dsdocumento:= tbPessoa.FieldByName('dsdocumento').AsString;

    // Aqui gera o json do endereco
//    zObjEndereco.idPessoa := 1;
//    zObjEndereco.idEndereco := 2;
//    zJSONObjEnd := TJson.ObjectToJsonObject(zObjEndereco);
//    zObjPessoa.endereco:= zJSONObjEnd.ToJSON;

    zJSONObject := TJson.ObjectToJsonObject(zObjPessoa);
    zJSONArray.Add(zJSONObject);

    Memo2.Clear;
    Memo2.Lines.Add(zJSONArray.ToJSON);
  Finally
    FreeAndNil(zObjEndereco);
    FreeAndNil(zObjPessoa);
  End;

end;

end.
