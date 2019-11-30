unit Thread.ZipFile;

interface

uses
  System.Classes;

type
  TZipFileThread = class(TThread)
  private
    FFile: string;
  protected
    procedure Execute; override;
  public
    constructor Create(const aFile: string);
  end;

implementation

uses
  System.SysUtils, System.UITypes, System.IOUtils, System.Zip, VCL.Dialogs;

{ TZipFileThread }

constructor TZipFileThread.Create(const aFile: string);
begin
  inherited Create(True);
  FFile := aFile;
end;

procedure TZipFileThread.Execute;
var
  ZipFile: TZipFile;
begin
  ZipFile := TZipFile.Create;
  try
    ZipFile.Open(TPath.Combine(GetCurrentDir, 'Compactado.zip'), zmWrite);
      ZipFile.Add(FFile);

    MessageDlg('Compactação concluída!', mtInformation, [mbOK], 0);
  finally
    ZipFile.Free;
  end;
end;

end.
