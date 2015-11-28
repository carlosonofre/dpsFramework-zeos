unit UDPSExpert;

interface

uses
   ToolsAPI, Classes, Windows, Menus,StrUtils;


type

   TCustomMenuItem = class(TNotifierObject, IOTAWizard, IOTAMenuWizard)
     function GetIDString: string;
     function GetName: string;
     function GetState: TWizardState;
     procedure Execute;
     function GetMenuText: string;
   end;

   TCustomMenuHandler = class(TObject)
     procedure HandleClick(Sender: TObject);
   end;

procedure Register;

implementation

uses
  Dialogs, UfrmOnofrizador, Forms;

const

  Titulo         = 'DPS Framework';
  CaptionDoItem  = 'Gerador de Classes';

var

  opcao_menu : Integer;
  mnuitem: TMenuItem;
  CustomMenuHandler: TCustomMenuHandler;

 { TMenuItem }

procedure TCustomMenuItem.Execute;
begin
  ShowMessage('About...');
end;

function TCustomMenuItem.GetIDString: string;
begin
  Result := 'dpsExpertMenuItem';
end;

function TCustomMenuItem.GetMenuText: string;
begin
  Result := 'About DPS Framework';
end;

function TCustomMenuItem.GetName: string;
begin
  Result := 'dpsExpertMenuItem';
end;

function TCustomMenuItem.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TCustomMenuHandler.HandleClick(Sender: TObject);
begin
  TfrmOnofrizador.Create(nil).ShowModal;
end;


procedure AddIDEMenu;
var
  NTAServices: INTAServices40;
begin
  NTAServices := BorlandIDEServices as INTAServices40;

  if NTAServices.MainMenu.Items.Find(Titulo) = nil then
  begin
    NTAServices.MainMenu.Items.Add(TMenuItem.Create(nil));
    TMenuItem( NTAServices.MainMenu.Items[NTAServices.MainMenu.Items.Count-1]).Caption := 'DPS Framework';
  end;

  opcao_menu := NTAServices.MainMenu.Items.IndexOf(NTAServices.MainMenu.Items.Find(Titulo));

  if NTAServices.MainMenu.Items[opcao_menu].Find('DPSEXPERTMenu') = nil then
  begin
    CustomMenuHandler := TCustomMenuHandler.Create;
    mnuitem := TMenuItem.Create(nil);
    mnuitem.Caption := CaptionDoItem;
    mnuitem.OnClick := CustomMenuHandler.HandleClick;
    NTAServices.MainMenu.Items[opcao_menu].Add(mnuitem)
  end;
end;

procedure RemoveIDEMenu;
var
  NTAServices: INTAServices40;
begin
  if Assigned(mnuitem) then
  begin
    NTAServices := BorlandIDEServices as INTAServices40;
    mnuitem.Free;
    NTAServices.MainMenu.Items.Find(Titulo).Free;
  end;
end;

procedure Register;
begin
  RegisterPackageWizard(TCustomMenuItem.Create);
  AddIDEMenu;
end;

initialization
  mnuitem := nil;
  CustomMenuHandler := nil;

finalization
  RemoveIDEMenu;

end.
