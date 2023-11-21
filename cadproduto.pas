unit cadProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, Buttons, telaModelo, DB, DataModule,PesquisaCategoria;

type

  { TcadProdutoF }

  TcadProdutoF = class(TtelaModeloF)
    DataSourceProdutos: TDataSource;
    DBComboBox1: TDBComboBox;
    DBEditData: TDBEdit;
    DBEditValor: TDBEdit;
    DBEditObservacao: TDBEdit;
    DBEditDescricao: TDBEdit;
    DBEditCatID: TDBEdit;
    DBEditID: TDBEdit;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SpeedButton1: TSpeedButton;
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure BitBtnFecharClick(Sender: TObject);
    procedure BitBtnGravarClick(Sender: TObject);
    procedure BitBtnNovoClick(Sender: TObject);
    procedure BitBtnPesquisarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
     FormPesquiCat: TPesquisaCategoriaF;
  public

  end;

var
  cadProdutoF: TcadProdutoF;

implementation

{$R *.lfm}

{ TcadProdutoF }

//abre o form
procedure TcadProdutoF.FormShow(Sender: TObject);
begin
          if not DMF.ZQueryClientes.Active then
          DMF.ZQueryProduto.Open;
          PageControl1.activepage:= TabSheet1;
end;

//pagina
procedure TcadProdutoF.PageControl1Change(Sender: TObject);
begin
     BitBtnGravar.Enabled := False;
     BitBtnExcluir.Enabled := False;

       DBEditDescricao.Enabled:=False;
       DBEditObservacao.Enabled:=False;
       DBComboBox1.Enabled:=False;
       SpeedButton1.Enabled:=False;
       BitBtnNovo.Enabled := False;

end;

//pesquisa categoria
procedure TcadProdutoF.SpeedButton1Click(Sender: TObject);
begin
     if not Assigned(FormPesquiCat) then
     PesquisaCategoriaF := TPesquisaCategoriaF.Create(Self);
     PesquisaCategoriaF.Show;
end;

//fecha o form
procedure TcadProdutoF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
    DMF.ZQueryProduto.Close;
   CloseAction:=caFree;
end;


// fechar
procedure TcadProdutoF.BitBtnFecharClick(Sender: TObject);
begin
       DMF.ZQueryProduto.Cancel;
       Close;
       //Application.Terminate;
end;

//alterar
procedure TcadProdutoF.BitBtnAlterarClick(Sender: TObject);
begin
  DMF.ZQueryProduto.Edit;

  BitBtnNovo.Enabled := True;
  BitBtnGravar.Enabled := True;
  BitBtnAlterar.Enabled := False;

  DBEditDescricao.Enabled:=True;
  DBEditObservacao.Enabled:=True;
  DBComboBox1.Enabled:=True;
  SpeedButton1.Enabled:=True;
end;

//cancelar
procedure TcadProdutoF.BitBtnCancelarClick(Sender: TObject);
begin
if MessageDlg('Cancelar a edição? Todas as alterações não salvas serão perdidas.',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
Exit;
DBEditDescricao.Enabled:=True;
DBEditObservacao.Enabled:=True;
DBComboBox1.Enabled:=True;
SpeedButton1.Enabled:=True;

    BitBtnExcluir.Enabled := True;
    BitBtnAlterar.Enabled := True;
    BitBtnNovo.Enabled := True;
    BitBtnGravar.Enabled := True;
    DMF.ZQueryProduto.Cancel;
    PageControl1.activepage:= tabsheet1;
end;

//Excluir
procedure TcadProdutoF.BitBtnExcluirClick(Sender: TObject);
begin
              If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes
  then
     begin
         PageControl1.activepage:= tabsheet1;
          DMF.ZQueryProduto.Delete;
     end;
              BitBtnNovo.Enabled := True;
    BitBtnGravar.Enabled := True;
end;

//gravar
procedure TcadProdutoF.BitBtnGravarClick(Sender: TObject);
begin
           if (DBEditDescricao.Text = '') or (DBEditObservacao.Text = '') or (DBEditValor.Text = '') or (DBEditCatID.Text = '') or (DBComboBox1.Text = '') then
  begin
    ShowMessage('Preencha todos os campos obrigatórios.');
    Exit;
  end;

             BitBtnExcluir.Enabled := True;
  BitBtnAlterar.Enabled := True;
  BitBtnNovo.Enabled := True;
  DBEditValor.Enabled:=True;
   DMF.ZQueryProduto.Post;
  PageControl1.activepage:= tabsheet1;
end;

//novo
procedure TcadProdutoF.BitBtnNovoClick(Sender: TObject);
begin

          BitBtnExcluir.Enabled := False; // Desativa o botão "Excluir"
      BitBtnAlterar.Enabled := False; // Desativa o botão "Editar"
      BitBtnNovo.Enabled := False; // Desativa o botão ao iniciar uma nova edição
     PageControl1.ActivePage := cadastrar ;
     DMF.ZQueryProduto.Insert;
    // DBEditID.SetFocus;
end;

//pesquisar
procedure TcadProdutoF.BitBtnPesquisarClick(Sender: TObject);
var xconteudo : string ;
begin

      //pesquisa por nome
           DMF.ZQueryProduto.Close;
             if edtPesquisar.text = '' then
                xconteudo:= ' where 1 = 1'
             else
               xconteudo:= ' where UPPER(ds_produto) lIKE '+ QuotedStr( '%' + UpperCase(edtPesquisar.text) + '%' );

             DMF.ZQueryProduto.SQL.Text:= 'SELECT'+ ' *'+ ' FROM PRODUTO'+ xconteudo+ ' ORDER BY PRODUTOID ASC';

           DMF.ZQueryProduto.Open;
end;

//doble clic no grid
procedure TcadProdutoF.DBGrid1DblClick(Sender: TObject);
begin
     BitBtnNovo.Enabled := False;
     BitBtnGravar.Enabled := False;

     DBEditDescricao.Enabled:=False;
     DBEditObservacao.Enabled:=False;
     DBComboBox1.Enabled:=False;
     SpeedButton1.Enabled:=False;
     DBEditValor.Enabled:=False;

     DMF.ZQueryProduto.Edit;
     PageControl1.ActivePage := cadastrar ;
end;

end.

