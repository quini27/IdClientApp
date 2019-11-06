program AppIdClient;

uses
  Vcl.Forms,
  UnitIdClient in 'UnitIdClient.pas' {FormIdClient},
  UnitAdd in 'UnitAdd.pas' {FormAddress};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormIdClient, FormIdClient);
  Application.CreateForm(TFormAddress, FormAddress);
  Application.Run;
end.
