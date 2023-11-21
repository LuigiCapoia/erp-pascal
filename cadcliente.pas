unit cadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  DBCtrls, telaModelo, DB, DataModule;

type

  { TcadClienteF }

  TcadClienteF = class(TtelaModeloF)
    DBComboBox1: TDBComboBox;
    DBEditNome: TDBEdit;
    DBEditCpf_cnpj: TDBEdit;
    DBEditID: TDBEdit;
    dsClientes: TDataSource;
    DBGrid2: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    rdbCPF: TRadioButton;
    rdbCNPJ: TRadioButton;
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
    procedure rdbCNPJClick(Sender: TObject);
    procedure rdbCPFClick(Sender: TObject);
  private

  public

  end;

var
  cadClienteF: TcadClienteF;

implementation

{$R *.lfm}

{ TcadClienteF }
 // abre o form
procedure TcadClienteF.FormShow(Sender: TObject);
begin
      if not DMF.ZQueryClientes.Active then
      DMF.ZQueryClientes.Open;
      PageControl1.activepage:= TabSheet1;

end;

//pagina
procedure TcadClienteF.PageControl1Change(Sender: TObject);
begin


end;

// cnpj mask
procedure TcadClienteF.rdbCNPJClick(Sender: TObject);
var
  tmp, resultado, Numero: String;
  indx: Integer;
begin
  Numero := DBEditCpf_cnpj.Text;

  if Length(Numero) < 12 then
  begin
    resultado := '';
    Exit;
  end;

  resultado := '';
  for indx := 1 to Length(Numero) do
  begin
    if Numero[indx] in ['0'..'9'] then
      resultado := resultado + Numero[indx];
  end;

  if Length(resultado) < 14 then
    resultado := StringOfChar('0', 14 - Length(resultado)) + resultado;

  tmp := Copy(resultado, 1, 2) + '.';
  tmp := tmp + Copy(resultado, 3, 3) + '.';
  tmp := tmp + Copy(resultado, 6, 3) + '/';
  tmp := tmp + Copy(resultado, 9, 4) + '-' + Copy(resultado, 13, 2);

  DBEditCpf_cnpj.Text := tmp;
end;




//radio cpf
procedure TcadClienteF.rdbCPFClick(Sender: TObject);
var
  tmp, resultado, Numero: String;
  indx: Integer;
begin
  Numero := DBEditCpf_cnpj.Text;

  if Length(Numero) < 10 then
  begin
    resultado := '';
    Exit;
  end;

  resultado := '';
  for indx := 1 to Length(Numero) do
  begin
    if Numero[indx] in ['0'..'9'] then
      resultado := resultado + Numero[indx];
  end;

  if Length(resultado) < 11 then
    resultado := StringOfChar('0', 11 - Length(resultado)) + resultado;

  tmp := Copy(resultado, 1, 3) + '.';
  tmp := tmp + Copy(resultado, 4, 3) + '.';
  tmp := tmp + Copy(resultado, 7, 3) + '-';
  tmp := tmp + Copy(resultado, 10, 2);

  DBEditCpf_cnpj.Text := tmp;
end;



//fecha o form
procedure TcadClienteF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
       DMF.ZQueryClientes.Close;
       CloseAction:=caFree;
end;

// fechar
procedure TcadClienteF.BitBtnFecharClick(Sender: TObject);
begin
       DMF.ZQueryClientes.Cancel;
       Close;
  //Application.Terminate;
end;

//alterar
procedure TcadClienteF.BitBtnAlterarClick(Sender: TObject);
begin
  DMF.ZQueryClientes.Edit;
  BitBtnNovo.Enabled := True;
  BitBtnGravar.Enabled := True;
  BitBtnAlterar.Enabled := False;

  DBEditNome.Enabled:=True;
  DBEditCpf_cnpj.Enabled:=True;
  rdbCPF.Enabled:=True;
  rdbCNPJ.Enabled:=True;
  DBComboBox1.Enabled:=True;

