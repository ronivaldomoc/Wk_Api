unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, REST.Json, FireDAC.Phys.PGDef,
  FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.PG;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function pessoa(_idPessoa: String): TJSONArray;
    function updatePessoa(_value : TJSONArray): String;
    function cancelPessoa(_idPessoa: String): TJSONArray;

  end;
{$METHODINFO OFF}

implementation


{$R *.dfm}


uses System.StrUtils, Pessoa.ctrl, Data.DBXJSONReflect,
  Data.FireDACJSONReflect, Db_ctrl;

function TServerMethods1.cancelPessoa(_idPessoa: String): TJSONArray;
var
  zObjPessoa : TPessoa_ctrl;
  zJSONObject : TJSONObject;
  zJsonStr : string;
begin
  zObjPessoa := TPessoa_ctrl.Create;
  zJSONObject := TJSONObject.Create;
  Result := TJSONArray.Create;
  Try
    zObjPessoa.Model.idPessoa := StrToIntDef(_idPessoa,0);
    zObjPessoa.delete;
  Finally
    FreeAndNil(zObjPessoa);
  End;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TServerMethods1.updatePessoa(_value: TJSONArray): String;
var
  ArrayItem: TJSONArray;
  teste : string;
  x, j : integer;
  zObjPessoa : TPessoa_ctrl;
begin
  if _value.ClassType = TJSONArray then
   begin
      zObjPessoa := TPessoa_ctrl.Create;
      Try
        if _value.ClassType = TJSONArray then
        begin
          //ArrayPed := _value;
          for x := 0 to _value.Size - 1 do
          begin
            zObjPessoa.Model.idpessoa := StrToIntDef( _value.Get(x).GetValue<string>('idpessoa', '0'),0);
            zObjPessoa.Model.flnatureza := StrToIntDef(_value.Get(x).GetValue<string>('flnatureza', '0'),0);
            zObjPessoa.Model.dsdocumento := _value.Get(x).GetValue<string>('dsdocumento', '');
            zObjPessoa.Model.nmprimeiro := _value.Get(x).GetValue<string>('nmprimeiro', '');
            zObjPessoa.Model.nmsegundo := _value.Get(x).GetValue<string>('nmsegundo', '');

            ArrayItem := _value.Get(x).GetValue<TJsonArray>('endereco');
            for j := 0 to ArrayItem.Size - 1 do
             begin
               // poderia criar uma lista de endere�os mas n�o foi possivel devido ao tempo disponivel para teste
               zObjPessoa.Endereco.Model.idendereco := StrToIntDef(ArrayItem.Get(J).GetValue<string>('idendereco', '0'),0);
               zObjPessoa.Endereco.Model.dscep := ArrayItem.Get(J).GetValue<string>('dscep', 'TESTE');
               zObjPessoa.Endereco.Endereco_integra.model.idendereco := StrToIntDef(ArrayItem.Get(J).GetValue<string>('idendereco', ''),0);
               zObjPessoa.Endereco.Endereco_integra.model.dsuf := ArrayItem.Get(J).GetValue<string>('dsuf', '');
               zObjPessoa.Endereco.Endereco_integra.model.nmcidade := ArrayItem.Get(J).GetValue<string>('nmcidade', '');
               zObjPessoa.Endereco.Endereco_integra.model.nmbairro := ArrayItem.Get(J).GetValue<string>('nmbairro', '');
               zObjPessoa.Endereco.Endereco_integra.model.nmlogradouro := ArrayItem.Get(J).GetValue<string>('nmlogradouro', '');
               zObjPessoa.Endereco.Endereco_integra.model.dscomplemento := ArrayItem.Get(J).GetValue<string>('dscomplemento', '');
             end;

            zObjPessoa.insert;
          end;
        end;
      finally
        //FreeAndNil(ArrayPed);
        FreeAndNil(zObjPessoa);
      end;
   end;
end;

function TServerMethods1.pessoa(_idPessoa: String): TJSONArray;
var
  jsonObjPessoa, jsonObjItem: TJSONObject;
  jsonArrayItem, jsonArrayPessoa: TJSONArray;
  x, y : integer;
  zObjPessoa : TPessoa_ctrl;
