unit View.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormulario = class(TForm)
    EditArquivoCompactacao: TEdit;
    LabelArquivoCompactacao: TLabel;
    SpeedButtonProcurar: TSpeedButton;
    Bevel: TBevel;
    BitBtnCompactar: TBitBtn;
    OpenDialog: TOpenDialog;
    procedure BitBtnCompactarClick(Sender: TObject);
    procedure SpeedButtonProcurarClick(Sender: TObject);
  end;

var
  Formulario: TFormulario;

implementation

uses
  Thread.ZipFile;

{$R *.dfm}

procedure TFormulario.BitBtnCompactarClick(Sender: TObject);
var
  ZipFileThread: TZipFileThread;
begin
  ZipFileThread := TZipFileThread.Create(OpenDialog.FileName);
  ZipFileThread.FreeOnTerminate := True;
  ZipFileThread.Start;
end;

procedure TFormulario.SpeedButtonProcurarClick(Sender: TObject);
begin
  OpenDialog.Execute;
  EditArquivoCompactacao.Text := OpenDialog.FileName;
end;

end.