end;

//cancelar
procedure TcadClienteF.BitBtnCancelarClick(Sender: TObject);
begin
         if MessageDlg('Cancelar a edição? Todas as alterações não salvas serão perdidas.',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

         DBEditNome.Enabled:=True;
       DBEditCpf_cnpj.Enabled:=True;
       rdbCPF.Enabled:=True;
       rdbCNPJ.Enabled:=True;
       DBComboBox1.Enabled:=True;

         BitBtnExcluir.Enabled := True;
  BitBtnAlterar.Enabled := True;
  BitBtnNovo.Enabled := True;
  BitBtnGravar.Enabled := True;
    DMF.ZQueryClientes.Cancel;
    PageControl1.activepage:= tabsheet1;
end;

//Excluir
procedure TcadClienteF.BitBtnExcluirClick(Sender: TObject);
begin
             If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes
  then
     begin
         PageControl1.activepage:= tabsheet1;
          DMF.ZQueryClientes.Delete;
     end;
             BitBtnNovo.Enabled := True;
             BitBtnGravar.Enabled := True;
end;

// gravar
procedure TcadClienteF.BitBtnGravarClick(Sender: TObject);
begin
        if (DBEditNome.Text = '') or (DBEditCpf_cnpj.Text = '') then
  begin
    ShowMessage('Preencha todos os campos obrigatórios.');
    Exit;
  end;

  BitBtnExcluir.Enabled := True;
  BitBtnAlterar.Enabled := True;
  BitBtnNovo.Enabled := True;
  PageControl1.ActivePage := tabsheet1;
  DMF.ZQueryClientes.Post;
end;

//novo
procedure TcadClienteF.BitBtnNovoClick(Sender: TObject);
begin
        BitBtnExcluir.Enabled := False; // Desativa o botão "Excluir"
      BitBtnAlterar.Enabled := False; // Desativa o botão "Editar"
      BitBtnNovo.Enabled := False; // Desativa o botão ao iniciar uma nova edição
      DMF.ZQueryClientes.Append;
     PageControl1.ActivePage := cadastrar ;
     //DBEditID.SetFocus;
end;

//pesquisar
procedure TcadClienteF.BitBtnPesquisarClick(Sender: TObject);
var xconteudo : string ;
begin
            // //pesquisa por nome
             DMF.ZQueryClientes.Close;
        if edtPesquisar.text = '' then
           xconteudo:= ' where 1 = 1'
        else
        xconteudo:= ' where UPPER(nome_cliente) lIKE '+ QuotedStr( '%' + UpperCase(edtPesquisar.text) + '%' ) ;

        DMF.ZQueryClientes.SQL.Text:= 'SELECT'+ ' *'+ ' FROM CLIENTE'+ xconteudo+ ' ORDER BY CLIENTEID ASC';

      DMF.ZQueryClientes.Open;



     // pesquisa por id
      //DMF.ZQueryClientes.Close;
      //  if edtPesquisar.text = '' then
      //     xconteudo:= ' where 1 = 1'
      //  else
      //    xconteudo:= ' where clienteid = '+ edtPesquisar.text ;
      //
      //  DMF.ZQueryClientes.SQL.Text:= 'SELECT'+ ' *'+ ' FROM CLIENTE'+ xconteudo+ ' ORDER BY CLIENTEID ASC';
      //
      //DMF.ZQueryClientes.Open;
end;


//doble clic no grid
procedure TcadClienteF.DBGrid2DblClick(Sender: TObject);
begin
  BitBtnNovo.Enabled := False;
  BitBtnGravar.Enabled := False;

  DBEditNome.Enabled:=False;
  DBEditCpf_cnpj.Enabled:=False;
  rdbCPF.Enabled:=False;
  rdbCNPJ.Enabled:=False;
  DBComboBox1.Enabled:=False;

  DMF.ZQueryClientes.Edit;
  PageControl1.ActivePage := cadastrar ;
end;



end.

