program TThread;

uses
  Vcl.Forms,
  View.Form in 'View.Form.pas' {Formulario},
  Thread.ZipFile in 'Thread.ZipFile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormulario, Formulario);
  Application.Run;
end.
