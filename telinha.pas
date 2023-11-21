unit telinha;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, DataModule, pesqProduto, DB ;

type

  { TtelinhaF }

  TtelinhaF = class(TForm)
    BitBtnSalvar: TBitBtn;
    BitBtnCancelar: TBitBtn;
    Datatelinha: TDataSource;
    DBEditvlTotal: TDBEdit;
    DBEditQuant: TDBEdit;
    DBEditProdutoId: TDBEdit;
    DBEditvalorunit: TDBEdit;
    DBEditprodutodesc: TDBEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure BitBtnSalvarClick(Sender: TObject);
    procedure DBEditQuantExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
         FormPesquisaritem: TPesqProdutoF ;
  public

  end;

var
  telinhaF: TtelinhaF;

implementation

uses
  cadOrcamento;

{$R *.lfm}

//abre o form
procedure TtelinhaF.FormShow(Sender: TObject);
begin
    DMF.ZQueryOrcamento_item.Open;
end;

// abre pesquisar
procedure TtelinhaF.SpeedButton1Click(Sender: TObject);
begin
        if not Assigned(FormPesquisaritem) then
     PesqProdutoF := TPesqProdutoF.Create(Self);
     PesqProdutoF.Show;
end;


//fecha o form
procedure TtelinhaF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
    //DMF.ZQueryOrcamento_item.Close;
   CloseAction:=caFree;
end;

//soma
procedure TtelinhaF.DBEditQuantExit(Sender: TObject);
begin
     DMF.ZQueryOrcamento_itemvl_total.AsFloat:= (StrToFloat(DBEditQuant.Text) * DMF.ZQueryOrcamento_itemvl_unitario.AsFloat);
end;

//cancelar
procedure TtelinhaF.BitBtnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Cancelar a edição? Todas as alterações não salvas serão perdidas.',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  DMF.ZQueryOrcamento_item.Cancel;
  Close;
end;


//SAlvar
procedure TtelinhaF.BitBtnSalvarClick(Sender: TObject);
begin
     DMF.ZQueryOrcamento_item.Post;
     DMF.SomaItens;
       Close;
end;

end.

