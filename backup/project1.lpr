program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, telaModelo, DataModule, cadCliente, MenuPrincipal,
cadCategorias
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TMenuPrincipalF, MenuPrincipalF);
  Application.CreateForm(TtelaModeloF, telaModeloF);
  Application.CreateForm(TDMF, DMF);
  Application.CreateForm(TcadCategorias, cadCategorias);
  Application.Run;
end.

