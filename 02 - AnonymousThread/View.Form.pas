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
    OpenDialog: TOpenDialog;
    Bevel: TBevel;
    BitBtnCompactar: TBitBtn;
    procedure BitBtnCompactarClick(Sender: TObject);
    procedure SpeedButtonProcurarClick(Sender: TObject);
  private
    // Opcionalmente, este método pode ser utilizado como função anônima
    procedure Compactar;
  end;

var
  Formulario: TFormulario;

implementation

uses
  System.UITypes, System.IOUtils, System.Zip;

{$R *.dfm}

procedure TFormulario.BitBtnCompactarClick(Sender: TObject);
begin
  // Anonymous Thread evita a declaração de uma classe herdada de TThread
  TThread.CreateAnonymousThread(
    procedure
    var
      ZipFile: TZipFile;
    begin
      ZipFile := TZipFile.Create;
      try
        ZipFile.Open(TPath.Combine(GetCurrentDir, 'Compactado.zip'), zmWrite);
        ZipFile.Add(OpenDialog.FileName);

        MessageDlg('Compactação concluída!', mtInformation, [mbOK], 0);
      finally
        ZipFile.Free;
      end;
    end).Start;
end;

procedure TFormulario.SpeedButtonProcurarClick(Sender: TObject);
begin
  OpenDialog.Execute;
  EditArquivoCompactacao.Text := OpenDialog.FileName;
end;

{$REGION 'Procedure Compactar'}
procedure TFormulario.Compactar;
var
  ZipFile: TZipFile;
begin
  ZipFile := TZipFile.Create;
  try
    ZipFile.Open(TPath.Combine(GetCurrentDir, 'Compactado.zip'), zmWrite);
    ZipFile.Add(OpenDialog.FileName);

    MessageDlg('Compactação concluída!', mtInformation, [mbOK], 0);
  finally
    ZipFile.Free;
  end;
end;
{$ENDREGION}

end.
