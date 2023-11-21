unit MenuPrincipal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  LR_DBSet, LR_Class, cadCliente, cadcategoria, cadProduto, cadOrcamento, cadUsuario,telaSobre;

type

  { TMenuPrincipalF }

  TMenuPrincipalF = class(TForm)
    Cadastros: TMenuItem;
    Clientes: TMenuItem;
    frDBDataSetOrcamento: TfrDBDataSet;
    frDBDataSetProdutos: TfrDBDataSet;
    frDBDataSetClientes: TfrDBDataSet;
    frDBDataSetCategoria: TfrDBDataSet;
    frReportOrcamento: TfrReport;
    frReportProdutos: TfrReport;
    frReportClientes: TfrReport;
    frReportCategoria: TfrReport;
    Image1: TImage;
    MainMenu1: TMainMenu;
    Categoria: TMenuItem;
    CategoriaRelatorio: TMenuItem;
    MenuItemOrcamento: TMenuItem;
    MenuItemProdutos: TMenuItem;
    MenuItemCliente: TMenuItem;
    Separator2: TMenuItem;
    Separator3: TMenuItem;
    Separator4: TMenuItem;
    Separator5: TMenuItem;
    Separator6: TMenuItem;
    Usuarios: TMenuItem;
    Orcamento: TMenuItem;
    Produtos: TMenuItem;
    Sair: TMenuItem;
    Relatorios: TMenuItem;
    Separator1: TMenuItem;
    Vendas: TMenuItem;
    Sobre: TMenuItem;
    procedure CategoriaClick(Sender: TObject);
    procedure CategoriaRelatorioClick(Sender: TObject);
    procedure ClientesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure MenuItemClienteClick(Sender: TObject);
    procedure MenuItemOrcamentoClick(Sender: TObject);
    procedure MenuItemProdutosClick(Sender: TObject);
    procedure OrcamentoClick(Sender: TObject);
    procedure ProdutosClick(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure SobreClick(Sender: TObject);
    procedure UsuariosClick(Sender: TObject);
  private
     FormCadClientes: TcadClienteF;
     FormCadCategoria: TcadCategoriaF  ;
     FormCadProduto: TcadProdutoF;
     FormCadOrcamento: TcadOrcamentoF;
     FormCadUsuario: TcadUsuarioF;
     FormtelaSobre: TtelaSobreF;
  public

  end;

var
  MenuPrincipalF: TMenuPrincipalF;

implementation

{$R *.lfm}

{ TMenuPrincipalF }

// clientes
procedure TMenuPrincipalF.ClientesClick(Sender: TObject);
begin
     if not Assigned(FormCadClientes) then
     CadClienteF := TCadClienteF.Create(Self);
     CadClienteF.Show;
end;

//categoria
procedure TMenuPrincipalF.CategoriaClick(Sender: TObject);
begin
     if not Assigned(FormCadCategoria) then
     cadCategoriaF := TcadCategoriaF.Create(Self);
     cadCategoriaF.Show;
end;

// categoria relatorio
procedure TMenuPrincipalF.CategoriaRelatorioClick(Sender: TObject);
begin
     frReportCategoria.LoadFromFile('RelatorioCategoria.lrf');
     frReportCategoria.PrepareReport;
     frReportCategoria.ShowReport;
end;

// fechar
procedure TMenuPrincipalF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

//relatorio Cliente
procedure TMenuPrincipalF.MenuItemClienteClick(Sender: TObject);
begin
     frReportClientes.LoadFromFile('RelatoriaClientes.lrf');
     frReportClientes.PrepareReport;
     frReportClientes.ShowReport;
end;

// relatorio orcamento
procedure TMenuPrincipalF.MenuItemOrcamentoClick(Sender: TObject);
begin
     frReportOrcamento.LoadFromFile('relatorioOrcamento.lrf');
     frReportOrcamento.PrepareReport;
     frReportOrcamento.ShowReport;
end;

//relatorio de produtos
procedure TMenuPrincipalF.MenuItemProdutosClick(Sender: TObject);
begin
     frReportProdutos.LoadFromFile('RelatorioProdutos.lrf');
     frReportProdutos.PrepareReport;
     frReportProdutos.ShowReport;
end;


// orcamento
procedure TMenuPrincipalF.OrcamentoClick(Sender: TObject);
begin
     if not Assigned(FormCadOrcamento) then
     cadOrcamentoF := TcadOrcamentoF.Create(Self);
     cadOrcamentoF.Show;
end;

//produto
procedure TMenuPrincipalF.ProdutosClick(Sender: TObject);
begin
     if not Assigned(FormCadProduto) then
     cadProdutoF := TcadProdutoF.Create(Self);
     cadProdutoF.Show;
end;

//sair
procedure TMenuPrincipalF.SairClick(Sender: TObject);
begin
      Close;
end;

// sobre
procedure TMenuPrincipalF.SobreClick(Sender: TObject);
begin
     if not Assigned(FormtelaSobre) then
     telaSobreF := TtelaSobreF.Create(Self);
     telaSobreF.Show;
end;

//usuarios
procedure TMenuPrincipalF.UsuariosClick(Sender: TObject);
begin
     if not Assigned(FormCadUsuario) then
     cadUsuarioF := TcadUsuarioF.Create(Self);
     cadUsuarioF.Show;
end;

end.

