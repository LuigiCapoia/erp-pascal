unit cadcategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, Buttons, ExtCtrls, LR_Class, LR_DBSet, telaModelo, DataModule, DB;

type

  { TcadCategoriaF }

  TcadCategoriaF = class(TtelaModeloF)
    DBEditdescricao: TDBEdit;
    DBEditId: TDBEdit;
    DSCategoria: TDataSource;
    DBGrid2: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);
    procedure BitBtnFecharClick(Sender: TObject);
    procedure BitBtnGravarClick(Sender: TObject);
    procedure BitBtnNovoClick(Sender: TObject);
    procedure BitBtnPesquisarClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private

  public

  end;

var
  cadCategoriaF: TcadCategoriaF;

implementation

{$R *.lfm}

{ TcadCategoriaF }

//abre o form
procedure TcadCategoriaF.FormShow(Sender: TObject);
begin
  if not DMF.ZQueryCategoria.Active then
    DMF.ZQueryCategoria.Open;
  PageControl1.ActivePage := TabSheet1;
end;

//paginas
procedure TcadCategoriaF.PageControl1Change(Sender: TObject);
begin
     BitBtnGravar.Enabled := False;
     BitBtnExcluir.Enabled := False;

     DBEditdescricao.Enabled := False;
     BitBtnNovo.Enabled := False;

end;

//fecha o form
procedure TcadCategoriaF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
    DMF.ZQueryCategoria.Close;
   CloseAction:=caFree;
end;

 
// fechar
procedure TcadCategoriaF.BitBtnFecharClick(Sender: TObject);
begin
       DMF.ZQueryCategoria.Cancel;
       Close;
  //Application.Terminate;
end;

//alterar
procedure TcadCategoriaF.BitBtnAlterarClick(Sender: TObject);
begin
  DMF.ZQueryCategoria.Edit;

  BitBtnNovo.Enabled := True;
  BitBtnGravar.Enabled := True;
  BitBtnAlterar.Enabled := False;
  DBEditdescricao.Enabled:=True;
end;

//cancelar
procedure TcadCategoriaF.BitBtnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Cancelar a edição? Todas as alterações não salvas serão perdidas.',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;
     DBEditdescricao.Enabled := True;
    BitBtnExcluir.Enabled := True;
  BitBtnAlterar.Enabled := True;
  BitBtnNovo.Enabled := True;
  BitBtnGravar.Enabled := True;
  DMF.ZQueryCategoria.Cancel;
  PageControl1.ActivePage := tabsheet1;
end;

//excluir
procedure TcadCategoriaF.BitBtnExcluirClick(Sender: TObject);
begin
     If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes
  then
     begin
         PageControl1.activepage:= tabsheet1;
          DMF.ZQueryCategoria.Delete;
     end;
     BitBtnNovo.Enabled := True;
     BitBtnGravar.Enabled := True;
end;

//gravar
procedure TcadCategoriaF.BitBtnGravarClick(Sender: TObject);
begin
    if (DBEditdescricao.Text = '') or (DBEditId.Text = '') then
  begin
    ShowMessage('Preencha todos os campos obrigatórios.');
    Exit;
  end;
  BitBtnExcluir.Enabled := True;
  BitBtnAlterar.Enabled := True;
  BitBtnNovo.Enabled := True;
  DMF.ZQueryCategoria.Post;
  PageControl1.ActivePage := tabsheet1;

end;


//novo
procedure TcadCategoriaF.BitBtnNovoClick(Sender: TObject);
begin
    if not DMF.ZQueryCategoria.Active then
      Exit;


      BitBtnExcluir.Enabled := False; // Desativa o botão "Excluir"
      BitBtnAlterar.Enabled := False; // Desativa o botão "Editar"
      BitBtnNovo.Enabled := False; // Desativa o botão ao iniciar uma nova edição

    PageControl1.ActivePage := cadastrar;
    DMF.ZQueryCategoria.Append;
end;

//pesquisar
procedure TcadCategoriaF.BitBtnPesquisarClick(Sender: TObject);
var xconteudo : string ;
begin

     // pesquisa por id
      DMF.ZQueryCategoria.Close;
        if edtPesquisar.text = '' then
           xconteudo:= ' where 1 = 1'
        else
          xconteudo:= ' where CATEGORIAPRODUTOID = '+ edtPesquisar.text ;

        DMF.ZQueryCategoria.SQL.Text:= 'SELECT'+ ' *'+ ' FROM CATEGORIA_PRODUTO '+ xconteudo+ ' ORDER BY CATEGORIAPRODUTOID ASC';

      DMF.ZQueryCategoria.Open;
end;



//doble clic no grid
procedure TcadCategoriaF.DBGrid2DblClick(Sender: TObject);
begin
  BitBtnNovo.Enabled := False;
  BitBtnGravar.Enabled := False;
  DBEditdescricao.Enabled:=false;

  DMF.ZQueryCategoria.Edit;
  PageControl1.ActivePage := cadastrar ;
end;


end.


