unit telaModelo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Buttons;

type

  { TtelaModeloF }

  TtelaModeloF = class(TForm)
    BitBtnCancelar: TBitBtn;
    BitBtnExcluir: TBitBtn;
    BitBtnAlterar: TBitBtn;
    BitBtnGravar: TBitBtn;
    BitBtnFechar: TBitBtn;
    BitBtnNovo: TBitBtn;
    BitBtnPesquisar: TBitBtn;

    cadastrar: TTabSheet;
    edtPesquisar: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    TabSheet1: TTabSheet;
  private

  public

  end;

var
  telaModeloF: TtelaModeloF;

implementation

{$R *.lfm}

{ TtelaModeloF }


end.

