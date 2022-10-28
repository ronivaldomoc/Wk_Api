object fPesquisa: TfPesquisa
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pesquisar'
  ClientHeight = 339
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 568
    Height = 339
    Align = alClient
    DataSource = dsPessoa
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'idpessoa'
        Title.Caption = 'C'#243'digo'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dtregistro'
        Title.Caption = 'Dt. Cadastro'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nmprimeiro'
        Title.Caption = 'Primeiro Nome'
        Width = 300
        Visible = True
      end>
  end
  object dsPessoa: TDataSource
    DataSet = dm.tbPessoa
    Left = 88
    Top = 80
  end
end
