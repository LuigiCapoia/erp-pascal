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
cadcategoria, cadProduto, cadOrcamento, pesquisacategoria, pesqCliente, 
pesqProduto, telinha, cadUsuario, telaLogin, telaSobre;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TtelaLoginF, telaLoginF);
  Application.CreateForm(TtelaModeloF, telaModeloF);
  Application.CreateForm(TDMF, DMF);
  Application.CreateForm(TtelaSobreF, telaSobreF);
  Application.Run;
end.

