program TTask;

uses
  Vcl.Forms,
  View.Form in 'View.Form.pas' {Formulario};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormulario, Formulario);
  Application.Run;
end.
