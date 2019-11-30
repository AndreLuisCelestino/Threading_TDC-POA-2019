object Formulario: TFormulario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Exemplo de IFuture'
  ClientHeight = 66
  ClientWidth = 274
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
  object ButtonEnviarEmail: TButton
    Left = 72
    Top = 8
    Width = 140
    Height = 49
    Caption = 'Enviar E-mail!'
    TabOrder = 0
    OnClick = ButtonEnviarEmailClick
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 16
    Top = 8
  end
  object NotificationCenter: TNotificationCenter
    Left = 216
    Top = 8
  end
end
