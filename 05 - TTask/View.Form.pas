unit View.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, Vcl.StdCtrls, Vcl.Buttons;

type
  TFormulario = class(TForm)
    frxReport: TfrxReport;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    FTexto: TStringBuilder;

    procedure ConsultarDadosCliente;
    procedure ConsultarDadosPedido;
    procedure ConsultarDadosItensPedido;
  end;

var
  Formulario: TFormulario;

implementation

uses
  System.Diagnostics, System.Threading;

{$R *.dfm}

{ TFormulario }

procedure TFormulario.BitBtn1Click(Sender: TObject);
var
  Tasks: array [0..2] of ITask;
  LStopWatch: TStopWatch;
begin
  LStopWatch := TStopwatch.StartNew;

  Tasks[0] := TTask.Create(ConsultarDadosCliente);
  Tasks[0].Start;

  Tasks[1] := TTask.Create(ConsultarDadosPedido);
  Tasks[1].Start;

  Tasks[2] := TTask.Create(ConsultarDadosItensPedido);
  Tasks[2].Start;

  // Aguarda a finalização de todas as Tasks antes de prosseguir
  TTask.WaitForAll(Tasks);

  LStopWatch.Stop;
  ShowMessage(LStopWatch.Elapsed.ToString);

  (frxReport.FindObject('Texto') as TfrxMemoView).Text := FTexto.ToString;
  frxReport.ShowReport();
end;

procedure TFormulario.ConsultarDadosCliente;
begin
  Sleep(2000);
  FTexto.Append('Dados do cliente').AppendLine;
end;

procedure TFormulario.ConsultarDadosPedido;
begin
  Sleep(3000);
  FTexto.Append('Dados do pedido').AppendLine;
end;

procedure TFormulario.ConsultarDadosItensPedido;
begin
  Sleep(4000);
  FTexto.Append('Dados dos itens do pedido').AppendLine;
end;

procedure TFormulario.FormCreate(Sender: TObject);
begin
  FTexto := TStringBuilder.Create;
end;

procedure TFormulario.FormDestroy(Sender: TObject);
begin
  FTexto.Free;
end;

end.
