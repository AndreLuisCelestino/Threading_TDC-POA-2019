object Formulario: TFormulario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Exemplo de TParallel.For'
  ClientHeight = 367
  ClientWidth = 703
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonImportar: TButton
    Left = 8
    Top = 8
    Width = 180
    Height = 25
    Caption = 'Importar Arquivo'
    TabOrder = 0
    OnClick = ButtonImportarClick
  end
  object DBGrid: TDBGrid
    Left = 8
    Top = 141
    Width = 689
    Height = 223
    DataSource = DataSource
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cidade'
        Width = 160
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Email'
        Width = 160
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Empresa'
        Width = 130
        Visible = True
      end>
  end
  object Memo: TMemo
    Left = 8
    Top = 39
    Width = 689
    Height = 91
    TabOrder = 2
  end
  object ButtonImportarParalelo: TButton
    Left = 194
    Top = 8
    Width = 180
    Height = 25
    Caption = 'Importar Arquivo (TParallel.For)'
    TabOrder = 3
    OnClick = ButtonImportarParaleloClick
  end
  object ButtonLimpar: TButton
    Left = 620
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 4
    OnClick = ButtonLimparClick
  end
  object ClientDataSet: TClientDataSet
    PersistDataPacket.Data = {
      8F0000009619E0BD0100000018000000050000000000030000008F0002494404
      00010000000000044E6F6D650100490000000100055749445448020002006400
      06436964616465010049000000010005574944544802000200640005456D6169
      6C010049000000010005574944544802000200640007456D7072657361010049
      00000001000557494454480200020064000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 312
    object ClientDataSetID: TIntegerField
      FieldName = 'ID'
    end
    object ClientDataSetNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object ClientDataSetCidade: TStringField
      FieldName = 'Cidade'
      Size = 100
    end
    object ClientDataSetEmail: TStringField
      FieldName = 'Email'
      Size = 100
    end
    object ClientDataSetEmpresa: TStringField
      FieldName = 'Empresa'
      Size = 100
    end
  end
  object DataSource: TDataSource
    DataSet = ClientDataSet
    Left = 112
    Top = 312
  end
end
