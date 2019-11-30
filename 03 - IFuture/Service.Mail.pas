unit Service.Mail;

interface

type
  // Classe para representar o retorno do envio do e-mail
  TMailStatus = class
  private
    FSucesso: boolean;
    FMensagem: string;
  public
    property Sucesso: boolean read FSucesso write FSucesso;
    property Mensagem: string read FMensagem write FMensagem;
  end;

  // Classe para envio de e-mail utilizando o Hotmail
  TMailService = class
  public
    function EnviarEmail: TMailStatus;
  end;

implementation

uses
  System.SysUtils, IdSMTP, IdSSLOpenSSL, IdMessage, IdText,
  IdExplicitTLSClientServerBase;

{ TEnvioEmail }

function TMailService.EnviarEmail: TMailStatus;
var
  IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
  IdSMTP: TIdSMTP;
  IdMessage: TIdMessage;
  IdText: TIdText;
begin
  result := TMailStatus.Create;
  result.Sucesso := False;

  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdSMTP := TIdSMTP.Create(nil);
  IdMessage := TIdMessage.Create(nil);

  try
    IdSSLIOHandlerSocket.SSLOptions.Method := sslvTLSv1;
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

    IdSMTP.IOHandler := IdSSLIOHandlerSocket;
    IdSMTP.UseTLS := utUseExplicitTLS;
    IdSMTP.AuthType := satDefault;
    IdSMTP.Port := 587;
    IdSMTP.Host := 'smtp.live.com';
    IdSMTP.Username := 'usuario@hotmail.com';
    IdSMTP.Password := 'senha';

    IdMessage.From.Address := 'remetente@hotmail.com';
    IdMessage.From.Name := 'Remetente';
    IdMessage.ReplyTo.EMailAddresses := IdMessage.From.Address;
    IdMessage.Recipients.Add.Text := 'destinatario@gmail.com';
    IdMessage.Subject := 'E-mail Teste - TDC';
    IdMessage.Encoding := meMIME;

    IdText := TIdText.Create(IdMessage.MessageParts);
    IdText.Body.Add('Corpo do e-mail');
    IdText.ContentType := 'text/plain; charset=iso-8859-1';

    try
      IdSMTP.Connect;
      IdSMTP.Authenticate;
      IdSMTP.Send(IdMessage);

      result.Sucesso := True;
      result.Mensagem := 'E-mail enviado com sucesso!';
    except
      on E:Exception do
        result.Mensagem := E.Message;
    end;
  finally
    IdSMTP.Disconnect;
    UnLoadOpenSSLLibrary;
    IdMessage.Free;
    IdSSLIOHandlerSocket.Free;
    IdSMTP.Free;
  end;
end;

end.