begin
 zObjPessoa := TPessoa_ctrl.Create;
 Result := TJSONArray.Create;
 try
  if zObjPessoa.executa_sql then
   begin
     while not zObjPessoa.db.qryTemp.Eof do
       begin
         zObjPessoa.getItem;
         jsonArrayPessoa := TJSONArray.Create;
         jsonObjPessoa := TJSONObject.Create;
         jsonObjPessoa.AddPair('idpessoa', zObjPessoa.Model.idPessoa.ToString);
         jsonObjPessoa.AddPair('flnatureza', zObjPessoa.Model.flnatureza.ToString);
         jsonObjPessoa.AddPair('dsdocumento', zObjPessoa.Model.dsdocumento );
         jsonObjPessoa.AddPair('nmprimeiro', zObjPessoa.Model.nmprimeiro);
         jsonObjPessoa.AddPair('nmsegundo', zObjPessoa.Model.nmsegundo);
         jsonObjPessoa.AddPair('dtregistro', zObjPessoa.Model.dtregistro);

         zObjPessoa.Endereco.Model.idPessoa := zObjPessoa.Model.idPessoa;
         zObjPessoa.Endereco.getEndereco;
         jsonArrayItem := TJSONArray.Create;
         for y := 1 to 1 do // Se tiver mais endere�os so implementar aqui
          begin
            jsonObjItem := TJSONObject.Create;
            jsonObjItem.AddPair('idendereco', zObjPessoa.Endereco.Endereco_integra.Model.idendereco.ToString);
            jsonObjItem.AddPair('dsuf', zObjPessoa.Endereco.Endereco_integra.Model.dsuf);
            jsonObjItem.AddPair('nmcidade', zObjPessoa.Endereco.Endereco_integra.Model.dsuf);
            jsonObjItem.AddPair('nmbairro', zObjPessoa.Endereco.Endereco_integra.Model.nmbairro);
            jsonObjItem.AddPair('nmlogradouro', zObjPessoa.Endereco.Endereco_integra.Model.nmlogradouro);
            jsonObjItem.AddPair('dscomplemento',zObjPessoa.Endereco.Endereco_integra.Model.dscomplemento);
            jsonArrayItem.AddElement(jsonObjItem);
          end;
         jsonObjPessoa.AddPair('endereco', jsonArrayItem);
         jsonArrayPessoa.AddElement(jsonObjPessoa);
         Result.Add(jsonObjPessoa);

         zObjPessoa.db.qryTemp.Next;
       end;
     //Result := jsonArrayPed;
   end;
 finally
  FreeAndNil(zObjPessoa);
 end;

//var
//  zObjPessoa : TPessoa_ctrl;
//  zJSONObject : TJSONObject;
//  zJsonStr : string;
//begin
// //http://localhost:8080/datasnap/rest/TServerMethods1/getPessoas
//  zObjPessoa := TPessoa_ctrl.Create;
//  zJSONObject := TJSONObject.Create;
//  Result := TJSONArray.Create;
//  Try
//    zObjPessoa.Model.idPessoa := StrToIntDef(_idPessoa,0);
//    if zObjPessoa.executa_sql then
//     begin
//      while not zObjPessoa.db.qryTemp.Eof do
//       begin
//         zObjPessoa.getItem;
//         zJSONObject := TJson.ObjectToJsonObject(zObjPessoa.Model);
//         Result.Add(zJSONObject);
//         zObjPessoa.db.qryTemp.Next;
//       end;
//     end;
//  Finally
//    FreeAndNil(zObjPessoa);
//  End;
end;

//function TServerMethods1.updatePessoa(_value : TJSONArray): String;
//var
//  i : Integer;
//  zObjPessoa : TPessoa_ctrl;
//  zSonValue : TJSONValue;
//  zJsonStr : string;
//
//  zJSONDataSets : TFDJSONDataSets;
//  zJsonObject: TJSonObject;
//begin
//  zObjPessoa := TPessoa_ctrl.Create;
//  zJSONDataSets := TFDJSONDataSets.Create;
//  try
//    Try
//
//       if _value.ClassType = TJSONArray then
//          begin
//            zJsonStr := _value.Items[0].ToJSON;
//            for i := 0 to _value.Size - 1 do
//             begin
//              zJSonObject := _value.Items[i] as TJSONObject;
//              zObjPessoa.Model.idpessoa := StrToIntDef(zJsonObject.GetValue('idpessoa').Value,0);
//              zObjPessoa.Model.flnatureza := StrToIntDef(zJsonObject.GetValue('flnatureza').Value,0);
//              zObjPessoa.Model.dsdocumento := zJsonObject.GetValue('dsdocumento').Value;
//              zObjPessoa.Model.nmprimeiro := zJsonObject.GetValue('nmprimeiro').Value;
//              zObjPessoa.Model.nmsegundo := zJsonObject.GetValue('nmsegundo').Value;
//              zObjPessoa.insert;
//             end;
//          end;
//      Result := '200';//_value;
//    except
//      Result := '400 - O conte�do da mensagem n�o � um valor JSON v�lido. ';//_value;
//    End;
//  finally
//    FreeAndNil(zJSONDataSets);
//    FreeAndNil(zObjPessoa);
//  end;
//end;

end.

