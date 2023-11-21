unit cadUsuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, telaModelo, DB, DataModule;

type

  { TcadUsuarioF }

  TcadUsuarioF = class(TtelaModeloF)
    DataSourceUsuario: TDataSource;
    DBEditSenha: TDBEdit;
    DBEditUsuario: TDBEdit;
    DBEditNome: TDBEdit;
    DBEditID: TDBEdit;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
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
  private

  public

  end;

var
  cadUsuarioF: TcadUsuarioF;

implementation

{$R *.lfm}

//abre o form
procedure TcadUsuarioF.FormShow(Sender: TObject);
begin
  if not DMF.ZQueryUsuario.Active then
    DMF.ZQueryUsuario.Open;
  PageControl1.ActivePage := TabSheet1;
end;

//pagina
procedure TcadUsuarioF.PageControl1Change(Sender: TObject);
begin


end;

//fecha o form
procedure TcadUsuarioF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
    DMF.ZQueryUsuario.Close;
   CloseAction:=caFree;
end;


// fechar
procedure TcadUsuarioF.BitBtnFecharClick(Sender: TObject);
begin
       DMF.ZQueryUsuario.Cancel;
       Close;
end;

//alterar
procedure TcadUsuarioF.BitBtnAlterarClick(Sender: TObject);
begin
  DMF.ZQueryUsuario.Edit;

  BitBtnNovo.Enabled := True;
  BitBtnGravar.Enabled := True;
  BitBtnAlterar.Enabled := False;
  DBEditSenha.Enabled:=True;
  DBEditUsuario.Enabled:=True;
  DBEditNome.Enabled:=True;
end;

//cancelar
procedure TcadUsuarioF.BitBtnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Cancelar a edição? Todas as alterações não salvas serão perdidas.',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;
    DBEditSenha.Enabled:=True;
     DBEditUsuario.Enabled:=True;
     DBEditNome.Enabled:=True;

    BitBtnExcluir.Enabled := True;
  BitBtnAlterar.Enabled := True;
  BitBtnNovo.Enabled := True;
  BitBtnGravar.Enabled := True;
  DMF.ZQueryUsuario.Cancel;
  PageControl1.ActivePage := tabsheet1;
end;

//excluir
procedure TcadUsuarioF.BitBtnExcluirClick(Sender: TObject);
begin
     If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes
  then
     begin
         PageControl1.activepage:= tabsheet1;
          DMF.ZQueryUsuario.Delete;
     end;
     BitBtnNovo.Enabled := True;
     BitBtnGravar.Enabled := True;
end;

//gravar
procedure TcadUsuarioF.BitBtnGravarClick(Sender: TObject);
begin
    if (DBEditUsuario.Text = '') or (DBEditNome.Text = '') or (DBEditSenha.Text = '') then
  begin
    ShowMessage('Preencha todos os campos obrigatórios.');
    Exit;
  end;
  BitBtnExcluir.Enabled := True;
  BitBtnAlterar.Enabled := True;
  BitBtnNovo.Enabled := True;
  DMF.ZQueryUsuario.Post;
  PageControl1.ActivePage := tabsheet1;

end;


//novo
procedure TcadUsuarioF.BitBtnNovoClick(Sender: TObject);
begin
    if not DMF.ZQueryUsuario.Active then
      Exit;


      BitBtnExcluir.Enabled := False; // Desativa o botão "Excluir"
      BitBtnAlterar.Enabled := False; // Desativa o botão "Editar"
      BitBtnNovo.Enabled := False; // Desativa o botão ao iniciar uma nova edição

    PageControl1.ActivePage := cadastrar;
    DMF.ZQueryUsuario.Append;
end;

//pesquisar
procedure TcadUsuarioF.BitBtnPesquisarClick(Sender: TObject);
var xconteudo : string ;
begin

     // pesquisa por id
      DMF.ZQueryUsuario.Close;
        if edtPesquisar.text = '' then
           xconteudo:= ' where 1 = 1'
        else
          xconteudo:= ' where ID = '+ edtPesquisar.text ;

        DMF.ZQueryUsuario.SQL.Text:= 'SELECT'+ ' *'+ ' FROM USUARIOS '+ xconteudo+ ' ORDER BY ID ASC';

      DMF.ZQueryUsuario.Open;
end;



//doble clic no grid
procedure TcadUsuarioF.DBGrid1DblClick(Sender: TObject);
begin
  BitBtnNovo.Enabled := False;
  BitBtnGravar.Enabled := False;
  DBEditSenha.Enabled:=false;
  DBEditUsuario.Enabled:=false;
  DBEditNome.Enabled:=false;


  DMF.ZQueryUsuario.Edit;
  PageControl1.ActivePage := cadastrar ;
end;


end.

end.

