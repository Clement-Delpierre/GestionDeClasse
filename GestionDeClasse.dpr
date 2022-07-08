program GestionDeClasse;

uses
  Vcl.Forms,
  Principale in 'Principale.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
