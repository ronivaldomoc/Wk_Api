object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 151
  Width = 230
  object tbPessoa: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 55
    Top = 16
    object tbPessoaidpessoa: TIntegerField
      FieldName = 'idpessoa'
    end
    object tbPessoaflnatureza: TIntegerField
      FieldName = 'flnatureza'
    end
    object tbPessoadsdocumento: TStringField
      FieldName = 'dsdocumento'
    end
    object tbPessoanmprimeiro: TStringField
      FieldName = 'nmprimeiro'
    end
    object tbPessoanmsegundo: TStringField
      FieldName = 'nmsegundo'
      Size = 100
    end
    object tbPessoaidendereco: TIntegerField
      FieldName = 'idendereco'
      DisplayFormat = '00000000'
    end
    object tbPessoanmcidade: TStringField
      FieldName = 'nmcidade'
      Size = 100
    end
    object tbPessoadsuf: TStringField
      FieldName = 'dsuf'
      Size = 50
    end
    object tbPessoanmbairro: TStringField
      FieldName = 'nmbairro'
      Size = 50
    end
    object tbPessoanmlogradouro: TStringField
      FieldName = 'nmlogradouro'
      Size = 100
    end
    object tbPessoadtregistro: TStringField
      FieldName = 'dtregistro'
      Size = 30
    end
    object tbPessoadscomplemento: TStringField
      FieldName = 'dscomplemento'
      Size = 50
    end
  end
  object dsPessoa: TDataSource
    DataSet = tbPessoa
    Left = 103
    Top = 16
  end
  object RESTClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:8080/datasnap/rest/TServerMethods1/pessoa'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 24
    Top = 72
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 64
    Top = 72
  end
  object RESTResponse: TRESTResponse
    ContentType = 'application/json'
    Left = 96
    Top = 72
  end
end
