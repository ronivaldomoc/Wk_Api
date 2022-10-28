unit uDm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Types, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  Tdm = class(TDataModule)
    tbPessoa: TFDMemTable;
    dsPessoa: TDataSource;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    tbPessoaidpessoa: TIntegerField;
    tbPessoaflnatureza: TIntegerField;
    tbPessoadsdocumento: TStringField;
    tbPessoanmprimeiro: TStringField;
    tbPessoanmsegundo: TStringField;
    tbPessoaidendereco: TIntegerField;
    tbPessoanmcidade: TStringField;
    tbPessoadsuf: TStringField;
    tbPessoanmbairro: TStringField;
    tbPessoanmlogradouro: TStringField;
    tbPessoadtregistro: TStringField;
    tbPessoadscomplemento: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure getPessoas;
    procedure deletePessoas;
    //procedure updtePessoas;
    procedure updtePessoa;
    procedure getEndereco(_cep : String);

  end;

var
  dm: Tdm;


implementation

uses
  System.JSON, Pessoa.model, REST.Json, Vcl.Forms, Winapi.Windows;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tdm }

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  RESTClient.BaseURL := 'http://localhost:8080/datasnap/rest/TServerMethods1';
end;

procedure Tdm.deletePessoas;
var
  lParams: TCollectionItem;
  lJSONObject: TJSONObject;
begin
  lJSONObject := TJSONObject.Create;
  try
    RESTRequest.Method := TRESTRequestMethod.rmDELETE;
    RESTRequest.Resource := '/pessoa/'+tbPessoaidpessoa.AsString;
    RESTRequest.Execute;
  finally
    FreeAndNil(lJSONObject);
  end;
end;

procedure Tdm.getEndereco(_cep: String);
var
  vJsonObj : TJSONObject;
  vRESTClient: TRESTClient;
  vRESTRequest: TRESTRequest;
  vRESTResponse: TRESTResponse;
begin

  Try
    _cep := StringReplace(_cep,'-', '',[rfReplaceAll, rfIgnoreCase]);
    if _cep.Trim = '' then
     Exit;

    vRESTClient:= TRESTClient.Create(nil);
    vRESTRequest:= TRESTRequest.Create(nil);
    vRESTResponse:= TRESTResponse.Create(nil);
    Try
      vRESTClient.BaseURL := 'http://viacep.com.br/ws';
      vRESTRequest.Method := TRESTRequestMethod.rmGET;
      vRESTRequest.Resource := _cep+'/json';
      vRESTRequest.Client := vRESTClient;
      vRESTRequest.Response := vRESTResponse;

      vRESTRequest.Execute;
      vJsonObj := TJSONObject.ParseJSONValue(vRESTResponse.Content) as TJSONObject;
      tbPessoanmbairro.AsString := vJsonObj.GetValue('bairro').Value;
      tbPessoanmcidade.AsString := vJsonObj.GetValue('localidade').Value;
      tbPessoadsuf.AsString := vJsonObj.GetValue('uf').Value;
      tbPessoanmlogradouro.AsString := vJsonObj.GetValue('logradouro').Value;
    Finally
      FreeAndNil(vRESTResponse);
      FreeAndNil(vRESTRequest);
      FreeAndNil(vRESTClient);
    End;

  Except
     On e : Exception do
       begin
         Application.MessageBox('Não foi possível localizar o CEP.', 'Atenção', MB_OK + MB_ICONINFORMATION);
         exit;
       end;
  End;
end;

procedure Tdm.getPessoas;
var
  x, j :Integer;
  jValue : TJSONValue;
  ArrayPessoa, ArrayItem: TJSONArray;
begin
  Try
    RESTRequest.Method := TRESTRequestMethod.rmGET;
    RESTRequest.Resource := '/pessoa';
    RESTRequest.Execute;
    jValue := RESTResponse.JSONValue;

    tbPessoa.Close;
    tbPessoa.CreateDataSet;
    //tbPessoa.Open;

    ArrayPessoa := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(jValue.ToJSON), 0) as TJSONArray;
    for x := 0 to ArrayPessoa.Size - 1 do
      begin
        tbPessoa.Insert;
        tbPessoaidpessoa.AsInteger := ArrayPessoa.Get(x).GetValue<integer>('idpessoa', 0);
        tbPessoaflnatureza.AsInteger := ArrayPessoa.Get(x).GetValue<integer>('flnatureza', 0);
        tbPessoadsdocumento.AsString := ArrayPessoa.Get(x).GetValue<string>('dsdocumento','');
        tbPessoanmprimeiro.AsString := ArrayPessoa.Get(x).GetValue<string>('nmprimeiro', '');
        tbPessoanmsegundo.AsString := ArrayPessoa.Get(x).GetValue<string>('nmsegundo', '');
        tbPessoadtregistro.AsString := ArrayPessoa.Get(x).GetValue<string>('dtregistro', '');

        ArrayItem := ArrayPessoa.Get(x).GetValue<TJsonArray>('endereco');
        for j := 0 to ArrayItem.Size - 1 do // Impentar varios enderecos aqui
          begin
            tbPessoaidendereco.AsString := ArrayItem.Get(j).GetValue<string>('idendereco','');
            tbPessoanmcidade.AsString := ArrayItem.Get(j).GetValue<string>('nmcidade', '');
            tbPessoadsuf.AsString := ArrayItem.Get(j).GetValue<string>('dsuf', '');
            tbPessoanmbairro.AsString := ArrayItem.Get(j).GetValue<string>('nmbairro', '');
            tbPessoanmlogradouro.AsString := ArrayItem.Get(j).GetValue<string>('nmlogradouro', '');
            tbPessoadscomplemento.AsString := ArrayItem.Get(j).GetValue<string>('dscomplemento', '');
          end;
       tbPessoa.Post;
      end;

    FreeAndNil(ArrayPessoa);
  Except
   On e : Exception do
     begin
       Application.MessageBox('Não foi possível buscar os dados', 'Atenção', MB_OK + MB_ICONINFORMATION);
       exit;
     end;
  End;
