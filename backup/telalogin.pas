unit telaLogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls,
  StdCtrls, MenuPrincipal,DataModule;

type

  { TtelaLoginF }

  TtelaLoginF = class(TForm)
    BitBtnEntrar: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtnEntrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
      FormMenu: TMenuPrincipalF;
      function ValidaUsuario(pUsusario: String; pSenha: String): Boolean;
  public

  end;

var
  telaLoginF: TtelaLoginF;

implementation

{$R *.lfm}

{ TtelaLoginF }

//entrar
procedure TtelaLoginF.BitBtnEntrarClick(Sender: TObject);
begin
      if ValidaUsuario(Edit1.Text, Edit2.Text) = True then
       begin
            if not Assigned(FormMenu) then
             MenuPrincipalF := TMenuPrincipalF.Create(Self);
             MenuPrincipalF.ShowModal;
       end;
end;

//fechar
procedure TtelaLoginF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
     CloseAction:=caFree;
end;

//valida Usuaario
function TtelaLoginF.ValidaUsuario(pUsusario: String; pSenha: String): Boolean;
begin
   if (pUsusario = '') then
   begin
      ShowMessage('Favor Preencha o Usuário!');
      Exit;
   end;

   if (pSenha = '') then
   begin
      ShowMessage('Favor Preencha a Senha!');
      Exit;
   end;

   DMF.ZQueryGenerica.Close;
   DMF.ZQueryGenerica.SQL.Clear;
   DMF.ZQueryGenerica.SQL.Add('SELECT COUNT(*) AS NUMBER '+
                                   'FROM USUARIOS '+
                                   'WHERE USUARIO = ' +  QuotedStr(pUsusario) + ' ' +
                                   'AND SENHA = ' + QuotedStr(pSenha));
   DMF.ZQueryGenerica.Open;

   if DMF.ZQueryGenerica.FieldByName('NUMBER').AsInteger = 0 then
   Begin
      ShowMessage('Senha ou Usuário incorretos!');
      Result := False
   end
   else
      Result := True;

end;


end.

