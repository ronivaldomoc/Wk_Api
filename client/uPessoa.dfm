object fPessoas: TfPessoas
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Pessoas'
  ClientHeight = 333
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 21
    Top = 17
    Width = 553
    Height = 137
    Caption = 'Dados Pessoais'
    Enabled = False
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 21
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 224
      Top = 21
      Width = 49
      Height = 13
      Caption = 'flnatureza'
      FocusControl = cxDBSpinEdit2
    end
    object Label3: TLabel
      Left = 367
      Top = 21
      Width = 54
      Height = 13
      Caption = 'Documento'
      FocusControl = cxDBTextEdit1
    end
    object Label4: TLabel
      Left = 24
      Top = 72
      Width = 68
      Height = 13
      Caption = 'Primeiro Nome'
      FocusControl = cxDBTextEdit2
    end
    object Label5: TLabel
      Left = 278
      Top = 75
      Width = 72
      Height = 13
      Caption = 'Segundo Nome'
      FocusControl = cxDBTextEdit3
    end
    object Label6: TLabel
      Left = 97
      Top = 21
      Width = 85
      Height = 13
      Caption = 'Data do Cadastro'
    end
    object cxDBSpinEdit2: TcxDBSpinEdit
      Left = 224
      Top = 37
      DataBinding.DataField = 'flnatureza'
      DataBinding.DataSource = dsPessoa
      TabOrder = 0
      Width = 121
    end
    object cxDBTextEdit1: TcxDBTextEdit
      Left = 367
      Top = 37
      DataBinding.DataField = 'dsdocumento'
      DataBinding.DataSource = dsPessoa
      TabOrder = 1
      Width = 121
    end
    object cxDBTextEdit2: TcxDBTextEdit
      Left = 24
      Top = 91
      DataBinding.DataField = 'nmprimeiro'
      DataBinding.DataSource = dsPessoa
      TabOrder = 2
      Width = 248
    end
    object cxDBTextEdit3: TcxDBTextEdit
      Left = 278
      Top = 91
      DataBinding.DataField = 'nmsegundo'
      DataBinding.DataSource = dsPessoa
      TabOrder = 3
      Width = 258
    end
    object cxDBTextEdit9: TcxDBTextEdit
      Left = 97
      Top = 37
      DataBinding.DataField = 'dtregistro'
      DataBinding.DataSource = dsPessoa
      Enabled = False
      TabOrder = 4
      Width = 121
    end
    object cxDBTextEdit10: TcxDBTextEdit
      Left = 24
      Top = 37
      DataBinding.DataField = 'idpessoa'
      DataBinding.DataSource = dsPessoa
      Enabled = False
      TabOrder = 5
      Width = 67
    end
  end
  object GroupBox2: TGroupBox
    Left = 21
    Top = 160
    Width = 553
    Height = 121
    Caption = 'Endere'#231'o'
    Enabled = False
    TabOrder = 1
    object Label7: TLabel
      Left = 121
      Top = 16
      Width = 33
      Height = 13
      Caption = 'Cidade'
      FocusControl = cxDBTextEdit4
    end
    object Label8: TLabel
      Left = 248
      Top = 16
      Width = 33
      Height = 13
      Caption = 'Estado'
      FocusControl = cxDBTextEdit5
    end
    object Label9: TLabel
      Left = 327
      Top = 13
      Width = 28
      Height = 13
      Caption = 'Bairro'
      FocusControl = cxDBTextEdit6
    end
    object Label10: TLabel
      Left = 17
      Top = 64
      Width = 55
      Height = 13
      Caption = 'Logradouro'
      FocusControl = dbeEndereco
    end
    object Label11: TLabel
      Left = 385
      Top = 64
      Width = 65
      Height = 13
      Caption = 'Complemento'
      FocusControl = cxDBTextEdit8
    end
    object Label12: TLabel
      Left = 16
      Top = 16
      Width = 19
      Height = 13
      Caption = 'CEP'
      FocusControl = dbedtCep
    end
    object cxDBTextEdit4: TcxDBTextEdit
      Left = 121
      Top = 32
      DataBinding.DataField = 'nmcidade'
      DataBinding.DataSource = dsPessoa
      TabOrder = 1
      Width = 121
    end
    object cxDBTextEdit5: TcxDBTextEdit
      Left = 248
      Top = 32
      DataBinding.DataField = 'dsuf'
      DataBinding.DataSource = dsPessoa
      TabOrder = 2
      Width = 73
    end
    object cxDBTextEdit6: TcxDBTextEdit
      Left = 327
      Top = 32
      DataBinding.DataField = 'nmbairro'
      DataBinding.DataSource = dsPessoa
      TabOrder = 3
      Width = 195
    end
    object dbeEndereco: TcxDBTextEdit
      Left = 17
      Top = 80
      DataBinding.DataField = 'nmlogradouro'
      DataBinding.DataSource = dsPessoa
      TabOrder = 4
      Width = 362
    end
    object cxDBTextEdit8: TcxDBTextEdit
      Left = 385
      Top = 80
      DataBinding.DataField = 'dscomplemento'
      DataBinding.DataSource = dsPessoa
      TabOrder = 5
      Width = 121
    end
    object dbedtCep: TcxDBTextEdit
      Left = 16
      Top = 32
      DataBinding.DataField = 'idendereco'
      DataBinding.DataSource = dsPessoa
      TabOrder = 0
      OnExit = dbedtCepExit
      Width = 76
    end
    object btnBuscarEndreco: TButton
      Left = 96
      Top = 32
      Width = 20
      Height = 21
      Caption = '...'
      TabOrder = 6
      TabStop = False
      OnClick = btnBuscarEndrecoClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 292
    Width = 591
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btNovo: TButton
      Left = 256
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btNovoClick
    end
    object btGravar: TButton
      Left = 337
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Gravar'
      Enabled = False
      TabOrder = 1
      OnClick = btGravarClick
    end
    object btCancelar: TButton
      Left = 418
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      Enabled = False
      TabOrder = 2
      OnClick = btCancelarClick
    end
    object btExcluir: TButton
      Left = 499
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 3
      OnClick = btExcluirClick
    end
    object btPesquisar: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 4
      OnClick = btPesquisarClick
    end
  end
  object dsPessoa: TDataSource
    DataSet = dm.tbPessoa
    OnDataChange = dsPessoaDataChange
    Left = 496
    Top = 160
  end
  object ACBrEnterTab1: TACBrEnterTab
    EnterAsTab = True
    Left = 456
    Top = 159
  end
end
