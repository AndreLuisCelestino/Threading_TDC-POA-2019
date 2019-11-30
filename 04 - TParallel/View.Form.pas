unit View.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids;

type
  TFormulario = class(TForm)
    ClientDataSet: TClientDataSet;
    DataSource: TDataSource;
    ButtonImportar: TButton;
    ClientDataSetID: TIntegerField;
    ClientDataSetNome: TStringField;
    ClientDataSetCidade: TStringField;
    ClientDataSetEmail: TStringField;
    ClientDataSetEmpresa: TStringField;
    DBGrid: TDBGrid;
    Memo: TMemo;
    ButtonImportarParalelo: TButton;
    ButtonLimpar: TButton;
    procedure ButtonImportarClick(Sender: TObject);
    procedure ButtonImportarParaleloClick(Sender: TObject);
    procedure ButtonLimparClick(Sender: TObject);
  end;

var
  Formulario: TFormulario;

implementation

uses
  System.Diagnostics, System.Threading, System.Generics.Collections;

{$R *.dfm}

procedure TFormulario.ButtonImportarClick(Sender: TObject);
var
  i: integer;
  LStopWatch: TStopWatch;
  StringList: Tstringlist;
begin
  // Importação de arquivo SEM usar o TParallel.For
  LStopWatch := TStopwatch.StartNew;

  StringList := TStringList.Create;
  try
    Memo.Lines.LoadFromFile('Mock.csv', TEncoding.UTF8);

    for i := 1 to 20000 do
    begin
      StringList.CommaText := Memo.Lines[i];

      ClientDataSet.Append;
      ClientDataSet.FieldByName('ID').AsString := StringList[0];
      ClientDataSet.FieldByName('Nome').AsString := StringList[1];
      ClientDataSet.FieldByName('Cidade').AsString := StringList[2];
      ClientDataSet.FieldByName('Email').AsString := StringList[3];
      ClientDataSet.FieldByName('Empresa').AsString := StringList[4];
      ClientDataSet.Post;
    end;

    LStopWatch.Stop;
    ShowMessage(LStopWatch.Elapsed.ToString);
    ShowMessage(ClientDataSet.RecordCount.ToString);
  finally
    StringList.Free;
  end;
end;

procedure TFormulario.ButtonImportarParaleloClick(Sender: TObject);
var
  LStopWatch: TStopWatch;
  ThreadPool: TThreadPool;
begin
  // Importação de arquivo UTILIZANDO o TParallel.For

  LStopWatch := TStopwatch.StartNew;

  Memo.Lines.LoadFromFile('Mock.csv', TEncoding.UTF8);

  ThreadPool := TThreadPool.Create;
  try
    // O ThreadPool é utilizado para configurar
    // a quantidade mínima e máxima de Threads que serão executadas
    ThreadPool.SetMinWorkerThreads(1);
    ThreadPool.SetMaxWorkerThreads(4);

    TParallel.&For(1, 20000,
      procedure (i: integer)
      begin
        TThread.Queue(TThread.CurrentThread,
        procedure
        var
          Clone: TClientDataSet;
          StringList: TStringList;
        begin
          Clone := TClientDataSet.Create(nil);
          StringList := TStringList.Create;
          try
            // O clone é utilizado para evitar a concorrência de acesso ao DataSet
            Clone.CloneCursor(ClientDataSet, True);

            StringList.StrictDelimiter := True;
            StringList.CommaText := Memo.Lines[i];

            Clone.Append;
            Clone.FieldByName('ID').AsString := StringList[0];
            Clone.FieldByName('Nome').AsString := StringList[1];
            Clone.FieldByName('Cidade').AsString := StringList[2];
            Clone.FieldByName('Email').AsString := StringList[3];
            Clone.FieldByName('Empresa').AsString := StringList[4];
            Clone.Post;

            // Na importação do último registro, exibe as mensagens
            if i = 20000 then
            begin
              LStopWatch.Stop;
              ShowMessage(LStopWatch.Elapsed.ToString);
              ShowMessage(ClientDataSet.RecordCount.ToString);
            end;

          finally
            StringList.Free;
            Clone.Free;
          end;
        end);
      end, ThreadPool);

  finally
    ThreadPool.Free;
  end;
end;

procedure TFormulario.ButtonLimparClick(Sender: TObject);
begin
  ClientDataSet.EmptyDataSet;
  Memo.Lines.Clear;
end;

end.
