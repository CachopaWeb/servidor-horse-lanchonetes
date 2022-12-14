unit ServerHorse.Model.Connection;

interface

uses
  System.JSON,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  Data.DB,
  FireDAC.Comp.Client,
  Firedac.DApt,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  System.Generics.Collections;

var
  FDriver : TFDPhysFBDriverLink;
  FConnList : TObjectList<TFDConnection>;

function Connected : Integer;
procedure Disconnected(Index : Integer);

implementation

uses UnitConstants;

function Connected : Integer;
begin
  if not Assigned(FConnList) then
    FConnList := TObjectList<TFDConnection>.Create;

  FConnList.Add(TFDConnection.Create(nil));
  Result := Pred(FConnList.Count);
  FConnList.Items[Result].Params.DriverID := 'FB';
  FConnList.Items[Result].Params.Database := TConstants.BancoDados;
  FConnList.Items[Result].Params.UserName := 'SYSDBA';
  FConnList.Items[Result].Params.Password := 'masterkey';
  FConnList.Items[Result].Params.Add('CharacterSet=utf8');
  FConnList.Items[Result].Connected;
end;

procedure Disconnected(Index : Integer);
begin
  FConnList.Items[Index].Connected := False;
  FConnList.Items[Index].Free;
end;

end.
