unit PesquisaCategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, DBGrids, Buttons, DataModule;

type

  { TPesquisaCategoriaF }

  TPesquisaCategoriaF = class(TForm)
    BitBtnPesquisar: TBitBtn;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    DSPesCat: TDataSource;
    Label1: TLabel;
    Panel1: TPanel;
    procedure BitBtnPesquisarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PesquisarClick(Sender: TObject);
  private

  public

  end;

var
  PesquisaCategoriaF: TPesquisaCategoriaF;

implementation

uses
  cadProduto;
{$R *.lfm}

{ TPesquisaCategoriaF }


 // levar a categoria para o campo
procedure TPesquisaCategoriaF.DBGrid1DblClick(Sender: TObject);
begin
       DMF.ZQueryProdutocategoriaprodutoid.AsString:= DMF.ZQueryCategoriacategoriaprodutoid.AsString;
       cadProdutoF.Label9.Caption:= DMF.ZQueryCategoriads_categoria_produto.AsString;
        Close;   // close manda fechar o formulario no form close coloca o cafree
end;

  // fecha
procedure TPesquisaCategoriaF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
    DMF.ZQueryCategoria.Close;
   CloseAction:=caFree;
end;

//abre
procedure TPesquisaCategoriaF.FormShow(Sender: TObject);
begin
           DMF.ZQueryCategoria.Open;
end;

procedure TPesquisaCategoriaF.PesquisarClick(Sender: TObject);
begin

end;

//pesquisar
procedure TPesquisaCategoriaF.BitBtnPesquisarClick(Sender: TObject);
var xconteudo : string ;
begin

     // pesquisa por id
      DMF.ZQueryCategoria.Close;
        if Edit1.text = '' then
           xconteudo:= ' where 1 = 1'
        else
          xconteudo:= ' where CATEGORIAPRODUTOID = '+ Edit1.text ;

        DMF.ZQueryCategoria.SQL.Text :=
                                     'SELECT '+
                                       '* '+
                                     'FROM CATEGORIA_PRODUTO '+
                                     xconteudo+ ' ORDER BY CATEGORIAPRODUTOID ASC ';

      DMF.ZQueryCategoria.Open;
end;

end.

