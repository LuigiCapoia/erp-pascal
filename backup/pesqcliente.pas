unit pesqCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, DBGrids, Buttons, DataModule ;

type

  { TPesqClienteF }

  TPesqClienteF = class(TForm)
    BitBtnpesquisar: TBitBtn;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    procedure BitBtnpesquisarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);

  private

  public

  end;

var
  PesqClienteF: TPesqClienteF;

implementation

uses
  cadOrcamento;

{$R *.lfm}

{ TPesqClienteF }

// faz a inserção
procedure TPesqClienteF.DBGrid1DblClick(Sender: TObject);
begin

     DMF.ZQueryOrcamentoclienteid.AsString:= DMF.ZQueryClientesclienteid.AsString;
     cadOrcamentoF.Label7.Caption:= DMF.ZQueryClientesnome_cliente.AsString;
     Close;
end;

// fecha
procedure TPesqClienteF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
    DMF.ZQueryClientes.Close;
   CloseAction:=caFree;
end;

//abre
procedure TPesqClienteF.FormShow(Sender: TObject);
begin
         DMF.ZQueryClientes.Open;
end;


// pesquisa
procedure TPesqClienteF.BitBtnpesquisarClick(Sender: TObject);
var xconteudo : string ;
begin
            // //pesquisa por nome
             DMF.ZQueryClientes.Close;
        if Edit1.text = '' then
           xconteudo:= ' where 1 = 1'
        else
        xconteudo:= ' where UPPER(nome_cliente) lIKE '+ QuotedStr( '%' + UpperCase(Edit1.text) + '%' ) ;

        DMF.ZQueryClientes.SQL.Text:= 'SELECT'+ ' *'+ ' FROM CLIENTE'+ xconteudo+ ' ORDER BY CLIENTEID ASC';

      DMF.ZQueryClientes.Open;
end;

procedure TPesqClienteF.Button1Click(Sender: TObject);
begin

end;



{ TPesqClienteF }



end.

