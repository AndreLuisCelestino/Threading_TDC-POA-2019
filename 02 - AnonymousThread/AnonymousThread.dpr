program AnonymousThread;

uses
  Vcl.Forms,
  View.Form in 'View.Form.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormulario, Formulario);
  Application.Run;
end.
