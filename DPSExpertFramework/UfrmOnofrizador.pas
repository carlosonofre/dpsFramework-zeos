unit UfrmOnofrizador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ZConnection,StdCtrls, Buttons, CheckLst,ToolsAPI,Types,
  ComCtrls, ActnList,ZDbcIntfs,ZSqlMetadata,DPsDataManager,DpsTypes,
  System.Actions,ZAbstractConnection;
type

  TDMDPSFramework = class(TAbstractDataManager)
  private
  public
     constructor Create;override;
  end;


  TfrmOnofrizador = class(TForm)
    pnlTop: TPanel;
    pnlMidle: TPanel;
    pnlBottom: TPanel;
    ntbookGeraClasses: TNotebook;
    opdlg_selecaoArquivo: TOpenDialog;
    btnAnterior: TBitBtn;
    btnCancelaFinaliza: TBitBtn;
    chListBoxTabelas: TCheckListBox;
    Panel1: TPanel;
    chBoxTodos: TCheckBox;
    pnlFinalizaImportacao: TPanel;
    rgTypeCreatingUnits: TRadioGroup;
    rcEditInfo: TRichEdit;
    acListDpsFramework: TActionList;
    acTesteConexao: TAction;
    acProximo: TAction;
    acAnterior: TAction;
    acCancelar: TAction;
    acProcessar: TAction;
    acLocalizarBanco: TAction;
    Panel2: TPanel;
    gpboxConfigAcesso: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    lblHost: TLabel;
    Label5: TLabel;
    edtusuario: TEdit;
    edtSenha: TEdit;
    edt_path_banco: TEdit;
    btnAbrirBanco: TButton;
    edtHost: TEdit;
    edtPorta: TEdit;
    rgTypeCreatingGetterAndSetters: TRadioGroup;
    btnTestarConexao: TButton;
    edtSufixoMasterDatamamanager: TEdit;
    Label3: TLabel;
    cbDriverBanco: TComboBox;
    procedure chBoxTodosClick(Sender: TObject);
    procedure acTesteConexaoExecute(Sender: TObject);
    procedure acAnteriorExecute(Sender: TObject);
    procedure acLocalizarBancoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure acProcessarExecute(Sender: TObject);
    procedure acCancelarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FDtmOnofrizador : TDMDPSFramework;
    function  TestaConexao:Boolean;
    procedure ActivePageWizard(Activepage:Integer);
    procedure ListarTabelas;

  public
    { Public declarations }
    property DtmOnofrizador : TDMDPSFramework read FDtmOnofrizador write FDtmOnofrizador;
    constructor Create(AOwner: TComponent); override;
  end;

  const
    arquivo_conexao =  'dpsframework.conf';
    alias_conexao   =  'dpsframework';
    driver_fb_21    =  'firebirdd-2.5';

implementation

{$R *.dfm}

resourcestring
  instrucao_conexao          = '  Informe as configurações para conexão com banco de dados.';
  instrucao_selecao_tabelas  = '  Selecione as tabelas que deseja gerar classe modelo.'+#13
                             + '  Clique em [Processar] para gerar as classes modelo.';
//  instrucao_processar        = '  Clique em [Processar] para gerar as classes modelo.';


constructor TfrmOnofrizador.Create(AOwner: TComponent);
begin
  inherited;
  FDtmOnofrizador := TDMDPSFramework.Create;
end;

function TfrmOnofrizador.TestaConexao:Boolean;
begin
  Result := false;
  dtmOnofrizador.SetupConnection( alias_conexao,
                                 'firebird-2.1',
                                  edtHost.Text,
                                  edtusuario.Text,
                                  edtSenha.Text,
                                  edt_path_banco.Text,
                                  StrToIntDef(edtPorta.Text,0));
  dtmOnofrizador.ReflectionType := trDatabaseToDelphi;
  DtmOnofrizador.LoadDBParamsFromIni;
  if not dtmOnofrizador.getConnection.IsClosed then
    Result := true;
end;

procedure TfrmOnofrizador.ActivePageWizard(Activepage: Integer);
var
  ultimaPagina:Integer;
begin
  ultimaPagina  := pred(ntbookGeraClasses.Pages.Count -1);// ocultando a última página por enquanto
  ntbookGeraClasses.PageIndex := Activepage;
  rcEditInfo.Lines.Clear;
  case Activepage of
    0:rcEditInfo.Lines.Add(instrucao_conexao);
    1:rcEditInfo.Lines.Add(instrucao_selecao_tabelas);
//    2:rcEditInfo.Lines.Add(instrucao_processar);
  end;
  btnAnterior.Enabled := ntbookGeraClasses.PageIndex > 0;
//  btnProximo.Enabled  := ntbookGeraClasses.PageIndex < ultimaPagina; // desabilita na ultima pagina
  if ntbookGeraClasses.PageIndex = ultimaPagina then
  begin
    btnCancelaFinaliza.Tag :=1;
    btnCancelaFinaliza.Caption := 'Processar';
  end
  else
    begin
      btnCancelaFinaliza.Tag :=0;
      btnCancelaFinaliza.Caption := 'Cancelar';
    end;
end;

