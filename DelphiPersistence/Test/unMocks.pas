unit unMocks;

interface

uses

  Winapi.Windows,Messages,SysUtils,Variants,Classes,Vcl.Graphics,System.Generics.Collections,
  cxListView,ZDbcIntfs,
  (* comum a todas as classes de persistência*)
  DB,DPsTypes,DPsDataManager,DBClient;

type


  IntID                  = Int64;
  DataPersonalizada      = TDate;
  HoraPersonalizada      = TTime;
  DataHoraPersonalizada  = TDateTime;
  PequenoInt             = Smallint;
  BitMap                 = TBitmap;
  Enumeracao             = (enUm,enDois,enTres);
  SetDeEnumeracao        = set of Enumeracao;
  TipoDataPersonalizada  = TDateTime;
  FakeBoolean            = Boolean;
  Dinheiro               = Currency;
  SetDeBytes             = set of Byte;

(*  NOTA IMPORTANTE:

  o TIPO TBitmap aparece na unit Windows e Graphics, a que queremos está na Graphics, para
  o caso de propriedades do tipo bitmap, se não declarar na unit dos modelos um erro silencioso
  ocorre na captura das propriedades,não cria a propriedade e não te informa nada, Cuidado!
*)

  TDBModelTeste = class(TDPSAbstractModel)
  private
    FCampoAnsiString: AnsiString;
    FCampoFoto: BitMap;
    FCampoBoleano: Boolean;
    FCampoCurrency: Currency;
    FCampoDouble: Double;
    FCampoDoublePersonalizado:dps_Double;
    FCampoEnumerado: Enumeracao;
    FCampoFloat: Extended;
    FCampoFloatPersonalizado :dps_Extended;
    FCampoIntegerDelphi: Integer;
    FCampoid: IntID;
    FCampoStringcomum: String;
    FCampoNome: dps_String_100;
    FCampoDescricao: dps_String_200;
    FCampoWideString: WideString;
    FCampoSetDeEnumeracao: SetDeEnumeracao;
    FCampoSmallint :PequenoInt;
    FCampoData: TDate;
    FCampoDataPersonalizada:DataPersonalizada;
    FCampoHora: TTime;
    FCampoHoraPersonalizada: HoraPersonalizada;
    FCampoTimestamp: TDateTime;
    FCampoDataHoraPersonalizada :DataHoraPersonalizada;
    FCampoFakeBoolean:FakeBoolean;
    FCampoDinheiro:Dinheiro;
  public
    constructor Create(dmgr:IDataManager);
    function getByID(id:Int64=-1):TDBModelTeste;

  published
    property Campoid: IntID read FCampoid write FCampoid;
    property CampoNome :dps_String_100 read FCampoNome write FCampoNome;
    property CampoDescricao :dps_String_200 read FCampoDescricao write FCampoDescricao;
    property CampoFoto :BitMap read FCampoFoto write FCampoFoto;
    property CampoAnsiString : AnsiString read FCampoAnsiString write FCampoAnsiString;
    property CampoWideString: WideString read FCampoWideString write FCampoWideString;
    property CampoEnumerado:Enumeracao read FcampoEnumerado write FcampoEnumerado;
    property CampoStringcomum :String read FCampoStringcomum write FCampoStringcomum;
    property CampoDouble :Double read FCampoDouble write FCampoDouble;
    property CampoDoublePersonalizado :dps_Double read FCampoDoublePersonalizado write FCampoDoublePersonalizado;
    property CampoFloat  :Extended read FCampoFloat write FCampoFloat;
    property CampoFloatPersonalizado  :dps_Extended read FCampoFloatPersonalizado write FCampoFloatPersonalizado;
    property CampoCurrency :Currency read FCampoCurrency write FCampoCurrency;
    property CampoBoleano :Boolean read FCampoBoleano write FCampoBoleano default False;
    property CampoIntegerDelphi :Integer read FCampoIntegerDelphi write FCampoIntegerDelphi;
    property CampoSetDeEnumeracao : SetDeEnumeracao read FCampoSetDeEnumeracao write FCampoSetDeEnumeracao;
    property CampoSmallint: PequenoInt read FCampoSmallint write FCampoSmallint;
    property CampoData: TDate read FCampoData write FCampoData;
    property CampoDataPersonalizada : DataPersonalizada read FCampoDataPersonalizada write FCampoDataPersonalizada;
    property CampoHora:TTime read FCampoHora Write FCampoHora;
    property CampoHoraPersonalizada:HoraPersonalizada read FCampoHoraPersonalizada Write FCampoHoraPersonalizada;
    property CampoTimestamp: TDateTime read FCampoTimestamp write FCampoTimestamp;
    property CampoDataPersonal : TipoDataPersonalizada read FCampoDataHoraPersonalizada write FCampoDataHoraPersonalizada;
    property CampoFakeBoolean:FakeBoolean read FCampoFakeBoolean write FCampoFakeBoolean default false;
    property CampoDinheiro:Dinheiro read FCampoDinheiro write FCampoDinheiro;
  end;

  TDBModelDetalheTeste = class(TDPSAbstractModel)
  private
    FCampoIDDetalhe:IntID;
    FReferenciaCampoIdModel:IntID;
    FCampoInteiro:Integer;
    FCampoNome: String;
  public
    constructor Create(dmgr:IDataManager);override;
  published
    property CampoIDDetalhe :IntID read FCampoIDDetalhe write FCampoIDDetalhe;
    property ReferenciaCampoIdModel:IntID read FReferenciaCampoIdModel write FReferenciaCampoIdModel;
    property CampoNome:String read FCampoNome write FCampoNome;
    property CampoInteiro :Integer read FCampoInteiro write FCampoInteiro;
  end;

  (*  objeto principal que vai criar a estrutura do banco *)
  TMasterDatamanagerTest = class(TAbstractDataManager)
  private
    FModelDB:TDBModelTeste;
    FModelDBDetalhe:TDBModelDetalheTeste;
  public
    property ModelDB:TDBModelTeste read FModelDB write FModelDB;
    property ModelDBDetalhe:TDBModelDetalheTeste read FModelDBDetalhe write FModelDBDetalhe;
    constructor Create;override;
  end;

