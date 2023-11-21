unit DataModule;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset;

type

  { TDMF }

  TDMF = class(TDataModule)
    qryClienteclienteid: TLongintField;
    qryClientecpf_cnpj_cliente: TStringField;
    qryClientenome_cliente: TStringField;
    qryClientetipo_cliente: TStringField;
    ZConnection1: TZConnection;
    ZQueryUsuario: TZQuery;
    ZQueryGenerica: TZQuery;
    ZQueryOrcamento_item: TZQuery;
    ZQueryOrcamento: TZQuery;
    ZQueryOrcamentoclienteid: TLongintField;
    ZQueryOrcamentodt_orcamento: TDateTimeField;
    ZQueryOrcamentodt_validade_orcamento: TDateTimeField;
    ZQueryOrcamentoorcamentoid: TLongintField;
    ZQueryOrcamentovl_total_orcamento: TFloatField;
    ZQueryOrcamento_itemorcamentoid: TLongintField;
    ZQueryOrcamento_itemorcamentoitemid: TLongintField;
    ZQueryOrcamento_itemprodutodesc: TStringField;
    ZQueryOrcamento_itemprodutoid: TLongintField;
    ZQueryOrcamento_itemqt_produto: TFloatField;
    ZQueryOrcamento_itemvl_total: TFloatField;
    ZQueryOrcamento_itemvl_unitario: TFloatField;
    ZQueryProduto: TZQuery;
    ZQueryCategoria: TZQuery;
    ZQueryCategoriacategoriaprodutoid: TLongintField;
    ZQueryCategoriads_categoria_produto: TStringField;
    ZQueryClientes: TZQuery;
    ZQueryClientesclienteid: TLongintField;
    ZQueryClientescpf_cnpj_cliente: TStringField;
    ZQueryClientesnome_cliente: TStringField;
    ZQueryClientestipo_cliente: TStringField;
    ZQueryProdutocategoriaprodutoid: TLongintField;
    ZQueryProdutods_produto: TStringField;
    ZQueryProdutodt_cadastro_produto: TDateTimeField;
    ZQueryProdutoobs_produto: TStringField;
    ZQueryProdutoprodutoid: TLongintField;
    ZQueryProdutostatus_produto: TStringField;
    ZQueryProdutovl_venda_produto: TFloatField;
    ZQueryUsuarioid: TLongintField;
    ZQueryUsuarionome_completo: TStringField;
    ZQueryUsuariosenha: TStringField;
    ZQueryUsuariousuario: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure ZConnection1BeforeConnect(Sender: TObject);
    procedure ZQueryCategoriaAfterInsert(DataSet: TDataSet);
    procedure ZQueryClientesAfterInsert(DataSet: TDataSet);
    procedure ZQueryOrcamentoAfterInsert(DataSet: TDataSet);
    procedure ZQueryOrcamento_itemAfterInsert(DataSet: TDataSet);
    procedure ZQueryProdutoAfterInsert(DataSet: TDataSet);
    procedure ZQueryUsuarioAfterInsert(DataSet: TDataSet);
  private
    function getSequence(const pNomeSequence: String): String;

  public
      procedure SomaItens;
  end;

var
  DMF: TDMF;

implementation

{$R *.lfm}

{ TDMF }

function TDMF.getSequence(const pNomeSequence: String): String;
begin
     Result := '';
 try
     ZQueryGenerica.close;
     ZQueryGenerica.SQL.Clear;
     ZQueryGenerica.SQL.Add('SELECT NEXTVAL(' + QuotedStr(pNomeSequence) + ') AS CODIGO');
     ZQueryGenerica.Open;
     Result := ZQueryGenerica.FieldByName('CODIGO').AsString;
 finally
   ZQueryGenerica.Close;
 end;
end;


procedure TDMF.ZConnection1BeforeConnect(Sender: TObject);
begin

end;

//inserção de id auto da categoria
procedure TDMF.ZQueryCategoriaAfterInsert(DataSet: TDataSet);
begin
   ZQueryCategoriacategoriaprodutoid.AsString := getSequence('categoria_produto_categoriaprodutoid_seq');
end;

//inserção de id auto do Usuario
procedure TDMF.ZQueryUsuarioAfterInsert(DataSet: TDataSet);
begin
   ZQueryUsuarioid.AsString := getSequence('usuario_oid');
end;

// inserção de id auto da Cliente
procedure TDMF.ZQueryClientesAfterInsert(DataSet: TDataSet);
begin
     ZQueryClientesclienteid.AsString := getSequence('cliente_clienteid');
end;


// inserção de id auto da orcamento
procedure TDMF.ZQueryOrcamentoAfterInsert(DataSet: TDataSet);
begin
     ZQueryOrcamentoorcamentoid.AsString := getSequence('orcamento_orcamentoid_seq');
     ZQueryOrcamentodt_orcamento.AsDateTime:= Date;
     ZQueryOrcamentodt_validade_orcamento.AsDateTime:= Date;

end;

// depois de inserir  definir quantidade = 0
procedure TDMF.ZQueryOrcamento_itemAfterInsert(DataSet: TDataSet);
begin
  ZQueryOrcamento_itemqt_produto.AsInteger:=0;
end;

// inserção de id auto ddo produto
procedure TDMF.ZQueryProdutoAfterInsert(DataSet: TDataSet);
begin
  ZQueryProdutoprodutoid.AsString := getSequence('produto_produtoid');
   ZQueryProdutodt_cadastro_produto.AsDateTime := Date;
end;

procedure TDMF.DataModuleCreate(Sender: TObject);
begin
  ZConnection1.HostName  := 'localhost';
  ZConnection1.DataBase  := 'postgres';
  ZConnection1.User      := 'postgres';
  ZConnection1.Password  := '1234';
  ZConnection1.Port      := 5432;
  ZConnection1.Protocol  := 'postgresql';
  ZConnection1.Connected := True;
end;

 //soma TOtal
procedure TDMF.SomaItens;
begin

  if not (DMF.ZQueryOrcamento.State in [dsEdit, dsInsert]) then
     DMF.ZQueryOrcamento.Edit;

  if not (DMF.ZQueryOrcamento_item.State in [dsEdit, dsInsert]) then
     DMF.ZQueryOrcamento_item.Edit;

  //Vai pro Primeiro
  DMF.ZQueryOrcamento_item.First;
  DMF.ZQueryOrcamentovl_total_orcamento.AsFloat := 0;
  while not DMF.ZQueryOrcamento_item.Eof do
  begin
    DMF.ZQueryOrcamentovl_total_orcamento.AsFloat := DMF.ZQueryOrcamentovl_total_orcamento.AsFloat + DMF.ZQueryOrcamento_itemvl_total.AsFloat;
    DMF.ZQueryOrcamento_item.next;
  end;
end;

end.

