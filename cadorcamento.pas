unit cadOrcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, Buttons, LR_DBSet, LR_Class, telaModelo, DB, DataModule,
  pesqCliente, telinha;

type

  { TcadOrcamentoF }

  TcadOrcamentoF = class(TtelaModeloF)
    BitBtnImprimir: TBitBtn;
    BitBtnAdicionar: TBitBtn;
    BitBtnExItem: TBitBtn;
    Button1: TButton;
    DataSourceoRCAMENTO_iTEM: TDataSource;
    DataSourceOrcamento: TDataSource;
    DBEditValor: TDBEdit;
    DBEditValidade: TDBEdit;
    DBEditData: TDBEdit;
    DBEditIdCliente: TDBEdit;
    DBEditId: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    frDBDataSetItensOrca: TfrDBDataSet;
    frReportItensOrca: TfrReport;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton1: TSpeedButton;
    procedure BitBtnAdicionarClick(Sender: TObject);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure BitBtnExItemClick(Sender: TObject);
    procedure BitBtnFecharClick(Sender: TObject);
    procedure BitBtnGravarClick(Sender: TObject);
    procedure BitBtnImprimirClick(Sender: TObject);
    procedure BitBtnNovoClick(Sender: TObject);
    procedure BitBtnPesquisarClick(Sender: TObject);
    procedure DBGrid1DblClick(orcamentoid : Integer);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure AbreOrcItens(orcamentoid : Integer);
    procedure PageControl1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
         FormPesquiCliente: TPesqClienteF;
        Formtelinha: TtelinhaF ;
  public

  end;

var
  cadOrcamentoF: TcadOrcamentoF;

implementation

{$R *.lfm}

{ TcadOrcamentoF }
//abre o form
procedure TcadOrcamentoF.FormShow(Sender: TObject);
begin
      if not DMF.ZQueryOrcamento.Active then
    DMF.ZQueryOrcamento.Open;
    PageControl1.activepage:= TabSheet1;
end;


//fecha o form
procedure TcadOrcamentoF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
    DMF.ZQueryOrcamento.Close;
   CloseAction:=caFree;
end;


// fechar
procedure TcadOrcamentoF.BitBtnFecharClick(Sender: TObject);
begin
       DMF.ZQueryOrcamento.Cancel;
       Close;
       //Application.Terminate;
end;

//gravar
procedure TcadOrcamentoF.BitBtnGravarClick(Sender: TObject);
begin
  if (DBEditId.Text = '') or (DBEditIdCliente.Text = '') or (DBEditData.Text = '') or (DBEditValidade.Text = '') or (DBEditValor.Text = '')then
    begin
      ShowMessage('Preencha todos os campos obrigatórios.');
      Exit;
    end;

  BitBtnExcluir.Enabled := True;
  BitBtnAlterar.Enabled := True;
  BitBtnNovo.Enabled := True;

  if DMF.ZQueryOrcamento.State in [dsEdit, dsInsert] then
     DMF.ZQueryOrcamento.Post;

  PageControl1.activepage:= tabsheet1;
end;

//imprimir relatorio
procedure TcadOrcamentoF.BitBtnImprimirClick(Sender: TObject);
begin
     frReportItensOrca.LoadFromFile('RelatorioItens.lrf');
     frReportItensOrca.PrepareReport;
     frReportItensOrca.ShowReport;
end;

// adicionar item
procedure TcadOrcamentoF.BitBtnAdicionarClick(Sender: TObject);
var
id : String;
begin
  if (DBEditId.Text = '') or (DBEditIdCliente.Text = '') or (DBEditData.Text = '') or (DBEditValidade.Text = '')then
    begin
      ShowMessage('Preencha todos os campos obrigatórios.');
      Exit;
    end;

    if DMF.ZQueryOrcamento.State in [dsEdit, dsInsert] then
       DMF.ZQueryOrcamento.Post;

   DMF.ZQueryOrcamento_item.Insert;

    //Busca o ultimo código do orçamento atual
    DMF.ZQueryGenerica.close;
    DMF.ZQueryGenerica.SQL.Clear;
    DMF.ZQueryGenerica.SQL.Add('SELECT MAX(ORCAMENTOITEMID) + 1 PROXCODIGO '+
                                    'FROM ORCAMENTO_ITEM');
    DMF.ZQueryGenerica.Open;

    id := DMF.ZQueryGenerica.FieldByName('PROXCODIGO').AsString;

    if id = '' then
       DMF.ZQueryOrcamento_itemorcamentoitemid.AsInteger := 1
    else
       DMF.ZQueryOrcamento_itemorcamentoitemid.AsInteger := StrToInt(id);

    //Passando o código do orçamentoid
    DMF.ZQueryOrcamento_itemorcamentoid.AsInteger := DMF.ZQueryOrcamentoorcamentoid.AsInteger;

       // seleciona tela
     if not Assigned(Formtelinha) then
     telinhaF := TtelinhaF.Create(Self);
     telinhaF.ShowModal;

end;

//alterar
procedure TcadOrcamentoF.BitBtnAlterarClick(Sender: TObject);
begin
  DMF.ZQueryOrcamento_item.Edit;

  SpeedButton1.Enabled := True;
  DBEditValidade.Enabled := True;

  BitBtnNovo.Enabled := True;
  BitBtnGravar.Enabled := True;
  BitBtnAlterar.Enabled := False;
  BitBtnExItem.Enabled := True;
  BitBtnAdicionar.Enabled := True;

end;

