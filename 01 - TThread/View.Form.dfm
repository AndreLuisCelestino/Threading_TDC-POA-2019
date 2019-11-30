object Formulario: TFormulario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Exemplo de TThread'
  ClientHeight = 65
  ClientWidth = 449
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
  object LabelArquivoCompactacao: TLabel
    Left = 8
    Top = 11
    Width = 132
    Height = 13
    Caption = 'Arquivo para compacta'#231#227'o:'
  end
  object SpeedButtonProcurar: TSpeedButton
    Left = 282
    Top = 26
    Width = 23
    Height = 23
    Caption = '...'
    OnClick = SpeedButtonProcurarClick
  end
  object Bevel: TBevel
    Left = 320
    Top = 8
    Width = 3
    Height = 52
    Shape = bsLeftLine
  end
  object EditArquivoCompactacao: TEdit
    Left = 8
    Top = 27
    Width = 273
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object BitBtnCompactar: TBitBtn
    Left = 338
    Top = 13
    Width = 97
    Height = 43
    Caption = 'Compactar'
    TabOrder = 1
    OnClick = BitBtnCompactarClick
  end
  object OpenDialog: TOpenDialog
    InitialDir = 'D:\TDC-POA\Assets'
    Left = 232
  end
end