implementation

{ TDBModelTeste }
constructor TDBModelTeste.Create(dmgr:IDataManager);
begin
  FCampoid              := -1;
  KeyFieldAutoGenerated := True;
  inherited;
  SetupKeyField('CampoID');
  SetupPrimaryKey(Format('pk%s',[KeyFieldName]),TableName,KeyFieldName,[]);
  SetupUniqueKey('UKDBModelTeste',TableName,['CampoNome','CampoDescricao']);
  SetupIndex('IDXCAMPONOME',TableName,['CAMPONOME']);
end;

function TDBModelTeste.getByID(id:Int64): TDBModelTeste;
var
  rset:IZResultSet;
begin
  Result := TDBModelTeste.Create(Datamanager);
  rset   := Datamanager.get(format('select * from %s where %s = %d',[result.TableName,result.KeyFieldName,id]));
  result.fillProperties(rset);
end;

{ TDBModelDetalheTeste }
constructor TDBModelDetalheTeste.Create(dmgr: IDataManager);
begin
  inherited Create(dmgr);
  FCampoIDDetalhe       := -1;
  SetupKeyField('CampoIDDetalhe');
  KeyFieldAutoGenerated := True;
  SetupPrimaryKey(Format('pk%s',[KeyFieldName]),TableName,KeyFieldName,[]);
  SetupForeignKey('FKReferenciaCampoIdModel',TableName,'DBModelTeste',trcNone,trcNone,['ReferenciaCampoIdModel'],['CampoID']);
 end;

constructor TMasterDatamanagerTest.Create;
begin
  IniFileConfig  := 'teste_unitario.conf';
  ALIAS          := 'teste.teste_unitario';
  SetupConnection(ALIAS,
                  'firebirdd-2.5',
                  '',
                  'SYSDBA',
                  'masterkey',
                  format('%s%s',[ExtractFilePath(ParamStr(0)),'Dados\'+'teste_unitario.fdb']),
                  0,
                  True,
                  True);
  inherited;
  FModelDB        :=  TDBModelTeste.Create(self);
  FModelDBDetalhe :=  TDBModelDetalheTeste.Create(self);
  UpdateStructureDatabase(2);
end;


end.
