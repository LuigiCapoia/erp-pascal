unit pesqProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, DBGrids, DBCtrls, DataModule, DB;

type

  { TPesqProdutoF }

  TPesqProdutoF = class(TForm)
    BitBtn1: TBitBtn;
    DataSourcepesqProdutos: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  PesqProdutoF: TPesqProdutoF;

implementation

uses
  telinha;

{$R *.lfm}

{ TPesqProdutoF }

//fecha form
procedure TPesqProdutoF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
     DMF.ZQueryProduto.Close;
   CloseAction:=caFree;
   telinhaF.DBEditQuant.SetFocus;
end;

//pesquisa
procedure TPesqProdutoF.BitBtn1Click(Sender: TObject);
var xconteudo : string ;
begin
        //pesquisa por nome
           DMF.ZQueryProduto.Close;
             if Edit1.text = '' then
                xconteudo:= ' where 1 = 1'
             else
               xconteudo:= ' where UPPER(ds_produto) lIKE '+ QuotedStr( '%' + UpperCase(Edit1.text) + '%' );

             DMF.ZQueryProduto.SQL.Text:= 'SELECT'+ ' *'+ ' FROM PRODUTO'+ xconteudo+ ' ORDER BY PRODUTOID ASC';

           DMF.ZQueryProduto.Open;
end;

procedure TPesqProdutoF.DBGrid1DblClick(Sender: TObject);
begin
     DMF.ZQueryOrcamento_itemprodutoid.AsInteger:= DMF.ZQueryProdutoprodutoid.AsInteger;    // id do produto
     DMF.ZQueryOrcamento_itemprodutodesc.AsString:= DMF.ZQueryProdutods_produto.AsString;    //descrição do produto
     DMF.ZQueryOrcamento_itemvl_unitario.AsFloat:= DMF.ZQueryProdutovl_venda_produto.AsFloat;   // valor unico
     Close;
end;

//abre o form
procedure TPesqProdutoF.FormShow(Sender: TObject);
begin
     DMF.ZQueryProduto.Open;
end;

end.