//cancelar
procedure TcadOrcamentoF.BitBtnCancelarClick(Sender: TObject);
begin
    if MessageDlg('Cancelar a edição? Todas as alterações não salvas serão perdidas.',
         mtConfirmation, [mbYes, mbNo], 0) = mrNo then
       Exit;
         SpeedButton1.Enabled := True;
  DBEditValidade.Enabled := True;

    BitBtnExcluir.Enabled := True;
    BitBtnAlterar.Enabled := True;
    BitBtnNovo.Enabled := True;
    BitBtnGravar.Enabled := True;

    DMF.ZQueryOrcamento_item.Cancel;
    DMF.ZQueryOrcamento_item.Close;
    DMF.ZQueryOrcamento.Cancel;

    PageControl1.activepage:= tabsheet1;
end;

//Excluir
procedure TcadOrcamentoF.BitBtnExcluirClick(Sender: TObject);
begin
     if MessageDlg('Você tem certeza que deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if DMF.ZQueryOrcamento_item.Active then
      DMF.ZQueryOrcamento_item.Close;
    DMF.ZQueryOrcamento_item.Params.Clear;
    DMF.ZQueryOrcamento_item.Params.CreateParam(ftInteger, 'orcamentoid', ptInput);
    DMF.ZQueryOrcamento_item.ParamByName('orcamentoid').AsInteger := DMF.ZQueryOrcamentoorcamentoid.AsInteger;
    DMF.ZQueryOrcamento_item.Open;
    // Exclui todos os itens do oracmento
    DMF.ZQueryOrcamento_item.First;
    while not DMF.ZQueryOrcamento_item.Eof do
    begin
      DMF.ZQueryOrcamento_item.Delete;
    end;
    // exclui o orcamento
    DMF.ZQueryOrcamento.Delete;
    PageControl1.activepage:= tabsheet1;
  end;

BitBtnNovo.Enabled := True;
BitBtnGravar.Enabled := True;
end;

// excluir Item
procedure TcadOrcamentoF.BitBtnExItemClick(Sender: TObject);
begin
  if DMF.ZQueryOrcamento_item.IsEmpty then
  begin
    ShowMessage('Não há itens para excluir.');
    Exit; // Sai da função sem fazer nada
  end;

  if MessageDlg('Você tem certeza que deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DMF.ZQueryOrcamento_item.Delete;
    DMF.SomaItens;
  end;
end;



//novo
procedure TcadOrcamentoF.BitBtnNovoClick(Sender: TObject);
begin
BitBtnExcluir.Enabled := False;
BitBtnAlterar.Enabled := False;
BitBtnNovo.Enabled := False;

     DMF.ZQueryOrcamento.Insert;
     PageControl1.ActivePage := cadastrar;
     PageControl1Change(nil);
end;


//pesquisar
procedure TcadOrcamentoF.BitBtnPesquisarClick(Sender: TObject);
var xconteudo : string ;
begin

     // pesquisa por id
       DMF.ZQueryOrcamento.Close;
         if edtPesquisar.text = '' then
            xconteudo:= ' where 1 = 1'
         else
           xconteudo:= ' where ORCAMENTOID = '+ edtPesquisar.text ;

         DMF.ZQueryOrcamento.SQL.Text:= 'SELECT'+ ' *'+ ' FROM ORCAMENTO '+ xconteudo+ ' ORDER BY ORCAMENTOID ASC';

       DMF.ZQueryOrcamento.Open;
end;

//doble clic no grid
procedure TcadOrcamentoF.DBGrid1DblClick(orcamentoid: Integer);
begin
  BitBtnNovo.Enabled := False;
  BitBtnGravar.Enabled := False;

  SpeedButton1.Enabled := False;
  DBEditValidade.Enabled := False;
  BitBtnExItem.Enabled := False;
  BitBtnAdicionar.Enabled := False;

  DMF.ZQueryOrcamento.Edit;
  PageControl1.ActivePage := cadastrar ;
  PageControl1Change(nil);
end;



// seleciona itens do orcamento
procedure TcadOrcamentoF.AbreOrcItens(orcamentoid : Integer);
begin
  if orcamentoid <> 0 then
  begin
      DMF.ZQueryOrcamento_item.Close;
      DMF.ZQueryOrcamento_item.SQL.Clear;
      DMF.ZQueryOrcamento_item.SQL.Add(
                      'SELECT '+
                      'ORCAMENTOITEMID, '+
                      'ORCAMENTOID, '+
                      'PRODUTOID, '+
                      'produtodesc, '+
                      'QT_PRODUTO, '+
                      'VL_UNITARIO, '+
                      'VL_TOTAL '+
                      'FROM ORCAMENTO_ITEM ' +
                      'WHERE ORCAMENTOID = '+ inttostr(orcamentoid) + ' ' +
                      'ORDER BY ORCAMENTOID');
       //ShowMessage(DataModule1.qryOrcamentoItem.SQL.Text);
       DMF.ZQueryOrcamento_item.Open;
  end;
end;

//orcItens
procedure TcadOrcamentoF.PageControl1Change(Sender: TObject);
begin
   AbreOrcItens(DMF.ZQueryOrcamentoorcamentoid.AsInteger);
end;

// pesquisar cliente
procedure TcadOrcamentoF.SpeedButton1Click(Sender: TObject);
begin
             if not Assigned(FormPesquiCliente) then
     PesqClienteF := TPesqClienteF.Create(Self);
     PesqClienteF.Show;
end;



end.