procedure TfrmOnofrizador.chBoxTodosClick(Sender: TObject);
var i:Integer;
begin
  for i:=0 to chListBoxTabelas.Count -1 do
    chListBoxTabelas.State[i]:= chBoxTodos.State;
end;

procedure TfrmOnofrizador.acTesteConexaoExecute(Sender: TObject);
begin
  if TestaConexao then
  begin
    ListarTabelas;
    ActivePageWizard(ntbookGeraClasses.PageIndex + 1);
  end;
end;

procedure TfrmOnofrizador.acAnteriorExecute(Sender: TObject);
begin
  ActivePageWizard(ntbookGeraClasses.PageIndex -1);
end;

procedure TfrmOnofrizador.acLocalizarBancoExecute(Sender: TObject);
begin
  if opdlg_selecaoArquivo.Execute then
    edt_path_banco.Text := opdlg_selecaoArquivo.FileName;
end;

procedure TfrmOnofrizador.FormShow(Sender: TObject);
begin
  ActivePageWizard(0);
end;

procedure TfrmOnofrizador.acProcessarExecute(Sender: TObject);
var
  i:Integer;
  tl :TStringList;
  sl :TStringList;
  singleUnit:string;
begin

  if not TestaConexao then
    ShowMessage('conexao está fechada');

  tl := TStringList.Create;
  sl := nil;
  try
    for i:=0 to pred(chListBoxTabelas.Items.Count) do
      if chListBoxTabelas.Checked[i] then
        tl.Add(chListBoxTabelas.Items[i]);

    case TPatternCreateUnits(rgTypeCreatingUnits.ItemIndex) of
      tcuMultiplesUnits:
      begin
        case TPatternGettersAndSetters(rgTypeCreatingGetterAndSetters.ItemIndex) of
          tpatDelphiShort : sl := dtmOnofrizador.GenerateMultiplesModelsUnit(ExtractFilePath(GetActiveProject.FileName),tl);
          tpatDelphi      : sl := dtmOnofrizador.GenerateMultiplesModelsUnit(ExtractFilePath(GetActiveProject.FileName),tl,tpatDelphi);
          tpatJava        : sl := dtmOnofrizador.GenerateMultiplesModelsUnit(ExtractFilePath(GetActiveProject.FileName),tl,tpatJava);
        end;
          for i:= 0 to pred(sl.Count-1) do
          begin
            if FileExists(sl[i]) then
              GetActiveProject.AddFileWithParent(sl[i],true,GetActiveProject.FileName);
          end;
      end;

      tcuSingleUnits:
      begin
        case TPatternGettersAndSetters(rgTypeCreatingGetterAndSetters.ItemIndex) of
          tpatDelphiShort : singleUnit := dtmOnofrizador.GenerateSingleModelsUnit(ExtractFilePath(GetActiveProject.FileName),tl);
          tpatDelphi      : singleUnit := dtmOnofrizador.GenerateSingleModelsUnit(ExtractFilePath(GetActiveProject.FileName),tl,tpatDelphi);
          tpatJava        : singleUnit := dtmOnofrizador.GenerateSingleModelsUnit(ExtractFilePath(GetActiveProject.FileName),tl,tpatJava);
        end;
        if FileExists(singleUnit) then
          GetActiveProject.AddFileWithParent(singleUnit,True,GetActiveProject.FileName);
      end;
    end;
  finally
    tl.free;
    close;
  end;
end;

procedure TfrmOnofrizador.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmOnofrizador.ListarTabelas;
var
  md_objetcts  : IZDatabaseMetadata;
  rset_tabelas : IZResultSet;
  count_tab :integer;
  fmt_caption_box_todos:string;
begin
  md_objetcts  := dtmOnofrizador.getConnection.GetMetadata;
  rset_tabelas := md_objetcts.GetTables('','','',nil);
  chListBoxTabelas.Clear;
  count_tab := 0;
  fmt_caption_box_todos := format('Tudo, (%d) Tabelas',[count_tab]);
  while rset_tabelas.Next do
  if (SameText(trim(rset_tabelas.GetStringByName('TABLE_TYPE')),'TABLE'))
  and (copy(rset_tabelas.GetStringByName('TABLE_TYPE'),4,1) <> '$') then
    begin
      chListBoxTabelas.Items.Add(rset_tabelas.GetStringByName('TABLE_NAME'));
      inc(count_tab);
      chBoxTodos.Caption := format('Tudo, (%d) Tabelas',[count_tab]);
    end;
end;


procedure TfrmOnofrizador.acCancelarExecute(Sender: TObject);
begin
  if btnCancelaFinaliza.Tag = 1 then
    acProcessar.Execute
  else
    close;
end;

{ TDMDPSFramework }

constructor TDMDPSFramework.Create;
begin
  IniFileConfig  := arquivo_conexao;
  ALIAS          := alias_conexao;

  SetupConnection(alias_conexao,
                  driver_fb_21,
                  '',
                  'SYSDBA',
                  'masterkey',
                  format('%s%s',[ExtractFilePath(ParamStr(0)),'dpsframework.fdb']),
                  0,
                  True,
                  True);
  inherited;
end;

end.