end;


procedure Tdm.updtePessoa;
var
  jsonObjPessoa, jsonObjItem: TJSONObject;
  jsonArrayItem, jsonArrayPessoa: TJSONArray;
  x, y : integer;
begin
  jsonObjPessoa := TJSONObject.Create;
  jsonArrayPessoa := TJSONArray.Create;
  jsonArrayItem := TJSONArray.Create;
  try
    jsonObjPessoa.AddPair('idpessoa', dm.tbPessoa.FieldByName('idpessoa').AsString);
    jsonObjPessoa.AddPair('flnatureza', dm.tbPessoa.FieldByName('flnatureza').AsString);
    jsonObjPessoa.AddPair('dsdocumento', dm.tbPessoa.FieldByName('dsdocumento').AsString);
    jsonObjPessoa.AddPair('nmprimeiro', dm.tbPessoa.FieldByName('nmprimeiro').AsString);
    jsonObjPessoa.AddPair('nmsegundo', dm.tbPessoa.FieldByName('nmsegundo').AsString);

    for y := 1 to 1 do // Se tiver mais edereços so implementar aqui
      begin
        jsonObjItem := TJSONObject.Create;
        jsonObjItem.AddPair('idendereco', dm.tbPessoa.FieldByName('idendereco').AsString);
        jsonObjItem.AddPair('dsuf',  dm.tbPessoa.FieldByName('dsuf').AsString);
        jsonObjItem.AddPair('nmcidade', dm.tbPessoa.FieldByName('nmcidade').AsString);
        jsonObjItem.AddPair('nmbairro',  dm.tbPessoa.FieldByName('nmbairro').AsString);
        jsonObjItem.AddPair('nmlogradouro', dm.tbPessoa.FieldByName('nmlogradouro').AsString);
        jsonObjItem.AddPair('dscomplemento',dm.tbPessoa.FieldByName('dscomplemento').AsString);
        jsonArrayItem.AddElement(jsonObjItem);
      end;

    jsonObjPessoa.AddPair('endereco', jsonArrayItem);
    jsonArrayPessoa.AddElement(jsonObjPessoa);

    RESTRequest.Method := TRESTRequestMethod.rmPOST;
    RESTRequest.Resource := '/pessoa';
    RESTRequest.Body.ClearBody;
    RESTRequest.AddBody(jsonArrayPessoa.ToString);
    RESTRequest.Execute;

  finally
    FreeAndNil(jsonArrayPessoa);
  end;
end;

//procedure Tdm.updtePessoas;
//var
//  zObjPessoa: TPessoa_model;
//  zJSONObject, zJSbjEnd: TJSONObject;
//  zJSONArray: TJSONArray;
//begin
//  zObjPessoa := TPessoa_model.Create;
//  zJSONObject := TJSONObject.Create;
//  zJSbjEnd := TJSONObject.Create;
//  zJSONArray := TJSONArray.Create;
//  Try
//    zObjPessoa.idPessoa:= tbPessoa.FieldByName('idPessoa').AsInteger;;
//    zObjPessoa.flnatureza:= tbPessoa.FieldByName('flnatureza').AsInteger;
//    zObjPessoa.nmprimeiro:= tbPessoa.FieldByName('nmprimeiro').AsString;
//    zObjPessoa.nmsegundo:= tbPessoa.FieldByName('nmsegundo').AsString;
//    zObjPessoa.dsdocumento:= tbPessoa.FieldByName('dsdocumento').AsString;
//    zObjPessoa.dtregistro:= tbPessoa.FieldByName('dtregistro').AsString;
//
//    zJSONObject := TJson.ObjectToJsonObject(zObjPessoa);
//    zJSONArray.Add(zJSONObject);
//
//    RESTClient.BaseURL := 'http://localhost:8080/datasnap/rest/TServerMethods1';
//    RESTRequest.Method := TRESTRequestMethod.rmPOST;
//    RESTRequest.Resource := '/pessoa';
//    RESTRequest.AddBody(zJSONArray.ToJSON);
//    RESTRequest.Execute;
//  Finally
//    FreeAndNil(zObjPessoa);
//    FreeAndNil(zJSONObject);
//    FreeAndNil(zJSbjEnd);
//    FreeAndNil(zJSONArray);
//  End;
//end;

end.
