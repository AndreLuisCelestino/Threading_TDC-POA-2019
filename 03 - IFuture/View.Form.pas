unit View.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Notification,
  Vcl.StdCtrls, Vcl.ComCtrls, System.Threading, Service.Mail;

type
  TFormulario = class(TForm)
    Timer: TTimer;
    NotificationCenter: TNotificationCenter;
    ButtonEnviarEmail: TButton;
    procedure ButtonEnviarEmailClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    Future: IFuture<TMailStatus>;

    // Método para exibir uma notificação usando TNotificationCenter
    procedure ExibirNotificacao(const aMensagem: string);
  end;

var
  Formulario: TFormulario;

implementation

{$R *.dfm}

procedure TFormulario.ButtonEnviarEmailClick(Sender: TObject);
begin
  // Cria um Future Object para enviar o e-mail e armazenar o retorno
  Future := TTask.Future<TMailStatus>(
    function: TMailStatus
    var
      EmailService: TMailService;
    begin
      try
        EmailService := TMailService.Create;
        result := EmailService.EnviarEmail;
      finally
        EmailService.Free;
      end;
    end);

  ExibirNotificacao('Envio de e-mail em andamento...');

  // O Timer é utilizado para "monitorar" o status do Future Object
  Timer.Enabled := True;
end;

procedure TFormulario.ExibirNotificacao(const aMensagem: string);
var
  Notification: TNotification;
begin
  Notification := NotificationCenter.CreateNotification;
  try
    Notification.Title := 'Serviço de e-mail';
    Notification.AlertBody := aMensagem;
    NotificationCenter.PresentNotification(Notification);
  finally
    Notification.Free;
  end;
end;

procedure TFormulario.TimerTimer(Sender: TObject);
begin
  // Testa o status do Future Object
  if Future.Status <> TTaskStatus.Completed then
    Exit;

  ExibirNotificacao(Future.Value.Mensagem);
  Timer.Enabled := False;
end;

end.
