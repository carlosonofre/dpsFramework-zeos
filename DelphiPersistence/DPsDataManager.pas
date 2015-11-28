{******************************************************************************}
{                                                                              }
{          Test Name:   Delphi Persistence Framework                           }
{             Author:   Bianco conofresilva@gmail.com                          }
{            Version:   3.0                                                    }
{            Summary:   Framework persistência em Delphi                       }
{           Comments:   2011-2013                                              }
{                                                                              }
{******************************************************************************}

unit DPsDataManager;

interface

uses

 Windows, Messages,SysUtils,Classes,TypInfo,Graphics,Controls,Variants,
 Forms,Dialogs,Contnrs,StdCtrls,Registry,IniFiles,DB,DPsTypes,StrUtils,
 Math,System.Generics.Collections,Datasnap.DBClient,System.Rtti,

(* Biblioteca completa Zeos Lib *)
(* component *)
ZAbstractConnection,
ZAbstractDataset,
ZAbstractRODataset,
ZAbstractTable,
ZComponentReg,
ZConnection,
ZConnectionGroup,
ZDataset,
ZDatasetUtils,
ZGroupedConnection,
ZIBEventAlerter,
ZPgEventAlerter,
ZPropertyEditor,
//ZQuerySQLEditor,
//ZROSqlEditor,
ZSequence,
ZSqlMetadata,
ZSqlMonitor,
ZSqlProcessor,
ZSqlStrings,
//ZSqlTestForm,
ZSqlUpdate,
ZStoredProcedure,
ZStreamBlob,
ZUpdateSqlEditor,
(* core *)
ZClasses,
ZCollections,
ZCompatibility,
ZEncoding,
ZExpression,
ZExprParser,
ZExprToken,
ZFunctions,
ZFunctionsConvert,
ZFunctionsDateTime,
ZFunctionsMath,
ZFunctionsOther,
ZFunctionsStrings,
ZMatchPattern,
ZMessages,
ZSysUtils,
ZTokenizer,
ZURL,
ZVariables,
ZVariant,
(* Dbc *)
ZDbcAdo,
ZDbcAdoMetadata,
ZDbcAdoResultSet,
ZDbcAdoStatement,
ZDbcAdoUtils,
ZDbcASA,
ZDbcASAMetadata,
ZDbcASAResultSet,
ZDbcASAStatement,
ZDbcASAUtils,
ZDbcCache,
ZDbcCachedResultSet,
ZDbcConnection,
ZDbcDbLib,
ZDbcDbLibMetadata,
ZDbcDbLibStatement,
ZDbcDbLibUtils,
ZDbcGenericResolver,
ZDbcInterbase6,
ZDbcInterbase6Metadata,
ZDbcInterbase6ResultSet,
ZDbcInterbase6Statement,
ZDbcInterbase6Utils,
ZDbcIntfs,
ZDbcLogging,
ZDbcMetadata,
ZDbcMySql,
ZDbcMySqlMetadata,
ZDbcMySqlResultSet,
ZDbcMySqlStatement,
ZDbcMySqlUtils,
ZDbcOracle,
ZDbcOracleMetadata,
ZDbcOracleResultSet,
ZDbcOracleStatement,
ZDbcOracleUtils,
ZDbcPooled,
ZDbcPostgreSql,
ZDbcPostgreSqlMetadata,
ZDbcPostgreSqlResultSet,
ZDbcPostgreSqlStatement,
ZDbcPostgreSqlUtils,
ZDbcResultSet,
ZDbcResultSetMetadata,
ZDbcSqLite,
ZDbcSqLiteMetadata,
ZDbcSqLiteResultSet,
ZDbcSqLiteStatement,
ZDbcSqLiteUtils,
ZDbcStatement,
ZDbcUtils,
(* parseSql *)
ZAdoToken,
ZGenericSqlAnalyser,
ZGenericSqlToken,
ZInterbaseAnalyser,
ZInterbaseToken,
ZMySqlAnalyser,
ZMySqlToken,
ZOracleAnalyser,
ZOracleToken,
ZPostgreSqlAnalyser,
ZPostgreSqlToken,
ZScriptParser,
ZSelectSchema,
ZSqLiteAnalyser,
ZSqLiteToken,
ZSybaseAnalyser,
ZSybaseToken,
//ZParseSql,
(* plain *)
ZPlainAdo,
ZPlainAdoDriver,
ZPlainASAConstants,
ZPlainASADriver,
ZPlainDbLibConstants,
ZPlainDbLibDriver,
ZPlainDriver,
ZPlainFirebirdDriver,
ZPlainFirebirdInterbaseConstants,
ZPlainLoader,
ZPlainMySqlConstants,
ZPlainMySqlDriver,
ZPlainOracleConstants,
ZPlainOracleDriver,
ZPlainPostgreSqlDriver,
ZPlainSqLiteDriver;

{$M+}
type

 STR_GUID = STRING[36];

 EDPSException = Exception;

 TModelState = (msInsert,msUpdate);
 TParamController = packed record
   ParamName:String;
   ParamValue:String;
 end;
 TParamsControler = array of TParamController;
 TAbstractDataManager = class;

 IDataManager = interface ['{0A41F59B-7B1A-4B09-8D87-252ADDCF3689}']
     procedure SetupConnection(connectionName,driver,host,user,password,path:string;port:integer=0;embedded:boolean=false;createDB:Boolean=false;regLog:Boolean=false);
     procedure ResetReflection(var dtReflec:TDataReflection );
     function  ConfigReflecion(dTypeName:String;
                               tKind:TTypeKind;
                               frValues :array of String;
                               size:Int64=0;
                               precision:Int64=0;
                               defValue:String='';
                               ntNativeType:TNativeType=ntUnknow;
                               alowNull:Boolean = True):TDataReflection;
    procedure LoadDBParamsFromIni;
    procedure Setup;
    procedure UpdateStructureDatabase(NewVersion:Integer);

    function getConnection:IZConnection;overload;                               (* implementado *)
    function getConection:TZConnection;overload;                                (* implementado *)

    function getFullPathIniFileConfig:String;


    procedure CreateDatabase_Firebird;                                          (* implementado *)
    procedure ExecuteScript(temp_script:String);                                (* implementado *)
    procedure ResetLogBusinessRule;                                             (* implementado *)
    procedure AddLogBusinessRule(ruleCode:String;fmtMessageRule:                (* implementado *)
                                 String;tpRule:TTypeBusinessRule=sbrError);     (* implementado *)
    function GeneratorExists(generatorName:String):boolean;                     (* implementado *)
    function CreateGenerator(sGeneratorName:String):Boolean;                    (* implementado *)
    function getTempQuery(sql:string):TZQuery;                                  (* implementado *)

    function SetupReflection(dtReflec:TDataReflection):Integer;                 (* implementado *)
    function SetupTableReflection(var tbReflec:TReflection):Integer;            (* implementado *)

    function SetupIndex(modelIndex:TIndex):Integer;                             (* implementado *)
    function SetupPrimaryKey(pmKey:TConstraintPrimaryKey):Integer;              (* implementado *)
    function SetupForeignKey(fhKey:TConstraintForeignKey):Integer;              (* implementado *)
    function SetupUniqueKey(unKey:TConstraintUniqueKey):Integer;                (* implementado *)
    function SetupDynamicType(DynType:TDynamicType):Integer;                    (* implementado *)

    procedure ConvertDataType(var dtReflection :TDataReflection);               (* implementado *)

    function ValidateNativeTypeByName(sNameType:String):TNativeType;            (* implementado *)
    function OwnTypeExists(OwnTypeName:String):Boolean;                         (* implementado *)
    function TableExists(TableName:String):Boolean;                             (* implementado *)
    function FieldInTableExists(TableName:String;FieldName:String):boolean;     (* implementado *)
    function IndexExists(indexName:String):boolean;                             (* implementado *)
    function ConstraintExists(ConstraintName:String):boolean;                   (* implementado *)

    (* rotinas para cria os objetos no banco de dados por script sql  *)
    procedure GenerateScriptOwnTypes;                                           (* implementado *)
    procedure GenerateScriptTables;                                             (* implementado *)
    procedure GenerateScriptIndexs;                                             (* implementado *)
    procedure GenerateScriptConstraintsPrimaryKey;                              (* implementado *)
    procedure GenerateScriptConstraintsForeignKey;                              (* implementado *)
    procedure GenerateScriptConstraintsUniqueKey;                               (* implementado *)
    procedure GenerateScriptGeneratorsFirebirdOnly;                             (* implementado *)

    procedure setParam(pName:String;pValue:String);                             (* implementado *)
    procedure setParamFromIni(pSessionName:String;pName:String;pValue:String);                      (* implementado *)
    function  getParam(pName:String;pDefaultValue:String=''):String;            (* implementado *)
    function  getParamFromIni(pSessionName:String;pName:String;pDefaultValue:String=''):String;     (* implementado *)
    procedure CreateDatabase;

    (* ---- trecho dedicado a geração de código a partir da base de dados  ----- *)
    procedure GeneratePropertiesDPSUnit(sEntity: string; var slContentUnit:TStringList;PatGetSet:TPatternGettersAndSetters=tpatDelphiShort);
    procedure GenerateImplementDPSUnit(sEntity: string; var slContentUnit:TStringList;PatGetSet:TPatternGettersAndSetters=tpatDelphiShort);
    (* Rotinas para gerar o master datamanager ... *)
    function  getTableKeyFieldFromDatabase(sTable:String):String;               (* implementado *)
    procedure GenerateNewDelphiTypesFromDatabase(var strListContainer:TStringList);
    procedure GeneratePropertiesMasterDataManager(strClassList:TStringList; var strListContainer:TStringList;PatGetSet:TPatternGettersAndSetters=tpatDelphiShort);
    procedure GenerateImplementsMasterDataManager(strClassList:TStringList; var strListContainer:TStringList;PatGetSet:TPatternGettersAndSetters=tpatDelphiShort);
    function GenerateMultiplesModelsUnit(sUnitsPath:string;TableList:TStringList;PatternGetSet:TPatternGettersAndSetters=tpatDelphiShort):TStringList;
    function GenerateSingleModelsUnit(sUnitPath:string;TableList:TStringList;PatternGetSet:TPatternGettersAndSetters=tpatDelphiShort):String;
    { rotinas para geracao de classes controller, usados pelo wizard    }
    procedure getReflectionsFromDatabase(var vReflections:TReflection; table:string ='');
    procedure getIndexesFromDatabase(table:string;var rsIndexes:TIndexes);
    procedure getPrimaryKeysFromDatabase(table:string;var rsPrimaryKeys:TConstraintPrimaryKeys);
    procedure getForeignKeysFromDatabase(table:string;var rsForeignKeys:TConstraintForeignKeys);
    procedure getUniqueKeysFromDatabase(table:string;var rsUniqueKeys:TConstraintUniqueKeys);
    (* rotinas para gerar código no create dos modelos para registrar constraints em runtime *)
    procedure generateSetupIndexesFromDatabase(sTableName:String; var strContainer:TStringList);
    procedure generateSetupPrimaryKeysFromDatabase(sTableName: String; var strContainer:TStringList);
    procedure generateSetupForeignKeysFromDatabase(sTableName: String; var strContainer:TStringList);
    procedure generateSetupUniqueKeysFromDatabase(sTableName: String; var strContainer:TStringList);
    procedure generateSetupCheckKeysFromDatabase(sTableName: String; var strContainer:TStringList);
    (* --------------------------------------------------------------------------------------- *)

    (* métodos das propriedades *)
    function getIniFileConfig:String;
    function getAlias :String;
    function getMdIndexes:TIndexes;
    function getMdPrimaryKeys:TConstraintPrimaryKeys;
    function getMdForeignKeys:TConstraintForeignKeys;
    function getMdUniqueKeys:TConstraintUniqueKeys;
    function getReflectionType:TTypeReflection;
    function getVersionCoreDB:Int64;
    function getVersionDatabase:Int64;
    function getDialectCoreDB:Int64;
    function getDmDynamicTypes:TDynamicTypes;
    function getDmReflections:TReflection;
    function getTableReflections:TTableReflections;
    function getLogs:TStringList;
    function getParams:TParamsControler;
    function getTypeDatabase:TTypeOfDatabase;
    function getTypeNode:TTypeNode;
    function getCountErrors:Int64;
    function getCountWarnings:Int64;
    function getCountHints:Int64;
    function getCountLogs:Int64;
    function getLocalServer:Boolean;
    function getBusinessRules:TBusinessRules;
    function getConnectionString:String;

    procedure setIniFileConfig(const Value:String);
    procedure setAlias ( const Value:String);
    procedure setMdIndexes( const Value:TIndexes);
    procedure setMdPrimaryKeys( const Value:TConstraintPrimaryKeys);
    procedure setMdForeignKeys( const Value:TConstraintForeignKeys);
    procedure setMdUniqueKeys( const Value:TConstraintUniqueKeys);
    procedure setReflectionType( const Value:TTypeReflection);
    procedure setVersionCoreDB( const Value:Int64);
    procedure setVersionDatabase( const Value:Int64);
    procedure setDialectCoreDB( const Value:Int64);
    procedure setTypeDatabase( const Value :TTypeOfDatabase);
    procedure setDmDynamicTypes( const Value:TDynamicTypes);
    procedure setDmReflections( const Value:TReflection);
    procedure setTableReflections( const Value:TTableReflections);
    procedure setLogs( const Value:TStringList);
    procedure setTypeNode(const Value:TTypeNode);
    procedure setLocalServer(const Value:Boolean);
    procedure setBusinessRules(const Value:TBusinessRules);
    procedure setConnectionString(const Value:String);

    property IniFileConfig:String read getIniFileConfig write SetIniFileConfig;
    property Alias :String read getAlias write setAlias;
    property MdIndexes:TIndexes read getMdIndexes write setMdIndexes;
    property MdPrimaryKeys:TConstraintPrimaryKeys read getMdPrimaryKeys write setMdPrimaryKeys;
    property MdForeignKeys:TConstraintForeignKeys read getMdForeignKeys write setMdForeignKeys;
    property MdUniqueKeys:TConstraintUniqueKeys read getMdUniqueKeys write setMdUniqueKeys;
    property ReflectionType:TTypeReflection read getReflectionType write setReflectionType;
    property VersionCoreDB:Int64 read getVersionCoreDB write setVersionCoreDB;
    property VersionDatabase:Int64 read getVersionDatabase write setVersionDatabase;
    property DialectCoreDB:Int64 read getDialectCoreDB write setDialectCoreDB;
    property TypeDatabase: TTypeOfDatabase read getTypeDatabase write setTypeDatabase;
    property DmDynamicTypes:TDynamicTypes read getDmDynamicTypes write setDmDynamicTypes;
    property DmReflections:TReflection read getDmReflections write setDmReflections;
    property TableReflections:TTableReflections read getTableReflections write setTableReflections;
    property Logs:TStringList read getLogs write setLogs;
    property TypeNode:TTypeNode read getTypeNode write setTypeNode;
    property Params:TParamsControler read getParams ;
    property CountErrors:Int64 read getCountErrors;
    property CountWarnings:Int64 read getCountWarnings;
    property CountHints:Int64 read getCountHints;
    property CountLogs:Int64 read getCountHints;
    property LocalServer:Boolean read getLocalServer write setLocalServer;
    property BusinessRules:TBusinessRules read getBusinessRules write setBusinessRules;
    property ConnectionString:String read getConnectionString write setConnectionString;
 end;

 TAbstractDataManager = class(TInterfacedObject,IDataManager)
 private
    { Private declarations }
    FIniFileConfig   : String;
    FALIAS           : String;
    FmdIndexes       : TIndexes;
    FmdPrimaryKeys   : TConstraintPrimaryKeys;
    FmdForeignKeys   : TConstraintForeignKeys;
    FmdUniqueKeys    : TConstraintUniqueKeys;
    FReflectionType  : TTypeReflection;  (*  banco - delphi ou vice-versa *)
    FVersionCoreDB   : Int64;
    FNewVersionDB    : Int64;
    FVersionDatabase : Int64;
    FDialectCoreDB   : Int64;
    FDmDynamicTypes  : TDynamicTypes;
    FDmReflections   : TReflection;      (*  para domain *)
    FTableReflections: TTableReflections;(*  reflexos dos modelos *)
    FParams          : TParamsControler;
    FTypeNode        : TTypeNode;
    FLocalServer     : Boolean;
    FKeyFieldAutoGenerated: Boolean;
    FBusinessRules   : TBusinessRules;
    FCountErrors     : Int64;
    FCountWarnings   : Int64;
    FCountHints      : Int64;
    FLogs            : TStringList;
    FMonitor         : TZSQLMonitor;
    FConnectionString: String;
    FTypeDatabase    : TTypeOfDatabase;
 public
    function getIniFileConfig:String;
    function getAlias :String;
    function getMdIndexes:TIndexes;
    function getMdPrimaryKeys:TConstraintPrimaryKeys;
    function getMdForeignKeys:TConstraintForeignKeys;
    function getMdUniqueKeys:TConstraintUniqueKeys;
    function getReflectionType:TTypeReflection;
    function getVersionCoreDB:Int64;
    function getVersionDatabase:Int64;
    function getDialectCoreDB:Int64;
    function getDmDynamicTypes:TDynamicTypes;
    function getDmReflections:TReflection;
    function getTableReflections:TTableReflections;
    function getLogs:TStringList;
    function getParams:TParamsControler;
    function getTypeDatabase:TTypeOfDatabase;
    function getTypeNode:TTypeNode;
    function getCountErrors:Int64;
    function getCountWarnings:Int64;
    function getCountHints:Int64;
    function getCountLogs:Int64;
    function getLocalServer:Boolean;
    function getBusinessRules:TBusinessRules;
    function getConnectionString:String;
    function getKeyFieldAutoGenerated:Boolean;

    procedure setIniFileConfig(const Value:String);
    procedure setAlias ( const Value:String);
    procedure setMdIndexes( const Value:TIndexes);
    procedure setMdPrimaryKeys( const Value:TConstraintPrimaryKeys);
    procedure setMdForeignKeys( const Value:TConstraintForeignKeys);
    procedure setMdUniqueKeys( const Value:TConstraintUniqueKeys);
    procedure setReflectionType( const Value:TTypeReflection);
    procedure setVersionCoreDB( const Value:Int64);
    procedure setVersionDatabase( const Value:Int64);
    procedure setDialectCoreDB( const Value:Int64);
    procedure setTypeDatabase( const Value :TTypeOfDatabase);
    procedure setDmDynamicTypes( const Value:TDynamicTypes);
    procedure setDmReflections( const Value:TReflection);
    procedure setTableReflections( const Value:TTableReflections);
    procedure setLogs( const Value:TStringList);
    procedure setTypeNode(const Value:TTypeNode);
    procedure setLocalServer(const Value:Boolean);
    procedure setBusinessRules(const Value:TBusinessRules);
    procedure setConnectionString(const Value:String);
    procedure setKeyFieldAutoGenerated(const Value:Boolean);
    procedure SetupConnection(connectionName,driver,host,user,password,path:string;port:integer=0;embedded:boolean=false;createDB:Boolean=false;regLog:Boolean=false);
    procedure ResetReflection(var dtReflec:TDataReflection );
    function  ConfigReflecion(dTypeName:String;
                                  tKind:TTypeKind;
                               frValues:array of String;
                                   size:Int64=0;
                              precision:Int64=0;
                               defValue:string='';
                           ntNativeType:TNativeType=ntUnknow;
                               alowNull:Boolean = True):TDataReflection;

    constructor Create;virtual;
    destructor  Destroy;
    procedure   LoadDBParamsFromIni;

    procedure Setup;
    procedure UpdateStructureDatabase(NewVersion:Integer);

    function getConnection:IZConnection;overload;                               (* implementado *)
    function getConection:TZConnection;                                         (* implementado *)

    procedure CreateDatabase_Firebird;                                          (* implementado *)
    procedure ExecuteScript(temp_script:String);                                (* implementado *)
    procedure ResetLogBusinessRule;                                             (* implementado *)
    procedure AddLogBusinessRule(ruleCode:String;fmtMessageRule:               (* implementado *)
                                 String;tpRule:TTypeBusinessRule=sbrError);     (* implementado *)
    function GeneratorExists(generatorName:String):boolean;                     (* implementado *)
    function CreateGenerator(sGeneratorName:String):Boolean;                    (* implementado *)
    function getTempQuery(sql:string):TZQuery;                                  (* implementado *)

    function SetupReflection(dtReflec:TDataReflection):Integer;                 (* implementado *)
    function SetupTableReflection(var tbReflec:TReflection):Integer;            (* implementado *)

    function SetupIndex(modelIndex:TIndex):Integer;                             (* implementado *)
    function SetupPrimaryKey(pmKey:TConstraintPrimaryKey):Integer;              (* implementado *)
    function SetupForeignKey(fhKey:TConstraintForeignKey):Integer;              (* implementado *)
    function SetupUniqueKey(unKey:TConstraintUniqueKey):Integer;                (* implementado *)
    function SetupDynamicType(DynType:TDynamicType):Integer;                    (* implementado *)

    function getFullPathIniFileConfig:String;
    procedure ConvertDataType(var dtReflection :TDataReflection);               (* implementado *)

    function ValidateNativeTypeByName(sNameType:String):TNativeType;            (* implementado *)
    function OwnTypeExists(OwnTypeName:String):Boolean;                         (* implementado *)
    function TableExists(TableName:String):Boolean;                             (* implementado *)
    function FieldInTableExists(TableName:String;FieldName:String):boolean;     (* implementado *)
    function IndexExists(indexName:String):boolean;                             (* implementado *)
    function ConstraintExists(ConstraintName:String):boolean;                   (* implementado *)

    (* rotinas para cria os objetos no banco de dados por script sql  *)
    procedure GenerateScriptOwnTypes;                                           (* implementado *)
    procedure GenerateScriptTables;                                             (* implementado *)
    procedure GenerateScriptIndexs;                                             (* implementado *)
    procedure GenerateScriptConstraintsPrimaryKey;                              (* implementado *)
    procedure GenerateScriptConstraintsForeignKey;                              (* implementado *)
    procedure GenerateScriptConstraintsUniqueKey;                               (* implementado *)
    procedure GenerateScriptGeneratorsFirebirdOnly;                             (* implementado *)

    procedure setParam(pName:String;pValue:String);                             (* implementado *)
    procedure setParamFromIni(pSessionName:String;pName:String;pValue:String);                             (* implementado *)

    function  getParam(pName:String;pDefaultValue:String=''):String;            (* implementado *)
    function  getParamFromIni(pSessionName:String;pName:String;pDefaultValue:String=''):String;            (* implementado *)
    procedure CreateDatabase;

    (*--- geração automática de código a partir do banco de dados ---*)
    procedure GeneratePropertiesDPSUnit(sEntity: string; var slContentUnit:TStringList;PatGetSet:TPatternGettersAndSetters=tpatDelphiShort);
    procedure GenerateImplementDPSUnit(sEntity: string; var slContentUnit:TStringList;PatGetSet:TPatternGettersAndSetters=tpatDelphiShort);
    function  getTableKeyFieldFromDatabase(sTable:String):String;               (* implementado *)
    procedure GeneratePropertiesMasterDataManager(strClassList:TStringList; var strListContainer:TStringList;PatGetSet:TPatternGettersAndSetters=tpatDelphiShort);
    procedure GenerateImplementsMasterDataManager(strClassList:TStringList; var strListContainer:TStringList;PatGetSet:TPatternGettersAndSetters=tpatDelphiShort);
    procedure GenerateNewDelphiTypesFromDatabase(var strListContainer:TStringList);

    function  GenerateMultiplesModelsUnit(sUnitsPath:string;TableList:TStringList;PatternGetSet:TPatternGettersAndSetters=tpatDelphiShort):TStringList;
    function  GenerateSingleModelsUnit(sUnitPath:string;TableList:TStringList;PatternGetSet:TPatternGettersAndSetters=tpatDelphiShort):String;

    procedure getReflectionsFromDatabase(var vReflections:TReflection; table:string ='');
    procedure getIndexesFromDatabase(table:string;var rsIndexes:TIndexes);
    procedure getPrimaryKeysFromDatabase(table:string;var rsPrimaryKeys:TConstraintPrimaryKeys);
    procedure getForeignKeysFromDatabase(table:string;var rsForeignKeys:TConstraintForeignKeys);
    procedure getUniqueKeysFromDatabase(table:string;var rsUniqueKeys:TConstraintUniqueKeys);
    procedure generateSetupIndexesFromDatabase(sTableName:String; var strContainer:TStringList);
    procedure generateSetupPrimaryKeysFromDatabase(sTableName: String; var strContainer:TStringList);
    procedure generateSetupForeignKeysFromDatabase(sTableName: String; var strContainer:TStringList);
    procedure generateSetupUniqueKeysFromDatabase(sTableName: String; var strContainer:TStringList);
    procedure generateSetupCheckKeysFromDatabase(sTableName: String; var strContainer:TStringList);
    (*------------------------------------------------------------------------------*)

    property IniFileConfig:String read getIniFileConfig write setIniFileConfig;
    property ALIAS :string read getALIAS write setALIAS;
    property MdIndexes:TIndexes read getmdIndexes write setmdIndexes;
    property MdPrimaryKeys:TConstraintPrimaryKeys read getmdPrimaryKeys write setmdPrimaryKeys;
    property MdForeignKeys:TConstraintForeignKeys read getmdForeignKeys write setmdForeignKeys;
    property MdUniqueKeys:TConstraintUniqueKeys read getmdUniqueKeys write setmdUniqueKeys;

    property ReflectionType:TTypeReflection read FReflectionType write FReflectionType default trDelphiToDatabase;
    property VersionCoreDB:Int64 read getVersionCoreDB default 1;
    property VersionDatabase:Int64 read getVersionDatabase write setVersionDatabase default 0;
    property DialectCoreDB:Int64 read getDialectCoreDB write setDialectCoreDB default 3;
    property TypeDatabase: TTypeOfDatabase read FTypeDatabase write FTypeDatabase default tdbFirebird;

    property DmDynamicTypes:TDynamicTypes read FDmDynamicTypes write FDmDynamicTypes;
    property DmReflections:TReflection read FDmReflections write FDmReflections;
    property TableReflections:TTableReflections read FTableReflections write FTableReflections;
    property Logs:TStringList read FLogs;
    property KeyFieldAutoGenerated:Boolean read getKeyFieldAutoGenerated write setKeyFieldAutoGenerated;

 end;

 IDataManagerClass = class of TAbstractDataManager;

 IDataModel = Interface ['{84E1298E-2498-4038-B608-A4C785393D23}']
    function getTypeDatabase:TTypeOfDatabase;
    function getClassModelName:String;
    function getTableName:String;
    function getModelState :TModelState;
    function getDataManager:IDataManager;
    function getDataManagerClass:IDataManagerClass;
    function getKeyFieldName:String;
    function getKeyFieldAutoGenerated:Boolean;
    function getCountErrors:Int64;
    function getCountWarnings:Int64;
    function getCountHints:Int64;
    function getModelReflection:TReflection;
    function getModelDynamicTypes:TDynamicTypes;
    function getIndexes :TIndexes;
    function getPrimaryKeys : TConstraintPrimaryKeys;
    function getForeignKeys : TConstraintForeignKeys;
    function getUniqueKeys  : TConstraintUniqueKeys;
    function getTokenizer:String;
    function Token:String;

    function SetupIndex(IdxName:string;tabName:String;arFields:array of String;bUnique:Boolean = False;DescendentOrd:Boolean = false):Integer;
    function SetupPrimaryKey(pkName:string;tabName:String;FieldKey:String;listCheckList:array of String):Integer;
    function SetupForeignKey(fkName:string;tblName:string;fkTabName:string;rlUpdate,rlDelete:TTpRuleConstraint;
                             listOnFields:array of String; listTargetFields:array of String):Integer;
    function SetupUniqueKey(ukName:string;ukTabName:String;listOnFields:array of String):Integer;
    function SetupReflection(dataTypeName:String;typeKind:TTypeKind;frdValues:array of String;size:Int64=0;
                             precision:Int64=0;defaultValue:string='';ntNativeType:TNativeType=ntUnknow;
                             alowNull:Boolean= True):Integer;
    function SetupDynamicType(TypeInfo:PTypeInfo;friendlyValues:array of String):Integer;
    function GenerateNewID(inc: Int64):Int64;

    procedure setDatamanagerClass(const Value:IDataManagerClass);
    procedure setClassModelname(const Value:String);
    procedure setTableName(const Value:String);
    procedure setModelState(const Value:TModelState);
    procedure setKeyFieldName(const Value:string);
    procedure setKeyFieldAutoGenerated(const Value:Boolean);
    procedure fillProperties(qrOrigin:TDataSet);
    procedure fillDataset(qrDestination:TDataSet);
    procedure configureExternalDataset(extDataSet:TClientDataSet);
    procedure SetupModelReflection;
    procedure setTokenizer(const Value:string);

    property DataManager:IDataManager read getDataManager;
    property ClassModelName:String read getClassModelName write setClassModelName;
    property TableName:String read getTableName write setTableName;
    property ModelState:TModelState read getModelState write setModelState;
    property KeyFieldName:String read getKeyFieldName write setKeyFieldName;
    property KeyFieldAutoGenerated:Boolean read getKeyFieldAutoGenerated write setKeyFieldAutoGenerated;
    property CountErrors :Int64 read getCountErrors;
    property CountWarnings :Int64 read getCountWarnings;
    property CountHints :Int64 read getCountHints;

    property ModelReflection: TReflection read getModelReflection;
    property ModelDynamicTypes: TDynamicTypes read getModelDynamicTypes;
    property Indexes: TIndexes read getIndexes;
    property PrimaryKeys: TConstraintPrimaryKeys read getPrimaryKeys;
    property ForeignKeys: TConstraintForeignKeys read getForeignKeys;
    property FUniqueKeys: TConstraintUniqueKeys read getUniqueKeys;
    property Tokenizer:String read getTokenizer write setTokenizer;
 end;

 ICRUDDataModel = Interface(IDataModel)['{B01792F6-C052-4A3E-8D30-5C30109C59DA}']

   (*create*)
   function save:Boolean;
   (*read*)
   function get(ident:String = '';externalDataSet:TClientDataSet = nil):IDataModel;
   function getWhere(sWhere, sOrder: String;externalDataSet:TClientDataSet = nil):IDataModel;
   function getList(sWhere:String = '';sOrder:String = '';externalDataSet:TClientDataSet = nil):TObjectList;
   (*delete*)
   function delete:Boolean;
 end;

  TDPSAbstractModel = class(TInterfacedObject,IDataModel,ICRUDDataModel)
  private
    FDatamanager:IDataManager;
    FDatamanagerClass:IDataManagerClass;
    FTypeDatabase:TTypeOfDatabase;
    FModelState:TModelState;
    FTableName:string;
    FClassModelName:String;
    FKeyFieldName:String;
    FModelDynamicTypes: TDynamicTypes;
    FModelReflection :TReflection;          (* reflection do modelo - tabela *)
    FIndexes    :TIndexes;
    FPrimaryKeys:TConstraintPrimaryKeys;
    FForeignKeys:TConstraintForeignKeys;
    FUniqueKeys :TConstraintUniqueKeys;
    FKeyFieldAutoGenerated:Boolean;
    FTokenizer:String;

    function getDataManager:IDataManager;
    function getDataManagerClass:IDataManagerClass;
    function getTypeDatabase:TTypeOfDatabase;
    function getClassModelName:String;
    function getTableName:String;
    function getModelState :TModelState;
    function getKeyFieldName:String;
    function getCountErrors:Int64;
    function getCountWarnings:Int64;
    function getCountHints:Int64;
    function getModelReflection:TReflection;
    function getModelDynamicTypes:TDynamicTypes;
    function getIndexes :TIndexes;
    function getPrimaryKeys : TConstraintPrimaryKeys;
    function getForeignKeys : TConstraintForeignKeys;
    function getUniqueKeys  : TConstraintUniqueKeys;
    function getKeyFieldAutoGenerated:Boolean;
    function getTokenizer:String;

    procedure setDatamanagerClass(const Value:IDataManagerClass);
    procedure setClassModelname(const Value:String);
    procedure setTableName(const Value:String);
    procedure setModelState(const Value:TModelState);
    procedure setKeyFieldName(const Value:string);
    procedure setKeyFieldAutoGenerated(const Value:Boolean);
    procedure setTokenizer(const Value:string);
  public

    constructor Create(dmgr:IDataManager);virtual;
    class function New(dmgr:IDataManager;qrDataset:TZQuery):TDPSAbstractModel;

    procedure fillProperties(qrOrigin:TDataSet);
    procedure fillDataset(qrDestination:TDataSet);
    procedure configureExternalDataset(extDataSet:TClientDataSet);

    function SetupIndex(IdxName:string;tabName:String;arFields:array of String;bUnique:Boolean = False;DescendentOrd:Boolean = false):Integer;
    function SetupPrimaryKey(pkName:string;tabName:String;FieldKey:String;listCheckList:array of String):Integer;
    function SetupForeignKey(fkName:string;tblName:string;fkTabName:string;rlUpdate,rlDelete:TTpRuleConstraint;
                             listOnFields:array of String; listTargetFields:array of String):Integer;
    function SetupUniqueKey(ukName:string;ukTabName:String;listOnFields:array of String):Integer;
    function SetupReflection(dataTypeName:String;typeKind:TTypeKind;frdValues:array of String;size:Int64=0;
                             precision:Int64=0;defaultValue:string='';ntNativeType:TNativeType=ntUnknow;
                             alowNull:Boolean= True):Integer;
    function SetupDynamicType(TypeInfo:PTypeInfo;friendlyValues:array of String):Integer;
    procedure SetupModelReflection;
    property Datamanager:IDataManager read getDataManager;
    property DataManagerClass:IDataManagerClass read getDataManagerClass write setDataManagerClass;
    property CountErrors:Int64 read getCountErrors;
    property CountWarnings:Int64 read getCountWarnings;
    property CountHints:Int64 read getCountHints;
    property TypeDatabase :TTypeOfDatabase read getTypeDatabase;
    property ClassModelName:String read getClassModelName write setClassModelName;
    property TableName:String read getTableName write setTableName;
    property ModelState:TModelState read getModelState write setModelState;
    property KeyFieldName:String read getKeyFieldName write setKeyFieldName;
    property KeyFieldAutoGenerated :Boolean read getKeyFieldAutoGenerated write setKeyFieldAutoGenerated default False ;
    property Tokenizer:String read getTokenizer write setTokenizer;

    property ModelReflection: TReflection read getModelReflection;
    property ModelDynamicTypes: TDynamicTypes read getModelDynamicTypes;
    property Indexes: TIndexes read getIndexes;
    property PrimaryKeys: TConstraintPrimaryKeys read getPrimaryKeys;
    property ForeignKeys: TConstraintForeignKeys read getForeignKeys;
    property UniqueKeys: TConstraintUniqueKeys read getUniqueKeys;

   (* Interfaces *)
    function GenerateNewID(inc: Int64=1):Int64;
    procedure UpdateLastID;
    function Token:String;

   (*create*)
   function save:Boolean;
   function saveList(AListDataModel:TObjectList):Int64;

   (*read*)
   function get(ident:String = '';externalDataSet:TClientDataSet = nil):IDataModel;virtual;
   function getWhere(sWhere:String = '';sOrder:String = '';externalDataSet:TClientDataSet = nil):IDataModel;virtual;
   function getList(sWhere:String = '';sOrder:String = '';externalDataSet:TClientDataSet = nil):TObjectList;

   (*delete*)
   function delete:Boolean;
  end;

  TDPSStandardModel = class(TDPSAbstractModel)
  private
    FId   :Int64;
    FGuid :STR_GUID;
  public
    constructor Create(dmgr:IDataManager);override;
  published
    property Id:Int64 read FId write FId default -1;
    property Guid : STR_GUID read FGuid write FGuid;
  end;

  const
    file_dps_log_monitor = 'dps_monitor.log';

    (*  parâmetros lidos do arquivo .ini   *)
    dpsZEOSDRIVER      = 'ZEOSDRIVER';
    dpsHOST            = 'HOST';
    dpsPORTA           = 'PORTA';
    dpsPATH            = 'PATH';
    dpsUSUARIO         = 'USUARIO';
    dpsSENHA           = 'SENHA';
    dpsEMBARCADO       = 'EMBARCADO';
    dpsLOG             = 'LOG';
    dpsVERSAODB        = 'VERSAODB';

resourcestring
  (* datamanager *)
  SDatabaseALIASNotBeConfigured           = 'Datamanager não pode ser configurado, Alias não definido na classe datamanager.';
  SDatamanagerTempQueryError              = 'A consulta não pode ser concluída.';
  SKeyFieldIsNotDefinedInModel            = 'A Propriedade KeyField não foi definida na classe modelo.';
  SNewIDError                             = 'Erro ao gerar um novo id para o modelo.';
  SFillPropertiesErrorInProperty          = 'Erro ao preencher a propriedade: [%s] com o valor: [%s]';
  SFillPropertiesErrorInGeneral           = 'Erro ao preencher as propriedades do modelo : [%s]';
  SFillPropertiesOK                       = 'Propriedades do modelo [%s] preenchidas com sucesso!';
  SFillDatasetErrorInField                = 'Erro ao transferir os dados para o campo: %s com o valor: [%s]';
  SFillDatasetErrorInGeneral              = 'Erro ao transferir os dados para o modelo [%s]';
  SFillDatasetOK                          = 'Dados do modelo [%s] transferidos com sucesso para o dataset!';
  SErrorOnConfigureExternalDataset        = 'Erro ao configurar o dataset externo para o modelo : [%s]';
  SOnConfigureExternalDatasetOK           = 'Dataset configurado com sucesso para o modelo : [%s]';
  SListResultErrorOrNill                  = 'Retorno da Lista de modelos está resultando em Erro ou Nil.';
  SErrorOnValidateRules                   = 'O Registro não pode ser salvo devido a violações das regras de negócio.';
  SErrorOnSaveModel                       = 'Erro ao salvar o registro [%s].';
  SErrorOnSetPropertiesToDatasetFields    = 'Erro ao preencher a propriedade: [%s] com o valor: [%s]';
  SModelDeleteError                       = 'Erro ao tentar deletar a instância de um modelo';
  SModelCanotDeleteBecauseIsEmpty         = 'O Registro [%s] não pode ser excluído, pois não existe no banco de dados.';
  SWarningSaveRecordSuccess               = 'O Registro [%s] foi salvo com sucesso!';
  SWarningDeleteRecordSuccess             = 'O Registro [%s] foi excluído com sucesso!';
  SEDatabasePathNotSpecified              = 'O Banco de dados não pode ser criado,local do banco não foi especificado.';
  SWarningRecordsInResultsetList          = 'Total de Registro : [%d]';



  modelsUses                = 'Windows,Messages,SysUtils,Variants,Classes,DB,Graphics,DPsDatamanager,DPsTypes,Contnrs;';
  msg_type_db_no_defined    = 'Tipo %s do campo %s da tabela %s não tem um tipo correspondente para o banco de dados.';
  msg_desc_conection_fail   = 'Falha de conexão, alias : %s';




const

  (* códigos internos de regra de negócio para cadastro *)
  codSDatabaseALIASNotBeConfigured        = '000001';
  codSDatamanagerTempQueryError           = '000002';
  codSKeyFieldIsNotDefinedInModel         = '000003';
  codSNewIDError                          = '000004';
  codSFillPropertiesErrorInProperty       = '000005';
  codSFillPropertiesErrorInGeneral        = '000006';
  codSFillPropertiesOK                    = '000007';
  codSFillDatasetErrorInField             = '000008';
  codSFillDatasetErrorInGeneral           = '000009';
  codSFillDatasetOK                       = '000010';
  codSErrorOnConfigureExternalDataset     = '000011';
  codSOnConfigureExternalDatasetOK        = '000012';
  codSListResultErrorOrNill               = '000013';
  codSErrorOnValidateRules                = '000014';
  codSErrorOnSaveModel                    = '000015';
  codSErrorOnSetPropertiesToDatasetFields = '000016';
  codSModelDeleteError                    = '000017';
  codSModelCanotDeleteBecauseIsEmpty      = '000018';
  codSWarningSaveRecordSuccess            = '000019';
  codSWarningDeleteRecordSuccess          = '000020';
  codSEDatabasePathNotSpecified           = '000021';
  codSWarningRecordsInResultsetList       = '000022';

{$M-}
implementation


procedure TAbstractDataManager.setMdForeignKeys(const Value: TConstraintForeignKeys);
begin
  FmdForeignKeys := Value;
end;

procedure TAbstractDataManager.setMdIndexes(const Value: TIndexes);
begin
  FmdIndexes := Value;
end;

procedure TAbstractDataManager.setMdPrimaryKeys( const Value: TConstraintPrimaryKeys);
begin
  FmdPrimaryKeys := Value;
end;

procedure TAbstractDataManager.setMdUniqueKeys(const Value: TConstraintUniqueKeys);
begin
  FmdUniqueKeys := Value;
end;

procedure TAbstractDataManager.setParam(pName, pValue: String);
var
  i,x:integer;
begin
  x := -1;
  for i:=0 to Length(FParams)-1 do
    if SameText(getParams[i].ParamName,pName) then
      x := i;

  if (x = -1) then
  begin
    SetLength(FParams,Length(FParams)+1);
    x:= Length(FParams)-1;
  end;

  FParams[x].ParamName  := pName;
  FParams[x].ParamValue := pValue;
end;

procedure TAbstractDataManager.setParamFromIni(pSessionName:String;pName, pValue: String);
begin
  with TIniFile.Create(getFullPathIniFileConfig) do
    begin
      try
        setParam(pName,pValue);
        WriteString(pSessionName,pName,pValue);
      finally
        Free;
      end;
    end;
end;

procedure TAbstractDataManager.setReflectionType( const Value: TTypeReflection);
begin
  FReflectionType := Value;
end;

procedure TAbstractDataManager.setTableReflections(  const Value: TTableReflections);
begin
  FTableReflections := Value;
end;

procedure TAbstractDataManager.setTypeDatabase(  const Value: TTypeOfDatabase);
begin
  FTypeDatabase := Value;
end;

procedure TAbstractDataManager.setTypeNode(const Value: TTypeNode);
begin
  FTypeNode := Value;
end;

function TAbstractDataManager.getParam(pName:String; pDefaultValue:String=''):String;
var
  i:integer;
begin
  Result := pDefaultValue;
  for i:=0 to Length(FParams)-1 do
    if SameText(FParams[i].ParamName,pName) then
       Result  := FParams[i].ParamValue;
end;


function TAbstractDataManager.getParamFromIni(pSessionName:String;pName, pDefaultValue: String): String;
begin
  Result :='';
  with TIniFile.Create(getFullPathIniFileConfig) do
    begin
      try
        setParam(pName, ReadString(pSessionName,pName,pDefaultValue) );
        Result := getParam(pName,pDefaultValue);
      finally
        free;
      end;
    end;
end;

function TAbstractDataManager.getParams: TParamsControler;
begin
  Result := FParams;
end;

{ TAbstractDataManager }
procedure TAbstractDataManager.LoadDBParamsFromIni;
begin
  FVersionDatabase := StrToInt64Def(getParamfromIni(ALIAS,dpsVERSAODB),0);
  FMonitor.Active  := StrToBoolDef(getParamFromIni(ALIAS,dpsLOG),false);
  FLocalServer     :=   (SameText(getParamFromIni(ALIAS,dpsHOST),'127.0.0.1'))
                     or (SameText(getParamFromIni(ALIAS,dpsHOST),'localhost'))
                     or (SameText(getParamFromIni(ALIAS,dpsHOST),'0'))
                     or (SameText(getParamFromIni(ALIAS,dpsHOST),''));

  FConnectionString := '';
  FConnectionString := format('zdbc:%s://'    ,[getParamfromIni(ALIAS,dpsZEOSDRIVER)]);
  FConnectionString := format('%s%s'          ,[FConnectionString,getParamfromIni(ALIAS,dpsHOST)]);
  FConnectionString := format('%s:%s/'        ,[FConnectionString,getParamfromIni(ALIAS,dpsPORTA)]);
  FConnectionString := format('%s%s'          ,[FConnectionString,getParamfromIni(ALIAS,dpsPATH)]);
  FConnectionString := format('%s?username=%s',[FConnectionString,getParamfromIni(ALIAS,dpsUSUARIO)]);
  FConnectionString := format('%s;password=%s',[FConnectionString,getParamfromIni(ALIAS,dpsSENHA)]);
end;


(*   Grava no arquivo de configuração os dados para conexão *)
procedure TAbstractDataManager.SetupConnection(connectionName,driver,host,user,password,path:string;
                                               port:integer=0;embedded:boolean=false;createDB:Boolean=false;
                                               regLog:Boolean=false);
begin
  FALIAS           := alias;
  FIniFileConfig   := IniFileConfig;
  setParamFromIni(connectionName,dpsZEOSDRIVER ,driver);
  setParamFromIni(connectionName,dpsHOST       ,host);
  setParamFromIni(connectionName,dpsPORTA      ,IntToStr(port));
  setParamFromIni(connectionName,dpsPATH       ,path);
  setParamFromIni(connectionName,dpsUSUARIO    ,user);
  setParamFromIni(connectionName,dpsSENHA      ,password);
  setParamFromIni(connectionName,dpsEMBARCADO  ,BoolToStr(embedded,True));
  setParamFromIni(connectionName,dpsLOG        ,BoolToStr(regLog,True));

end;

(*
    os elementos sinalizados abaixo são zerados na importação do banco
    por este motivo NUNCA use uma instância com objetivos diferentes.
*)
constructor TAbstractDataManager.Create;
begin
  FMonitor         := TZSQLMonitor.Create(nil);
  FLogs            := TStringList.Create;
  FVersionCoreDB   := 0;
  FNewVersionDB    := 0;
  FVersionDatabase := 0;
  FDialectCoreDB   := 0;

  SetLength(FBusinessRules,0);
  SetLength(FParams,0);
  SetLength(FDmDynamicTypes,0);
  SetLength(FDmReflections,0);          (* * *)
  SetLength(FTableReflections,0);       (* * *)
  SetLength(FmdIndexes,0);              (* * *)
  SetLength(FmdPrimaryKeys,0);          (* * *)
  SetLength(FmdForeignKeys,0);          (* * *)
  SetLength(FmdUniqueKeys,0);           (* * *)
  LoadDBParamsFromIni;
  Setup;
end;

function TAbstractDataManager.getConnection:IZConnection;
begin
  Result       := DriverManager.GetConnection(getConnectionString);
  if Result <> nil then
    Result.Open;
end;

function TAbstractDataManager.getConnectionString: String;
begin
  Result := FConnectionString;
end;

function TAbstractDataManager.getCountErrors: Int64;
begin
  Result := FCountErrors;
end;

function TAbstractDataManager.getCountHints: Int64;
begin
  Result := FCountHints;
end;

function TAbstractDataManager.getCountLogs: Int64;
begin
  Result := FLogs.Count;
end;

function TAbstractDataManager.getCountWarnings: Int64;
begin
  Result := FCountWarnings;
end;

function TAbstractDataManager.getDialectCoreDB: Int64;
begin
  Result := FDialectCoreDB;
end;

function TAbstractDataManager.getDmDynamicTypes: TDynamicTypes;
begin
  Result := FDmDynamicTypes;
end;

function TAbstractDataManager.getDmReflections: TReflection;
begin
  Result := FDmReflections;
end;

procedure TAbstractDataManager.generateSetupIndexesFromDatabase(sTableName: String; var strContainer:TStringList);
var
  i,j:integer;
  listIndex:TIndexes;
  resultMethod:string;
begin
  resultMethod := '';
  getIndexesFromDatabase(sTableName,listIndex);

  (* gerando o código da unit para registro do índice *)
  for i:=0 to length(ListIndex)-1 do
  begin
    resultMethod := format('  SetupIndex(%s',[QuotedStr(ListIndex[i].IndexName)]);
    resultMethod := format('%s,%s,[',[resultMethod, QuotedStr(ListIndex[i].TableName)]);

    for j:=0 to length(ListIndex[i].Fields)-1 do
    begin
      if j < length(ListIndex[i].Fields)-1 then
        resultMethod := format('%s%s,',[resultMethod,QuotedStr(ListIndex[i].Fields[j])])
      else
        resultMethod := format('%s%s]',[resultMethod,QuotedStr(ListIndex[i].Fields[j])]);
    end;

    if ListIndex[i].Unique then
      resultMethod := format('%s,%s',[resultMethod,'True']);

    if ListIndex[i].DescOrd then
      resultMethod := format('%s,%s',[resultMethod,'True']);

    resultMethod := format('%s);',[resultMethod]);

    strContainer.Add(resultMethod);
  end;
end;

procedure TAbstractDataManager.generateSetupPrimaryKeysFromDatabase(sTableName: String; var strContainer:TStringList);
var
  i:integer;
  pmKeys:TConstraintPrimaryKeys;
  resultMethod :string;
begin
  resultMethod     := '';
  getPrimaryKeysFromDatabase(sTableName,pmKeys);
  for i :=0 to length(pmKeys)-1 do
  begin
    resultMethod := format('  SetupPrimaryKey(%s',[QuotedStr(pmKeys[i].PrimaryKeyName)]);
    resultMethod := format('%s,%s',[resultMethod,QuotedStr(pmKeys[i].PrimaryKeyTable)]);
    resultMethod := format('%s,%s,[]);',[resultMethod,QuotedStr(pmKeys[i].PrimaryKeyField)]);
    strContainer.Add(resultMethod);
  end;
end;

procedure TAbstractDataManager.generateSetupForeignKeysFromDatabase(sTableName: String; var strContainer:TStringList);
var
  i,j:integer;
  fkKeys : TConstraintForeignKeys;
  resultMethod :string;
begin
  resultMethod    := '';
  getForeignKeysFromDatabase(sTableName,fkKeys);
  for i := 0 to length(fkKeys)-1 do
  begin
    resultMethod := format('  SetupForeignKey(%s',[QuotedStr(fkKeys[i].ForeignKeyName)]);
    resultMethod := format('%s,%s',[resultMethod,QuotedStr(fkkeys[i].ForeignKeyTable)]);
    resultMethod := format('%s,%s',[resultMethod,QuotedStr(fkkeys[i].ForeignKeyTargetTable)]);

    (* regra para update *)
    case fkkeys[i].RuleOnUpdate of
      trcCascade    : resultMethod := format('%s,%s',[resultMethod,'trcCascade']);
      trcNone       : resultMethod := format('%s,%s',[resultMethod,'trcNone']);
      trcSetNull    : resultMethod := format('%s,%s',[resultMethod,'trcSetNull']);
      trcSetDefault : resultMethod := format('%s,%s',[resultMethod,'trcSetDefault']);
    else
      resultMethod  := format('%s,%s',[resultMethod,'trcNone']);
    end;

    (* regra para delete *)
    case fkkeys[i].RuleOnDelete of
      trcCascade    : resultMethod := format('%s,%s',[resultMethod,'trcCascade']);
      trcNone       : resultMethod := format('%s,%s',[resultMethod,'trcNone']);
      trcSetNull    : resultMethod := format('%s,%s',[resultMethod,'trcSetNull']);
      trcSetDefault : resultMethod := format('%s,%s',[resultMethod,'trcSetDefault']);
    else
      resultMethod  := format('%s,%s',[resultMethod,'trcNone']);
    end;

    resultMethod := format('%s,[',[resultMethod]);

    (* onFields = Campos na tabela local *)
    for j:=0 to length(fkkeys[i].LocalFields)-1 do
      if j < length(fkkeys[i].LocalFields)-1 then
        resultMethod := format('%s%s,',[resultMethod,QuotedStr(fkkeys[i].LocalFields[j])])
      else
        resultMethod := format('%s%s]',[resultMethod,QuotedStr(fkkeys[i].LocalFields[j])]);

    resultMethod := format('%s,[',[resultMethod]);

    (* targetFields = Campos na tabela estrangeira *)
    for j:=0 to length(fkkeys[i].TargetFields)-1 do
      if j < length(fkkeys[i].TargetFields)-1 then
        resultMethod := format('%s%s,',[resultMethod,QuotedStr(fkkeys[i].TargetFields[j])])
      else
        resultMethod := format('%s%s]',[resultMethod,QuotedStr(fkkeys[i].TargetFields[j])]);

    resultMethod := format('%s);',[resultMethod]);
    strContainer.Add(resultMethod);
  end;
end;

(*
   Zeos Lib 6.6.6 NÃO tem uma classe de retorno em getMetadataObjects()
   para checks e unique constraints, por enquanto a assinatura será mantida
   mas os sem implementação.

   No futuro ou implementamos uma rotina específica para cada banco suportado
   ou verificamos se uma versão mais recente da ZeosLib já suporta o recurso.

   Lembrando que isto é apenas para importação da classe a partir do banco de dados
   se o programador acrescentar checks ou uniqueConstraints estes serão gerados
   no banco de dados normalmente

*)
procedure TAbstractDataManager.generateSetupUniqueKeysFromDatabase( sTableName: String; var strContainer:TStringList);
begin
(*
    function SetupUniqueKey(ukName:string;ukTabName:String;IdxName:string;listOnFields:array of String):Integer;
*)
end;

procedure TAbstractDataManager.generateSetupCheckKeysFromDatabase( sTableName: String; var strContainer:TStringList);
begin
  (* comentário acima *)
end;

(*
   nesta rotina abaixo é importante ter a variável relflection, pois assim
   podemos usar a mesma rotina para preencher os reflections e para
   preencher o table reflection.
*)
procedure TAbstractDataManager.getReflectionsFromDatabase(var vReflections:TReflection;table:string ='');
var
  mdcolunas:IZDatabaseMetadata;
  rset_colunas:IZResultSet;
  i,x : integer;
begin
  ReflectionType := trDatabaseToDelphi;
  mdcolunas := getconnection.GetMetadata;
  if trim(table) = '' then
    rset_colunas := mdcolunas.GetColumns('','','','')
  else
    rset_colunas := mdcolunas.GetColumns('','',(table),'');

  while rset_colunas.Next do
    if not AnsiStartsStr('RDB$',rset_colunas.GetStringByName('TABLE_NAME'))
    and SameText(table,rset_colunas.GetStringByName('TABLE_NAME')) then
    begin
      x := -1;
      for i:=0 to length(vReflections)-1 do
        if SameText(vReflections[i].DataTypeName,rset_colunas.GetStringByName('TYPE_NAME'))then
          x := i;
      (* tipos pré-existentes não são alterados *)
      if x = -1 then
      begin
        x := length(vReflections);
        SetLength(vReflections,1+length(vReflections));
        (*---- só importa se for inédito *)
        vReflections[x].DataTypeName            := rset_colunas.GetStringByName('TYPE_NAME');
        vReflections[x].ClassOrTableName        := rset_colunas.GetStringByName('TABLE_NAME');
        //vReflections[x].OriginalDataTypeName    := rset_colunas.GetStringByName('TYPE_NAME');
        vReflections[x].PropertyOrColumnName    := rset_colunas.GetStringByName('COLUMN_NAME');
        //        PropertyOrColumnDescript: String;
        //        OriginalDataTypeName    : String;       // é assinalado pela rotina de conversão
        //        FullNameDatabaseType    : String;       // é assinalado pela rotina de conversão
        //        FullNameDelphiType      : String;       // é assinalado pela rotina de conversão
        vReflections[x].DataSize                  := rset_colunas.GetIntByName('COLUMN_SIZE');
        vReflections[x].DefaultValue              := rset_colunas.GetStringByName('COLUMN_DEF');
        //        DataSizeScale           : Int64;
        //        NativeType              : TNativeType;  // é assinalado pela rotina de conversão
        //        BasicTypeKind           : TTypeKind;    // é assinalado pela rotina de conversão
        //        DatabaseCheck           : array of string; // implementacao na importacao será feita no futuro
        //        FriendlyValues          : array of string;// é para uso em runtime
        //        IndexDynamicType        : Integer;
        vReflections[x].AcceptsNull             := (rset_colunas.GetIntByName('NULLABLE') = 1);
        //        PrimaryKey              : Boolean;       //metadata zeos não traz informação
        //        AutoInc                 : Boolean;       // implementar no futuro, implementacao padrao Firebird não tem este recurso
        vReflections[x].DBPosition          := rset_colunas.GetIntByName('ORDINAL_POSITION');
        vReflections[x].TypeReflection      := ReflectionType;
        //vReflections[x].NativeType          := ntUnknow;
        if vReflections[x].NativeType = ntUnknow then
          vReflections[x].NativeType   := ValidateNativeTypeByName(vReflections[x].DataTypeName);
        vReflections[x].BasicTypeKind  := DatabaseTypeNameToDelphiTypeKind(vReflections[x].DataTypeName,FTypeDatabase,FVersionCoreDB,FDialectCoreDB);
      end;

     SetupReflection(vReflections[x]);
     ConvertDataType(vReflections[x]);
   end;
end;


function TAbstractDataManager.getReflectionType: TTypeReflection;
begin
  Result := FReflectionType;
end;

procedure TAbstractDataManager.GenerateNewDelphiTypesFromDatabase(var strListContainer:TStringList);
var
  typeDef:String;
  i:Integer;
begin
   getReflectionsFromDatabase(FDmReflections);
   ReflectionType := trDatabaseToDelphi;
   for i:=0 to Length(DmReflections)-1 do
   begin
     ConvertDataType(DmReflections[i]);
     case DmReflections[i].NativeType of
       ntUnknow:
       begin
         typeDef := format('%s = %s;',[DmReflections[i].DataTypeName
                                     , DmReflections[i].FullNameDelphiType]);
         if strListContainer.IndexOf(typeDef) = -1 then
           strListContainer.Add(typeDef);
       end;

       ntDatabase:
       begin
         (* se o dataTypeName for igual a um tipo existente no delphi, não cria o tipo *)
         if ValidateNativeTypeByName(DmReflections[i].DataTypeName) in [ntUnknow,ntDatabase] then
         begin
           (* delphi não aceita espaços no nome como "Double Precision" do firebird *)
           typeDef := format('%s = %s;',[ReplaceStr( DmReflections[i].OriginalDataTypeName,' ','')
                                       , DmReflections[i].FullNameDelphiType]);
           if strListContainer.IndexOf(typeDef) = -1 then
             strListContainer.Add(typeDef);
         end;
       end;
     end;
   end;
end;

(* Gera código de implementação da Unit *)
procedure TAbstractDataManager.GenerateImplementDPSUnit(sEntity: string; var slContentUnit:TStringList;PatGetSet:TPatternGettersAndSetters=tpatDelphiShort);
var
  i:Integer;
  colList : TReflection;
  function dtypeName(var ref : TDataReflection):String;
  begin
    Result := ref.FullNameDelphiType;
    if ref.NativeType in [ntDatabase] then
    begin
        if ValidateNativeTypeByName(ref.DataTypeName) in [ntUnknow,ntDatabase]
          then Result := ReplaceStr(ref.OriginalDataTypeName,' ','');
    end
      else Result := colList[i].FullNameDelphiType;
  end;
begin
  getReflectionsFromDatabase(colList,sEntity);

  case PatGetSet of
    tpatDelphiShort:;//sem implementação, acesso direto a variável privada Read F...Write F...
    tpatDelphi:
    begin
      slContentUnit.Add(Format('{ %s }',[colList[0].ClassOrTableName]));
      for i:=0 to length(colList)-1 do
      begin
        slContentUnit.Add(Format('function  %s.Get%s(): %s;',[colList[i].ClassOrTableName,
                                                              colList[i].PropertyOrColumnName,
                                                              dtypeName(colList[i])]));
        slContentUnit.Add('begin');
        slContentUnit.Add(Format('  Result := F%s;',[colList[i].PropertyOrColumnName]));
        slContentUnit.Add('end;');
      end;
    end;

    tpatJava:
    begin
      slContentUnit.Add(Format('{ %s }',[colList[0].ClassOrTableName]));
      for i:=0 to length(colList)-1 do
      begin
        slContentUnit.Add(Format('function  %s.Get%s(): %s;',[colList[i].ClassOrTableName,
                                                              colList[i].PropertyOrColumnName,
                                                              dtypeName(colList[i])]));
        slContentUnit.Add('begin');
        slContentUnit.Add(Format('  Result := F%s;',[colList[i].PropertyOrColumnName]));
        slContentUnit.Add('end;');
      end;
      for i:=0 to length(colList)-1 do
      begin
        slContentUnit.Add(Format('procedure %s.Set%s(Value:T%s);',[colList[i].ClassOrTableName,
                                                                   colList[i].PropertyOrColumnName,
                                                                   dtypeName(colList[i])]));
        slContentUnit.Add('begin');
        slContentUnit.Add(Format('  F%s := Value;',[colList[i].PropertyOrColumnName]));
        slContentUnit.Add('end;');
      end;
    end;
  end;

  if getTableKeyFieldFromDatabase(sEntity) <> '' then
  begin
    slContentUnit.Add(Format('constructor T%s.Create(dmgr:IDataManager);',[UpperFirstChar(sEntity)]));
    slContentUnit.Add('begin');
    slContentUnit.Add(Format('  KeyFieldName          := %s;',[QuotedStr( getTableKeyFieldFromDatabase(sEntity))]));
    slContentUnit.Add('  inherited;');

    generateSetupPrimaryKeysFromDatabase(sEntity,slContentUnit);
    generateSetupForeignKeysFromDatabase(sEntity,slContentUnit);
    generateSetupUniqueKeysFromDatabase(sEntity,slContentUnit);
    generateSetupCheckKeysFromDatabase(sEntity,slContentUnit);
    generateSetupIndexesFromDatabase(sEntity,slContentUnit);

    slContentUnit.Add('end;');
    slContentUnit.Add('');
  end;
end;

(* Gera propriedades para Unit *)
procedure TAbstractDataManager.GeneratePropertiesDPSUnit(sEntity: string; var slContentUnit:TStringList;PatGetSet:TPatternGettersAndSetters=tpatDelphiShort);
var
  i:Integer;
  colList : TReflection;
  function dtypeName(var ref : TDataReflection):String;
  begin
    Result := ref.FullNameDelphiType;
    if ref.NativeType in [ntDatabase] then
      begin
        if ValidateNativeTypeByName(ref.DataTypeName) in [ntUnknow,ntDatabase]
          then Result := ReplaceStr(ref.OriginalDataTypeName,' ','');
      end
      else Result := colList[i].FullNameDelphiType;
  end;
begin
  getReflectionsFromDatabase(colList,sEntity);
  (* Criando classe herda do Modelo ...*)
  slContentUnit.Add('');
  slContentUnit.Add(Format('  T%s = class(TDPSAbstractModel)',[UpperFirstChar(sEntity)]));
  slContentUnit.Add('  private');
  (* variáveis de instância para armazenar valor da propriedade...  *)
  for i:=0 to length(colList)-1 do
    slContentUnit.Add(Format('    F%s : %s;',[colList[i].PropertyOrColumnName,
                                              dtypeName(colList[i])]));
  case PatGetSet of
    tpatDelphiShort:;// read F.... Write F....
    tpatDelphi:
      for i:=0 to length(colList)-1 do
        slContentUnit.Add(Format('    procedure Set%s(Value : %s);',[colList[i].PropertyOrColumnName,dtypeName(colList[i])]));
    tpatJava:
    begin
      for i:=0 to length(colList)-1 do
        slContentUnit.Add(Format('    function Get%s:T%s;',[colList[i].PropertyOrColumnName,dtypeName(colList[i])]));

      for i:=0 to length(colList)-1 do
        slContentUnit.Add(Format('    procedure Set%s(Value : %s);',[colList[i].PropertyOrColumnName,dtypeName(colList[i])]));
    end;
  end;

  slContentUnit.Add('  public ');
  (* aqui se este modelo tiver um campo chave vamos re-escrever o construtor
     para definir um campo chave.  *)

  if getTableKeyFieldFromDatabase(sEntity) <> '' then
    slContentUnit.Add('  constructor Create(dmgr:IDataManager);');

  slContentUnit.Add('  published');
  (* Declarando as propriedades que serão persistidadas ... *)
  case PatGetSet of
    tpatDelphiShort:
      for i:=0 to length(colList)-1 do
        slContentUnit.Add(Format('    property %s : %s read F%s write F%s;',
                                   [colList[i].PropertyOrColumnName,
                                    dtypeName(colList[i]),
                                    colList[i].PropertyOrColumnName,
                                    colList[i].PropertyOrColumnName]));

    tpatDelphi:
      for i:=0 to length(colList)-1 do
        slContentUnit.Add(Format('    property %s : %s read F%s write Set%s;',
                                   [colList[i].PropertyOrColumnName,
                                    dtypeName(colList[i]),
                                    colList[i].PropertyOrColumnName,
                                    colList[i].PropertyOrColumnName]));
    tpatJava:
      for i:=0 to length(colList)-1 do
        slContentUnit.Add(Format('    property %s : %s read Get%s write Set%s;',
                                   [colList[i].PropertyOrColumnName,
                                    dtypeName(colList[i]),
                                    colList[i].PropertyOrColumnName,
                                    colList[i].PropertyOrColumnName]));

  end;
  slContentUnit.Add('  end;');
  slContentUnit.Add('(*--------------------------------------------------------------------------*)');
end;

function TAbstractDataManager.GenerateMultiplesModelsUnit(sUnitsPath:string; TableList:TStringList;PatternGetSet:TPatternGettersAndSetters=tpatDelphiShort):TStringList;
var
  i,j:Integer;
  unitName,ClassNameEnt:string;
  UnitStr : TStringList;
  TypesStr: TStringList;
begin
  SHOWMESSAGE(' GERANDO UNIT MULTIPLAS');
  Result  := TStringList.Create;
  UnitStr := TStringList.Create;
  TypesStr:= TStringList.Create;

  GenerateNewDelphiTypesFromDatabase(TypesStr);

  try
    for i:= 0 to TableList.Count-1 do
    begin
      unitName      := Format('DPSDBModel%s',[(TableList[i])]);
      ClassNameEnt  := UpperFirstChar(TableList[i]);
      with UnitStr do
      begin
        Clear;
        Add('{******************************************************************************}');
        Add('{          UNIT GERADA AUTOMATICAMENTE                                         }');
        Add('{                                                                              }');
        Add('{               Name:   Delphi Persistence Framework                           }');
        Add('{             Author:   Bianco - conofresilva@gmail.com                        }');
        Add('{            Version:   3.0 - 2011-2013                                        }');
        Add('{            Summary:   Framework de persistência em Delphi                    }');
        Add('{           Comments:   A sugestão é que vc importe uma única vez e passe a    }');
        Add('{                       fazer as alterações ou acréscimos de campos, tabelas   }');
        Add('{                       índices e constraints no próprio modelo.               }');
        Add('{                       Se você usa um SVN ou CVS com o tempo terá um bom      }');
        Add('{                       histórico de alteraçoes estruturais da base de dados.  }');
        Add('{******************************************************************************}');
        Add('');
        Add(Format('Unit %s;',[unitName]));
        Add('');
        Add('interface');
        Add('');
        Add('uses');
        Add(modelsUses);
        Add('');
        Add('Type');
        Add('');
        Add('{******************************************************************************}');
        for j:=0 to TypesStr.Count-1 do
          Add(Format('  %s',[TypesStr[j]]));
        Add('{******************************************************************************}');
        Add('');
        GeneratePropertiesDPSUnit(TableList[i],UnitStr,PatternGetSet);
        Add('implementation');
        GenerateImplementDPSUnit(TableList[i],UnitStr,PatternGetSet);
        Add('end.');
      end;
      UnitStr.SaveToFile(Format('%s%s.pas',[sUnitsPath,unitName]));
      Result.Add(Format('%s%s.pas',[sUnitsPath,unitName]));
    end;
  finally
    TypesStr.Free;
    UnitStr.free;
  end;
end;


(* Geração de uma Units com todas as classes *)
function TAbstractDataManager.GenerateSingleModelsUnit(sUnitPath:string;TableList:TStringList;PatternGetSet:TPatternGettersAndSetters=tpatDelphiShort):String;
var
  i:Integer;
  uName:string;
  uStr :TStringList;
  TypesStr:TStringList;
begin
  uStr     := TStringList.Create;
  TypesStr := TStringList.Create;
  GenerateNewDelphiTypesFromDatabase(TypesStr);
  try
    uName := 'DPSDBModels';
    with uStr do
    begin
      Add('{******************************************************************************}');
      Add('{          UNIT GERADA AUTOMATICAMENTE                                         }');
      Add('{                                                                              }');
      Add('{               Name:   Delphi Persistence Framework                           }');
      Add('{             Author:   Bianco - conofresilva@gmail.com                        }');
      Add('{            Version:   3.0 - 2011-2013                                        }');
      Add('{            Summary:   Framework de persistência em Delphi                    }');
      Add('{           Comments:   A sugestão é que vc importe uma única vez e passe a    }');
      Add('{                       fazer as alterações ou acréscimos de campos, tabelas   }');
      Add('{                       índices e constraints no próprio modelo.               }');
      Add('{                       Se você usa um SVN ou CVS com o tempo terá um bom      }');
      Add('{                       histórico de alteraçoes estruturais da base de dados.  }');
      Add('{******************************************************************************}');
      Add('');
      Add(Format('Unit %s;',[uName]));
      Add('');
      Add('interface');
      Add('');

      Add('uses');
      Add(modelsUses);
      Add('');
      Add('Type');
      Add('');
      Add('{******************************************************************************}');
      for i:=0 to TypesStr.Count-1 do
        Add(Format('  %s',[TypesStr[i]]));
      Add('{******************************************************************************}');
      Add('');
      Add('(* Forward declarations .... *)');
      for i:= 0 to TableList.Count-1 do
        uStr.Add(Format('  T%s = class;',[UpperFirstChar(TableList[i])]));
      Add('');
      (*  Criando a Classe Master DataManager  *)
      GeneratePropertiesMasterDataManager(TableList,uStr,PatternGetSet);

      (* Criando as propriedades dos models...*)
      for i:= 0 to TableList.Count-1 do
        GeneratePropertiesDPSUnit(TableList[i],uStr,PatternGetSet);

      Add('implementation');
      Add('');
      (* Implementaçao do Master Data Manager *)
      GenerateImplementsMasterDataManager(TableList,uStr,PatternGetSet);

      (* criando a implementação do modelo... *)
      for i:= 0 to TableList.Count-1 do
        GenerateImplementDPSUnit(TableList[i],uStr,PatternGetSet);

      Add('end.');
      SaveToFile(Format('%s%s.pas',[sUnitPath,uName]));
    end;
    Result := Format('%s%s.pas',[sUnitPath,uName]);
  finally
    TypesStr.Free;
    uStr.free;
  end;
end;

function TAbstractDataManager.SetupReflection(dtReflec:TDataReflection):Integer;
var
  tRef : TTypeReflection;
  i: integer;
begin
  Result := -1;
  if trim(dtReflec.DataTypeName) = '' then exit;
  (* no dm registramos 1 reflection para cada tipo, banco e delphi *)
  for tRef := low(TTypeReflection) to high(tref) do
  begin
    for i:=0 to Length(FDmReflections) -1 do
      if  (SameText(FDmReflections[i].DataTypeName,dtReflec.DataTypeName)
      and (FDmReflections[i].TypeReflection = tRef )) then
          Result := i;

      if Result =-1 then
      begin
        Result := Length(FDmReflections);
        SetLength(FDmReflections,Length(FDmReflections)+1);

        (* só inclui novo quando não achar igaul*)
        FDmReflections[Result].OriginalDataTypeName     := dtReflec.DataTypeName;
        FDmReflections[Result].DataTypeName             := dtReflec.DataTypeName;
        FDmReflections[Result].TypeDatabase             := FTypeDatabase;   // do datamanager
        FDmReflections[Result].VersionDB                := FVersionDatabase;// do datamanager
        FDmReflections[Result].VersionCoreDB            := FVersionCoreDB;  // do datamanager
        FDmReflections[Result].DialectCoreDB            := FDialectCoreDB;  // do datamanager
        FDmReflections[Result].TypeReflection           := tRef;
        FDmReflections[Result].BasicTypeKind            := dtReflec.BasicTypeKind;
        FDmReflections[Result].AcceptsNull              := dtReflec.AcceptsNull;
        FDmReflections[Result].IndexDynamicType         := -1;
        if FDmReflections[Result].BasicTypeKind in [tkSet,tkEnumeration] then
        begin
          for i:=0 to length(FDmDynamicTypes)-1 do
            if SameText(FDmReflections[Result].DataTypeName,FDmDynamicTypes[i].Name) then
              FDmReflections[i].IndexDynamicType := i;
        end;
        FDmReflections[Result].DataSize                 := dtReflec.DataSize;
        FDmReflections[Result].DataSizeScale            := dtReflec.DataSizeScale;
        FDmReflections[Result].DefaultValue             := dtReflec.DefaultValue;
        if FDmReflections[Result].NativeType = ntUnknow then
          FDmReflections[Result].NativeType               := ValidateNativeTypeByName(dtReflec.DataTypeName);
        (*  em branco para tipos  *)
  //      FDmReflections[Result].ClassOrTableName         := '';
  //      FDmReflections[Result].PropertyOrColumnName     := '';
  //      FDmReflections[Result].PropertyOrColumnDescript := '';
      end;
  end;
end;

(* Declarando as propriedades do DataManager *)
procedure TAbstractDataManager.GenerateImplementsMasterDataManager(
  strClassList: TStringList; var strListContainer: TStringList;PatGetSet:TPatternGettersAndSetters=tpatDelphiShort);
var
  i:Integer;
begin
  (* Implementando o construtor.... *)
  if strClassList.count > 0 then
  begin
    strListContainer.Add('constructor TMasterDataManager.Create;');
    strListContainer.Add('begin');
    strListContainer.Add('(*----------------------------------------------------------------------*)');
    strListContainer.Add('(* configuração da conexão *)');
    strListContainer.Add('(*----------------------------------------------------------------------*)');
    strListContainer.Add('(* ex:  *)');
    strListContainer.Add('(*    '+ format('ALIAS := %s;',[QuotedStr('alias_padrao')] ) +'      *)');
    strListContainer.Add('(*    '+ format('SetupConnection(%s,%s,%s,%s,%s,%s,%s,%s,%s,);',[QuotedStr('alias_padrao'),
                                                                                           QuotedStr('firebirdd-2.5'),
                                                                                           QuotedStr(''),
                                                                                           QuotedStr('SYSDBA'),
                                                                                           QuotedStr('masterkey'),
                                                                                           QuotedStr('padrao.fdb'),
                                                                                           '0',
                                                                                           'True',
                                                                                           'True'])
                         +'      *)');
    strListContainer.Add('(*----------------------------------------------------------------------*)');
    strListContainer.Add('  inherited;');
    strListContainer.Add('(*  os objetos herdam de TInterfacedObject, não se preocupe em destruí-los  *)');
    for i:=0 to strClassList.count-1 do
      strListContainer.Add(Format('  %s := T%s.Create(Self);',[UpperFirstChar(strClassList[i])
                                                              ,UpperFirstChar(strClassList[i])]));
    strListContainer.Add('end;');

//    (* implementacao que vai retornar instâncias da Extesão do modelo *)
//    for i:=0 to strClassList.count-1 do
//    begin
//      strListContainer.Add(Format('function TMasterDataManager.get%s(ValueKeyField:String = %s): T%s;'
//                                  ,[UpperFirstChar(strClassList[i])
//                                  , QuotedStr('')
//                                  , UpperFirstChar(strClassList[i])]));
//      strListContainer.Add('begin');
//      strListContainer.Add(Format('  Result := %s.get(ValueKeyField) as T%s;'
//                                  ,[UpperFirstChar(strClassList[i])
//                                  , UpperFirstChar(strClassList[i])]));
//      strListContainer.Add('end;');
//      strListContainer.Add('');
//    end;
  end;

  case PatGetSet of
    tpatDelphi:
    begin
      for i:=0 to strClassList.count-1 do
      begin
        strListContainer.Add(Format('procedure  TMasterDataManager.Set%s(Value : T%s);',[UpperFirstChar(strClassList[i])
                                                                                        ,UpperFirstChar(strClassList[i])]));
        strListContainer.Add('begin');
        strListContainer.Add(Format('  F%s := Value;',[UpperFirstChar(strClassList[i])]));
        strListContainer.Add('end;');
        strListContainer.Add('');
      end;
    end;

    tpatJava:
    begin
      for i:=0 to strClassList.count-1 do
      begin
        strListContainer.Add(Format('function  TMasterDataManager.Get%s(ValueKeyField:String=%s):T%s;'
                                   ,[UpperFirstChar(strClassList[i])
                                   , UpperFirstChar(strClassList[i])]));
        strListContainer.Add('begin');
        strListContainer.Add(Format('  Result := F%s;',[UpperFirstChar(strClassList[i])]));
        strListContainer.Add('end;');
        strListContainer.Add('');
      end;

      for i:=0 to strClassList.count-1 do
      begin
        strListContainer.Add(Format('procedure  TMasterDataManager.Set%s(Value : T%s);',[UpperFirstChar(strClassList[i])
                                                                                        ,UpperFirstChar(strClassList[i])]));
        strListContainer.Add('begin');
        strListContainer.Add(Format('  F%s := Value;',[UpperFirstChar(strClassList[i])]));
        strListContainer.Add('end;');
        strListContainer.Add('');
      end;
    end;
  end;

end;

(*  Gerando a implementação do DataManager *)
procedure TAbstractDataManager.GeneratePropertiesMasterDataManager(strClassList: TStringList;
                                                                   var strListContainer: TStringList;
                                                                   PatGetSet:TPatternGettersAndSetters=tpatDelphiShort);
var
  i:Integer;
begin
  strListContainer.Add('  TMasterDataManager = Class(TAbstractDataManager)');
  strListContainer.Add('  private');
  (* Variáveis internas para guardar o valor da propriedade *)
  for i := 0 to strClassList.Count-1 do
    strListContainer.Add(Format('    F%s : T%s;',[UpperFirstChar(strClassList[i])
                                                 ,UpperFirstChar(strClassList[i])]));
  case PatGetSet of
    tpatDelphiShort:;//nada a fazer
    tpatDelphi:
    begin
      (* procedure Set da propriedades ... *)
      for i := 0 to strClassList.Count-1 do
        strListContainer.Add(Format('    procedure  Set%s(Value : T%s);',[UpperFirstChar(strClassList[i])
                                                                         ,UpperFirstChar(strClassList[i])]));
    end;

    tpatJava:
    begin
      (* procedure Get da propriedades ...*)
      for i := 0 to strClassList.Count-1 do
        strListContainer.Add(Format('    function  Get%s:T%s;',[UpperFirstChar(strClassList[i])
                                                                         ,UpperFirstChar(strClassList[i])]));
      (* procedure Set da propriedades ...*)
      for i := 0 to strClassList.Count-1 do
        strListContainer.Add(Format('    procedure  Set%s(Value:T%s);',[UpperFirstChar(strClassList[i])
                                                                         ,UpperFirstChar(strClassList[i])]));
    end;
  end;
  strListContainer.Add('  public');
  case PatGetSet of
    tpatDelphiShort:
    begin
      for i := 0 to strClassList.Count-1 do
        strListContainer.Add(Format('    property %s : T%s read F%s write F%s;',[UpperFirstChar(strClassList[i])
                                                                                  ,UpperFirstChar(strClassList[i])
                                                                                  ,UpperFirstChar(strClassList[i])
                                                                                  ,UpperFirstChar(strClassList[i])]));

    end;

    tpatDelphi:
    begin
      for i := 0 to strClassList.Count-1 do
        strListContainer.Add(Format('    property %s : T%s read F%s write Set%s;',[UpperFirstChar(strClassList[i])
                                                                                  ,UpperFirstChar(strClassList[i])
                                                                                  ,UpperFirstChar(strClassList[i])
                                                                                  ,UpperFirstChar(strClassList[i])]));

    end;

    tpatJava:
    begin
      for i := 0 to strClassList.Count-1 do
        strListContainer.Add(Format('    property %s : T%s read Get%s write Set%s;',[UpperFirstChar(strClassList[i])
                                                                                  ,UpperFirstChar(strClassList[i])
                                                                                  ,UpperFirstChar(strClassList[i])
                                                                                  ,UpperFirstChar(strClassList[i])]));
    end;
  end;
  if strClassList.Count > 0 then
    strListContainer.Add('    constructor Create;override;');
  strListContainer.Add('  end;');
end;


function TAbstractDataManager.SetupDynamicType(DynType: TDynamicType): Integer;
var
  i:integer;
begin
  Result := -1;
  for i:=0 to length(FDmDynamicTypes)-1 do
    if SameText(DmDynamicTypes[i].Name,DynType.Name) then
      Result := i;

  if Result = -1 then
  begin
    Result := length(FDmDynamicTypes);
    SetLength(FDmDynamicTypes,length(FDmDynamicTypes) +1);
  end;

  DmDynamicTypes[Result].Name := DynType.Name;
  SetLength(DmDynamicTypes[Result].DynamicValues,length(DynType.DynamicValues));
  for i:=0 to length(DynType.DynamicValues)-1 do
    DmDynamicTypes[Result].DynamicValues[i] := DynType.DynamicValues[i];
end;

function TAbstractDataManager.SetupTableReflection(var tbReflec: TReflection): Integer;
var
  i:integer;
begin
  Result := -1;
  if Length(tbReflec) < 1 then exit;

  for i:=0 to length(FTableReflections) -1 do
    if SameText(tbReflec[1].ClassName,FTableReflections[i][1].ClassName) then
       Result := i;

  if Result = -1 then
  begin
    Result := length(FTableReflections);
    setLength(FTableReflections,length(FTableReflections)+1);
  end;

  SetLength(FTableReflections[Result],length(tbReflec));
  FTableReflections[Result]:= tbReflec;
end;

{ TDataManager }

procedure TAbstractDataManager.ResetReflection(var dtReflec:TDataReflection );
begin
  with dtReflec do
  begin
    TypeReflection        := trDelphiToDatabase;
    ClassName             := '';
    ClassOrTableName      := '';
    PropertyOrColumnName  := '';
    DataTypeName          := '';
    OriginalDataTypeName  := '';
    DisplayMask           := '';
    BasicTypeKind         := tkUnknown;
    DatabaseCheck         := nil;
    FriendlyValues        := nil;
    NativeType            := ntUnknow;
    VersionDB             := 0;
    VersionCoreDB         := 0;
    DialectCoreDB         := 0;
    PrimaryKey            := False;
    AcceptsNull           := True;
    AutoInc               := False;
    IndexDynamicType      := -1;  // default
  end;
end;


procedure TAbstractDataManager.setAlias(const Value: String);
begin
  FALIAS := Value;
end;

procedure TAbstractDataManager.setBusinessRules( const Value: TBusinessRules);
begin
  FBusinessRules := Value;
end;


procedure TAbstractDataManager.setConnectionString(const Value: String);
begin
  FConnectionString :=Value;
end;

procedure TAbstractDataManager.setDialectCoreDB(const Value: Int64);
begin
  FDialectCoreDB := Value;
end;

procedure TAbstractDataManager.setDmDynamicTypes( const Value: TDynamicTypes);
begin
  FDmDynamicTypes := Value;
end;

procedure TAbstractDataManager.setDmReflections(const Value: TReflection);
begin
  FDmReflections := Value;
end;

procedure TAbstractDataManager.setIniFileConfig(const Value: String);
begin
  FIniFileConfig := Value;
end;

procedure TAbstractDataManager.setKeyFieldAutoGenerated(
  const Value: Boolean);
begin
  FKeyFieldAutoGenerated := Value;
end;

procedure TAbstractDataManager.setLocalServer(const Value: Boolean);
begin
  FLocalServer := value;
end;

procedure TAbstractDataManager.setLogs(const Value: TStringList);
begin
  FLogs := Value;
end;

function TAbstractDataManager.ConfigReflecion(dTypeName:String;
                                                  tKind:TTypeKind;
                                               frValues:array of String;
                                                   size:Int64=0;
                                              precision:Int64=0;
                                               defValue:string='';
                                           ntNativeType:TNativeType=ntUnknow;
                                               alowNull:Boolean= True):TDataReflection;
var
  x:integer;
begin
  ResetReflection(Result);
  with Result do
  begin
    DataTypeName    := dTypeName;
    SetLength(FriendlyValues,length(frValues));
    for x:=0 to length(frValues)-1 do
      FriendlyValues[x] := frValues[x];
    DataSize        := size;
    DataSizeScale   := precision;
    DefaultValue    := defValue;

    if BasicTypeKind = tkUnknown
      then
        BasicTypeKind   := tKind;

    if NativeType = ntUnknow
      then
        NativeType  := ValidateNativeTypeByName(dTypeName);

    AcceptsNull     := alowNull;
  end;
end;

procedure TAbstractDataManager.Setup;
begin
  (* Strings *)
  SetupReflection(configReflecion('Char',tkChar,[],255,0,'',ntDelphiAndDatabase));
  SetupReflection(configReflecion('AnsiChar',tkChar,[],255,0,'',ntDelphi));
  SetupReflection(configReflecion('WideChar',tkChar,[],255,0,'',ntDelphi));
  SetupReflection(configReflecion('String',tkString,[],255,0,'',ntDelphi));
  SetupReflection(configReflecion('ShortString',tkString,[],255,0,'',ntDelphi));
  SetupReflection(configReflecion('AnsiString',tkString,[],255,0,'',ntDelphi));
  SetupReflection(configReflecion('WideString',tkString,[],255,0,'',ntDelphi));
  SetupReflection(configReflecion('TBlobData',tkClass,[],0,0,'',ntDelphi));
  SetupReflection(configReflecion('TArray<System.Byte>',tkDynArray,[],0,0,'',ntDelphi));
  SetupReflection(configReflecion('TBitMap',tkClass,[],0,0,'',ntDelphi));

  (* Inteiros *)
  SetupReflection(configReflecion('Byte',tkInteger,[],Low(Byte),High(Byte),'',ntDelphi));
  SetupReflection(configReflecion('Word',tkInteger,[],Low(Word),High(Word),'',ntDelphi));
  SetupReflection(configReflecion('LongWord',tkInt64,[],Low(LongWord),High(LongWord),'',ntDelphi));
  SetupReflection(configReflecion('Cardinal',tkInt64,[],Low(Cardinal),High(Cardinal),'',ntDelphi));
  SetupReflection(configReflecion('ShortInt',tkInteger,[],Low(ShortInt),High(ShortInt),'',ntDelphi));
  SetupReflection(configReflecion('SmallInt',tkInteger,[],Low(SmallInt),High(SmallInt),'',ntDelphi));
  SetupReflection(configReflecion('Integer',tkInteger,[],Low(Integer),High(Integer),'',ntDelphiAndDatabase));
  SetupReflection(configReflecion('LongInt',tkInt64,[],Low(LongInt),High(LongInt),'',ntDelphi));
  SetupReflection(configReflecion('Int64',tkInt64,[],0,0,'',ntDelphi));

  (* Ponto Flutuante *)
  SetupReflection(configReflecion('Single',tkFloat,[], 0, 7,'',ntDelphi));
  SetupReflection(configReflecion('Double',tkFloat,[], 0,14,'',ntDelphi));
  SetupReflection(configReflecion('Extended',tkFloat,[], 0, 0,'',ntDelphi));
  SetupReflection(configReflecion('Currency',tkFloat,[], 18, 4,'',ntDelphi));
  SetupReflection(configReflecion('Real',tkFloat,[], 0, 0,'',ntDelphi));

  (* Range negativo indica Tipos Date,Time,DateTime *)
  SetupReflection(configReflecion('TDate',tkFloat,[],  -1,0,'',ntDelphi));// Sempre Tipo Data
  SetupReflection(configReflecion('TTime',tkFloat,[],  -2,0,'',ntDelphi));// Sempre Tipo Data
  SetupReflection(configReflecion('TDateTime',tkFloat,[], -3,0,'',ntDelphi));// Sempre Tipo Data

  (* tipos retornados pela zeos lib como sendo do banco de dados, conforme padrão SQL3 *)
  SetupReflection(configReflecion('TEXT',tkString,[],0,0,'',ntDatabase));


  (* Enumeração *)
  SetupReflection(configReflecion('Boolean',tkEnumeration,['Falso','Verdadeiro'],0,1,'0',ntDelphi));

  case TypeDatabase of
    tdbFirebird:
    begin
      (*  Tipos homonimos ao Delphi --> CHAR,INTEGER,SMALLINT,CURRENCY     *)
      (* String *)
      SetupReflection(configReflecion('VARCHAR',tkString,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('BLOB',tkClass,[], 0,0,'',ntDatabase));
      (* Inteiro *)
      SetupReflection(configReflecion('BIGINT',tkInt64,[], 0,0,'',ntDatabase));
      (* Real  - Ponto flutuante  - especificações default *)
      SetupReflection(configReflecion('DOUBLE PRECISION',tkFloat,[],0, 0,'',ntDatabase));
      SetupReflection(configReflecion('DECIMAL',tkFloat,[],  0, 0,'',ntDatabase));
      SetupReflection(configReflecion('NUMERIC',tkFloat,[], 18,4,'',ntDatabase));
      SetupReflection(configReflecion('FLOAT',tkFloat,[], 15, 7,'',ntDatabase));
      SetupReflection(configReflecion('DATE',tkFloat,[], -1, 0,'',ntDatabase));
      SetupReflection(configReflecion('TIME',tkFloat,[], -2, 0,'',ntDatabase));
      SetupReflection(configReflecion('TIMESTAMP',tkFloat,[], -3, 0,'',ntDatabase));
    end;

    tdbPostgreSQL:
    begin
      SetupReflection(configReflecion('CHARACTER',tkChar,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('CHARACTER VARYING',tkString,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('VARCHAR',tkString,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('TEXT',tkString,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('BLOB',tkClass,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('BYTEA',tkClass,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('SERIAL',tkInt64,[],0,2147483647,'',ntDatabase));
      SetupReflection(configReflecion('BIGSERIAL',tkInt64,[],0,9223372036854775807,'',ntDatabase));
      SetupReflection(configReflecion('BIGINT',tkInt64,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('BOOLEAN',tkInteger,[],1,2,'1',ntDelphiAndDatabase));
      SetupReflection(configReflecion('DOUBLE PRECISION',tkFloat,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('CIDR',tkString,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('INET',tkString,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('MONEY',tkFloat,[],0,4,'',ntDatabase));
      SetupReflection(configReflecion('DECIMAL',tkFloat,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('NUMERIC',tkFloat,[],18,10,'',ntDatabase));
      SetupReflection(configReflecion('DATE',tkFloat,[],-1,0,'',ntDatabase));
      SetupReflection(configReflecion('TIME',tkFloat,[],-2,0,'',ntDatabase));
      SetupReflection(configReflecion('TIMESTAMP',tkFloat,[],-3,0,'',ntDatabase));
      SetupReflection(configReflecion('INTERVAL',tkFloat,[],-3,0,'',ntDatabase));
    end;

    tdbSQLite3:
    begin
      SetupReflection(configReflecion('TEXT',tkString,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('BLOB',tkClass,[], 0,0,'',ntDatabase));
      SetupReflection(configReflecion('INTEGER',tkInt64,[], 0,0,'',ntDelphiAndDatabase));
      SetupReflection(configReflecion('REAL',tkFloat,[],0,0,'',ntDatabase));
      SetupReflection(configReflecion('NUMERIC',tkFloat,[], 18,10,'',ntDatabase));
    end;

    tdbOracle:
    begin
      //TODO:SetupReflectionsOracle ainda nao validado
    end;

//    tdbADO:
//    begin
//    end;
  end;

end;

function TAbstractDataManager.getAlias: String;
begin
  Result := FALIAS;
end;

function TAbstractDataManager.getBusinessRules: TBusinessRules;
begin
  Result := FBusinessRules;
end;

function TAbstractDataManager.getConection: TZConnection;
begin
  Result := TZConnection.Create(nil);
  try
    Result.LoginPrompt := False;
    Result.AutoCommit  := True;
    Result.Protocol    := getParam(dpsZEOSDRIVER);
    Result.HostName    := getParam(dpsHOST);
    Result.Database    := getParam(dpsPATH);
    Result.Port        := StrToInt(getParam(dpsPORTA,'0'));
    Result.User        := getParam(dpsUSUARIO);
    Result.Password    := getParam(dpsSENHA);
    Result.Properties.Add ('lc_ctype=WIN1252');
    Result.Connect;
  except
    FreeAndNil(Result);
  end;
end;

function TAbstractDataManager.getTempQuery(sql: string): TZQuery;
begin
  Result := TZQuery.Create(nil);
  Result.Connection := getConection;
  try
    Result.SQL.Add(sql);
    Result.Open;
  except
    on e:Exception do
      raise EDPSException.Create(SDatamanagerTempQueryError);
  end;
end;

function TAbstractDataManager.getTypeDatabase: TTypeOfDatabase;
begin
  Result := FTypeDatabase;
end;

function TAbstractDataManager.getTypeNode: TTypeNode;
begin
  Result := FTypeNode;
end;


//function TDPSAbstractModel.getDataManager: TIDataManagerClass;
//begin
//  Result := FDatamanager;
//end;

function TDPSAbstractModel.getForeignKeys: TConstraintForeignKeys;
begin
  Result := FForeignKeys;
end;

function TDPSAbstractModel.getIndexes: TIndexes;
begin
  Result := FIndexes;
end;

function TDPSAbstractModel.getKeyFieldAutoGenerated: Boolean;
begin
  Result := FKeyFieldAutoGenerated;
end;

function TDPSAbstractModel.getKeyFieldName: String;
begin
  Result := FKeyFieldName;
end;

function TDPSAbstractModel.getModelDynamicTypes: TDynamicTypes;
begin
  Result := FModelDynamicTypes;
end;

function TDPSAbstractModel.getModelReflection: TReflection;
begin
  Result := FModelReflection;
end;

function TDPSAbstractModel.getModelState: TModelState;
begin
  Result := FModelState;
end;

function TDPSAbstractModel.getPrimaryKeys: TConstraintPrimaryKeys;
begin
  Result := FPrimaryKeys;
end;

function  TDPSAbstractModel.GetTypeDatabase:TTypeOfDatabase;
begin
  Result := ftypeDatabase;
end;

function TDPSAbstractModel.getUniqueKeys: TConstraintUniqueKeys;
begin
  Result := FUniqueKeys;
end;

function TDPSAbstractModel.getWhere(sWhere, sOrder: String;externalDataSet:TClientDataSet): IDataModel;
var
  qrGet:TZQuery;
  sql  :String;
begin
  sql := format('select * from %s',[TableName]);

  if trim(sWhere) <> ''
    then sql := format('%s where %s',[sql,sWhere]);

  if trim(sOrder) <> ''
    then sql := format('%s where %s',[sql,sOrder]);

  qrGet := Datamanager.getTempQuery(sql);
  try
    if not (qrGet.IsEmpty) or( externalDataSet <> nil) then
      Result := New(Datamanager,qrGet)
    else
      Result := nil;

    configureExternalDataset(externalDataSet);
    if Result <> nil then
      Result.fillDataset(externalDataSet);

  finally
    qrGet.Connection.free;
    FreeAndNil(qrGet);
  end;
end;

class function TDPSAbstractModel.new(dmgr: IDataManager;qrDataset:TZQuery): TDPSAbstractModel;
begin
   Result := Create(dmgr);
   Result.fillproperties(qrDataset);
end;

function TDPSAbstractModel.delete: Boolean;
var
  sql:string;
  qr_delete  : TZQuery;
begin
  Result := false;

  sql    := format('select * from %s where (%s = %s)',[TableName,KeyFieldName,QuotedStr(GetPropValue(self,KeyFieldName,False))]);
  qr_delete := Datamanager.getTempQuery(sql);
  try
    if not qr_delete.IsEmpty then
    begin
      try
        qr_delete.delete;
        Result := true;
        Datamanager.AddLogBusinessRule(codSWarningDeleteRecordSuccess,
                                       format(SWarningDeleteRecordSuccess,[GetPropValue(self,KeyFieldName,True)])+#13#10+sql,
                                       sbrWarning);
      except
        //EDPSException.Create(SModelDeleteError);
        Datamanager.AddLogBusinessRule(codSModelDeleteError,
                                       format(SModelDeleteError,[GetPropValue(self,KeyFieldName,True)])+#13#10+sql,
                                       sbrError);
      end;
    end
      else
        //raise EDPSException.Create(format(SModelCanotDeleteBecauseIsEmpty,[GetPropValue(self,KeyFieldName,True)]));
        Datamanager.AddLogBusinessRule(codSModelCanotDeleteBecauseIsEmpty,
                                       format(SModelCanotDeleteBecauseIsEmpty,[GetPropValue(self,KeyFieldName,True)])+#13#10+sql,
                                       sbrError);
  finally
    qr_delete.Connection.free;
    qr_delete.free;
  end;
end;

procedure TDPSAbstractModel.fillproperties(qrOrigin:TDataSet);
var
  i:Integer;
begin
    FDatamanager.ResetLogBusinessRule;
    if qrOrigin.State in [dsEdit,dsInsert]
      then qrOrigin.Post;

    if not (qrOrigin.IsEmpty) and (KeyFieldName <> '') then
    begin
      try
        for i:=0 to qrOrigin.FieldCount-1 do
        begin
          try
            case qrOrigin.Fields[i].DataType of
              ftDate,
              ftTime,
              ftDateTime:begin
                           if qrOrigin.Fields[i].IsNull
                             then SetPropValue(self, qrOrigin.Fields[i].FieldName, MinDateTime)
                             else SetPropValue(self, qrOrigin.Fields[i].FieldName, VarToDateTime( qrOrigin.Fields[i].Value ) );
                         end;
              ftFloat:    SetPropValue(self, qrOrigin.Fields[i].FieldName, qrOrigin.Fields[i].AsFloat );
              ftLargeint,ftExtended:
                          SetPropValue(self, qrOrigin.Fields[i].FieldName, qrOrigin.Fields[i].AsLargeInt);
              ftCurrency: SetPropValue(self, qrOrigin.Fields[i].FieldName, qrOrigin.Fields[i].AsCurrency );

              ftSmallint,
              ftInteger:  SetPropValue(self, qrOrigin.Fields[i].FieldName, qrOrigin.Fields[i].AsInteger);

              ftBlob:begin
                       if Length( TBlobField(qrOrigin.Fields[i]).Value) > 0
                         then
                           SetPropValue(self, qrOrigin.Fields[i].FieldName,TBlobField(qrOrigin.Fields[i]).Value);
                     end;
              else
                 SetPropValue(self, qrOrigin.Fields[i].FieldName, qrOrigin.FieldValues[qrOrigin.Fields[i].FieldName]);
              end;
          except
            on e:exception do
            begin
              Datamanager.AddLogBusinessRule(codSFillPropertiesErrorInProperty,
                                             format(SFillPropertiesErrorInProperty,[qrOrigin.Fields[i].FieldName,qrOrigin.FieldByName(qrOrigin.Fields[i].FieldName).AsString])
                                             +#13#10+'*** '+e.Message,
                                             sbrWarning);
              continue;
            end;
          end;
        end;

      Datamanager.AddLogBusinessRule(codSFillPropertiesOK,
                                     format(SFillPropertiesOK,[ClassModelName]),
                                     sbrWarning);
      except
        on e:exception do
          Datamanager.AddLogBusinessRule(codSFillPropertiesErrorInGeneral,
                                         format(SFillPropertiesErrorInGeneral,[ClassModelName])
                                         +#13#10+'*** '+e.Message,
                                         sbrError);
      end;
    end;
end;

function TDPSAbstractModel.SetupIndex(IdxName:string;tabName:String;arFields:array of String;bUnique:Boolean = False;DescendentOrd:Boolean = false):Integer;
var
  i :Integer;
begin
  Result := -1;
  for i:= 0 to Length(FIndexes)-1 do
    if SameText(FIndexes[i].IndexName,IdxName) then
      Result := i;

  if (Result = -1) then
  begin
    Result := Length(FIndexes);
    SetLength(FIndexes, (Length(FIndexes)+1));
  end;

  with FIndexes[Result] do
  begin
    IndexName := IdxName;
    TableName := tabName;
    SetLength(Fields,length(arFields));
    for i:=0 to length(arFields)-1 do
      Fields[i] := arFields[i];
    Unique    := bUnique;
    DescOrd   := DescendentOrd;
  end;
  Datamanager.SetupIndex(FIndexes[Result]);
end;

function TDPSAbstractModel.SetupPrimaryKey(pkName:string;tabName:String;FieldKey:String;listCheckList:array of String):Integer;
var
  i :Integer;
begin
  Result := -1;
  for i:=0 to Length(FPrimaryKeys)-1 do
    if SameText(FPrimaryKeys[i].PrimaryKeyName,pkName) then
      Result := i;

  if (Result = -1) then
  begin
    Result := Length(FPrimaryKeys);
    SetLength(FPrimaryKeys,(Length(FPrimaryKeys)+1));
  end;

  with FPrimaryKeys[Result] do
  begin
    PrimaryKeyName         := pkName;
    PrimaryKeyTable        := tabName;
    PrimaryKeyField        := FieldKey;

    for i:=0 to Length(FModelReflection)-1 do
      if SameText(FModelReflection[i].PropertyOrColumnName,FieldKey) then
      begin
        FModelReflection[i].AutoInc     := True;
        FModelReflection[i].PrimaryKey  := True;
        FModelReflection[i].AcceptsNull := False;
      end;
  end;
  if DataManager <> nil
    then Datamanager.SetupPrimaryKey(FPrimaryKeys[Result]);
end;

function TDPSAbstractModel.SetupForeignKey(fkName:string;
                                           tblName:string;
                                           fkTabName:string;
                                           rlUpdate,
                                           rlDelete:TTpRuleConstraint;
                                           listOnFields:array of String;
                                           listTargetFields:array of String):Integer;
var
  i,j :Integer;
begin
  Result := -1;
  for i:=0 to Length(FForeignKeys)-1 do
    if SameText(FForeignKeys[i].ForeignKeyName,fkName) then
      Result := i;

  if (Result = -1 ) then
  begin
    Result := Length(FForeignKeys);
    SetLength(FForeignKeys,Length(FForeignKeys)+1);
  end;

  with FForeignKeys[Result] do
  begin
    ForeignKeyName         := fkName;
    ForeignKeyTable        := tblName;
    ForeignKeyTargetTable  := fkTabName;
    IndexName              := '';
    RuleOnUpdate           := rlUpdate;
    RuleOnDelete           := rlDelete;

    SetLength( FForeignKeys[Result].LocalFields,length(listOnFields));
    for j:=0 to length(listOnFields)-1 do
    FForeignKeys[Result].LocalFields[j] := listOnFields[j];

    SetLength(TargetFields,length(listTargetFields));
    for j:=0 to length(listTargetFields)-1 do
      FForeignKeys[Result].TargetFields[j] := listTargetFields[j];
  end;

  if Datamanager <> nil then
    Datamanager.SetupForeignKey(FForeignKeys[result]);
end;


function TDPSAbstractModel.SetupUniqueKey(ukName:string;ukTabName:String;listOnFields:array of String):Integer;
var
  i,j :Integer;
begin
  Result := -1;
  for i:=0 to Length(FUniqueKeys)-1 do
    if SameText(FUniqueKeys[i].UniqueKeyName,ukName) then
      Result := i;
  if (Result = -1) then
  begin
    Result := Length(FUniqueKeys);
    SetLength(FUniqueKeys,(1+Length(FUniqueKeys)));
  end;

  with FUniqueKeys[Result] do
  begin
    UniqueKeyName        := ukName;
    UniqueKeyTable       := ukTabName;
    SetLength(LocalFields,length(listOnFields));
    for j:=0 to length(listOnFields)-1 do
      LocalFields[j] := listOnFields[j];
  end;
  if Datamanager <> nil then
    Datamanager.SetupUniqueKey(FUniqueKeys[result]);
end;

function TDPSAbstractModel.Token: String;
begin
  Result := '';
  if trim(FTokenizer) <> '' then
    Result := GeraMD5(FTokenizer);
end;

procedure TDPSAbstractModel.UpdateLastID;
var
  sql_query:string;
  qrTemp:TZQuery;
  lastid:Int64;
begin
  lastid := 0;
  case Datamanager.TypeDatabase of
    tdbFirebird:
    begin
      try
        sql_query := format('select max(%s)lastid from %s',[KeyFieldName,TableName]);
        qrTemp := Datamanager.getTempQuery(sql_query);
        if not qrTemp.IsEmpty then
          lastid := qrTemp.fieldbyName('lastid').AsLargeInt;
        if lastid > 0
          then Datamanager.ExecuteScript(format('SET GENERATOR %s TO %d',[UpperCase( KeyFieldName+TableName),lastid]));
      finally
        qrTemp.Connection.free;
        qrTemp.Free;
      end;
    end;
  end;
end;

procedure TDPSAbstractModel.fillDataset(qrDestination: TDataset);
var
  ifield:integer;
begin
  FDatamanager.ResetLogBusinessRule;
  if (qrDestination <> nil) then
  begin
    try
      if qrDestination.State in [dsEdit,dsInsert] then
        qrDestination.post;

      if qrDestination.Locate(self.FKeyFieldName,GetPropValue(self,self.FKeyFieldName),[])
        then qrDestination.edit
        else qrDestination.Append;

      for ifield:= 0 to length(FModelReflection)-1 do
      begin
        try
          case qrDestination.Fields[ifield].DataType of
            ftDate,ftTime,ftDateTime:
            begin
             (* proteção visual para não exibir data 0*)
             if VarToDateTime(GetPropValue(TObject(self),FModelReflection[ifield].PropertyOrColumnName,False)) > 0
               then
                 qrDestination.FieldValues[FModelReflection[ifield].PropertyOrColumnName] := GetPropValue(TObject(self),FModelReflection[ifield].PropertyOrColumnName,False)
               else
                 qrDestination.FieldValues[FModelReflection[ifield].PropertyOrColumnName] := Null;
            end;

            ftBlob:
            begin
              if Length(GetPropValue(TObject(self),FModelReflection[ifield].PropertyOrColumnName)) > 0
                then
                  TBlobField(qrDestination.FieldByName(FModelReflection[ifield].PropertyOrColumnName)).Value:= GetPropValue(TObject(self),FModelReflection[ifield].PropertyOrColumnName);
            end;
             else
               qrDestination.FieldValues[FModelReflection[ifield].PropertyOrColumnName] := GetPropValue(TObject(self),FModelReflection[ifield].PropertyOrColumnName,True);
          end;


        except
          on e:exception do
          begin
            FDataManager.AddLogBusinessRule(codSFillDatasetErrorInField,
                                            format(SFillDatasetErrorInField,[FModelReflection[ifield].PropertyOrColumnName,GetPropValue(TObject(self),FModelReflection[ifield].PropertyOrColumnName,True)])
                                            +#13#10+'* '+e.Message,
                                            sbrWarning);
            continue;
          end;
        end;
      end;
      if qrDestination.state in [dsEdit,dsInsert]
        then begin
               qrDestination.Post;
               //FDataManager.AddLogBusinessRule(codSFillDatasetOK,
               //                                format(SFillDatasetOK,[ClassModelName]),
               //                                sbrWarning);
             end;
    except
      on e:exception do
        FDataManager.AddLogBusinessRule(codSFillDatasetErrorInGeneral,
                                        format(SFillDatasetErrorInGeneral,[ClassModelName])
                                        +#13#10+'* '+e.Message,
                                        sbrError);
    end;
  end;
end;

function TDPSAbstractModel.get(ident: String;externalDataSet:TClientDataSet):IDataModel;
var
  qrGet:TZQuery;
  sql  :String;
begin
  if (trim(ident) = '') or (trim(ident) = '-1')
    then sql := format('select * from %s where %s = -1',[TableName,KeyFieldName])
    else sql := format('select * from %s where %s = %s',[TableName,KeyFieldName,ident]);

  if (Trim(KeyFieldName) <> '')
  then begin
         qrGet := Datamanager.getTempQuery(sql);
         try
          if not (qrGet.IsEmpty) or (externalDataSet <> nil) then
            Result := New(Datamanager,qrGet)
          else
            Result := nil;

          configureExternalDataset(externalDataSet);
          if Result <> nil then
            Result.fillDataset(externalDataSet);

         finally
           qrGet.Connection.free;
           FreeAndNil(qrGet);
         end;
       end;
end;


function TDPSAbstractModel.getClassModelName: String;
begin
  FClassModelName := ClassName;
  Result := FClassModelName;
end;

function TDPSAbstractModel.getCountErrors: Int64;
begin
  Result := FDatamanager.CountErrors;
end;

function TDPSAbstractModel.getCountHints: Int64;
begin
  Result := FDatamanager.getCountHints;
end;

function TDPSAbstractModel.getCountWarnings: Int64;
begin
  Result := FDatamanager.getCountWarnings;
end;

function TDPSAbstractModel.getDataManager:IDataManager;
begin
  Result := FDatamanager;
end;

function TDPSAbstractModel.getDataManagerClass: IDataManagerClass;
begin
  Result := FDatamanagerClass;
end;

function TDPSAbstractModel.getTableName: String;
begin
  FTableName := ClassName;
  if SameText(FTableName[1],'T') then
    FTableName := copy(FTableName,2,length(FTableName)-1);
  Result := FTableName;
end;

function TDPSAbstractModel.getTokenizer: String;
begin
  Result := FTokenizer;
end;

procedure TDPSAbstractModel.configureExternalDataset(extDataSet: TClientDataSet);
var
  ifield:integer;
begin

  if (extDataSet <> nil) and (extDataSet.IsEmpty) then
  begin
    extDataSet.FieldDefs.Clear;
    extDataSet.IndexDefs.Clear;

    for ifield :=0 to Length(FModelReflection) -1 do
    begin
       try
         case FModelReflection[iField].BasicTypeKind of
           tkInteger,tkEnumeration: extDataSet.FieldDefs.Add(FModelReflection[iField].PropertyOrColumnName,ftInteger);
           tkInt64:    extDataSet.FieldDefs.Add(FModelReflection[iField].PropertyOrColumnName,ftLargeint);
           tkFloat:begin
                     if FModelReflection[iField].DataSize = -1 then
                       extDataSet.FieldDefs.Add(FModelReflection[iField].PropertyOrColumnName,ftDate)
                     else if FModelReflection[iField].DataSize = -2 then
                       extDataSet.FieldDefs.Add(FModelReflection[iField].PropertyOrColumnName,ftTime)
                     else if FModelReflection[iField].DataSize = -3 then
                       extDataSet.FieldDefs.Add(FModelReflection[iField].PropertyOrColumnName,ftDateTime)
                     else
                       extDataSet.FieldDefs.Add(FModelReflection[iField].PropertyOrColumnName,ftCurrency);
                   end;
           tkChar,
           tkString,
           tkWChar,
           tkUString,
           tkLString,
           tkWString:extDataSet.FieldDefs.Add(FModelReflection[iField].PropertyOrColumnName,ftString,FModelReflection[iField].DataSize);
           tkDynArray:extDataSet.FieldDefs.Add(FModelReflection[iField].PropertyOrColumnName,ftBlob);
         end;
       extDataSet.FieldDefs[ifield].DisplayName  := FModelReflection[iField].PropertyOrColumnDescript;
       except
         on e:exception do
           begin
             Datamanager.AddLogBusinessRule(codSErrorOnConfigureExternalDataset,
                                            format(SErrorOnConfigureExternalDataset,[ClassModelName])+#13#10+e.Message,
                                            sbrError);
             continue;
           end;
       end;
    end;
    extDataSet.CreateDataSet;
//    Datamanager.AddLogBusinessRule(codSOnConfigureExternalDatasetOK,
//                                   format(SOnConfigureExternalDatasetOK,[ClassModelName]),
//                                   sbrWarning);

  end;
end;

constructor TDPSAbstractModel.Create(dmgr:IDataManager);
begin
  FDatamanager   := dmgr;
  FModelState    := msInsert;
  SetLength(FModelReflection,0);
  SetLength(FModelDynamicTypes,0);
  SetLength(FModelReflection,0);
  SetLength(FIndexes,0);
  SetLength(FPrimaryKeys,0);
  SetLength(FForeignKeys,0);
  SetLength(FUniqueKeys,0);
  SetupModelReflection;
end;

function TDPSAbstractModel.save: Boolean;
var
  sql : string;
  qr_save  : TZQuery;
  i:integer;
begin
  (* regra geral: só pode salvar se não houver logs de erros registrados no datamanager *)
  Result := false;

  sql := format('select * from %s where (%s = %s) ',[TableName,KeyFieldName,QuotedStr(GetPropValue(self,KeyFieldName,False))]);
  qr_save := Datamanager.getTempQuery(sql);
  try
    try
      if qr_save.IsEmpty
        then qr_save.Insert
        else qr_save.Edit;

      if  (qr_save.State in [dsInsert])
      and (InheritsFrom(TDPSStandardModel)) then
        begin
          if (trim(GetPropValue(self,'id',true)) = '-1')
            then SetPropValue(self,'id',IntToStr(GenerateNewID));
          SetPropValue(self,'guid',Token);
        end;

      for i := 0 to qr_save.FieldCount-1 do
       begin
          try
              if qr_save.Fields[i].IsBlob
                then
                  begin
                    if Length(GetPropValue(TObject(self),qr_save.Fields[i].FieldName)) > 0
                      then
                        TBlobField(qr_save.FieldByName(qr_save.Fields[i].FieldName)).Value:= GetPropValue(TObject(self),qr_save.Fields[i].FieldName);
                  end
                else
                  qr_save.FieldValues[qr_save.Fields[i].FieldName] := GetPropValue(self,qr_save.Fields[i].FieldName);
          except
             on e:exception do
               Datamanager.AddLogBusinessRule(codSErrorOnSetPropertiesToDatasetFields,
                                              format(SErrorOnSetPropertiesToDatasetFields,[qr_save.Fields[i].FieldName,GetPropValue(self,qr_save.Fields[i].FieldName,True)])
                                              +#13#10+e.Message,
                                              sbrError);
          end;
       end;

      if CountErrors > 0 then
        begin
          Datamanager.AddLogBusinessRule(codSErrorOnValidateRules,SErrorOnValidateRules,sbrError);
          exit;
        end;

      qr_save.Post;
      Result := True;
      Datamanager.AddLogBusinessRule(codSWarningSaveRecordSuccess,
                                     Format(SWarningSaveRecordSuccess,[GetPropValue(self,KeyFieldName,True)])+#13#10+sql,
                                     sbrWarning);
    except
       on e:exception do
         Datamanager.AddLogBusinessRule(codSErrorOnSaveModel,
                                        Format(SErrorOnSaveModel,[GetPropValue(self,KeyFieldName,True)])+#13#10+e.Message,
                                        sbrError);
    end;
  finally
    qr_save.Connection.free;
    qr_save.free;
  end;
end;

function TDPSAbstractModel.saveList(AListDataModel: TObjectList): Int64;
var
  sql : string;
  qr_save  : TZQuery;
  i,j:integer;
begin
  Result := 0;

  if CountErrors > 0
    then exit;

  sql := format('select * from %s where (0=0) ',[TableName,KeyFieldName,KeyFieldName]);

  qr_save  := Datamanager.getTempQuery(sql);
  try
    for i:=0 to AListDataModel.Count -1 do
      begin
        try
          qr_save.Insert;

          if  (qr_save.State in [dsInsert])
          and (AListDataModel[i].InheritsFrom(TDPSStandardModel)) then
            begin
              if (trim(GetPropValue(AListDataModel[i],KeyFieldName,false)) = '-1')
                then SetPropValue(AListDataModel[i],KeyFieldName,IntToStr(GenerateNewID));
            end;

          for j := 0 to qr_save.FieldCount-1 do
            qr_save.FieldValues[qr_save.Fields[j].FieldName] := GetPropValue(AListDataModel[i],qr_save.Fields[j].FieldName,False);

          qr_save.post;
          Result := Result+1;
        except
          continue;
        end;
      end;
  finally
     qr_save.Connection.Free;
     qr_save.Free;
  end;
end;

procedure TDPSAbstractModel.setClassModelname(const Value: String);
begin
  FClassModelName := Value;
end;

procedure TDPSAbstractModel.setDatamanagerClass(  const Value: IDataManagerClass);
begin
  FDatamanagerClass := Value;
end;

procedure TDPSAbstractModel.setKeyFieldAutoGenerated(const Value: Boolean);
begin
  FKeyFieldAutoGenerated := Value;
end;

procedure TDPSAbstractModel.setKeyFieldName(const Value: string);
var
  i:integer;
begin
  FKeyFieldName := Value;
  if (trim(Value) <> '') and (length(FModelReflection) > 0) then
    for i:=0 to length(FModelReflection)-1 do
    begin
      if SameText(Value,FModelReflection[i].PropertyOrColumnName) then
      begin
        FModelReflection[i].PrimaryKey  := True;
        FModelReflection[i].AutoInc     := True;
        FModelReflection[i].AcceptsNull := False;
      end;
    end;
end;

procedure TDPSAbstractModel.setModelState(const Value: TModelState);
begin
  FModelState := Value;
end;

procedure TDPSAbstractModel.setTableName(const Value: String);
begin
  FTableName := Value;
end;

procedure TDPSAbstractModel.setTokenizer(const Value: string);
begin
  FTokenizer := Value;
end;

(*
  A Variável DataSize e DataSizeScale na criação de uma TDataReflection
  por defaut é superior ao máximo de um inteiro ou ao mínimo de um
  inteiro negativo.

  * aparentemente há uma alternancia no sinal das instâncias.

  Como após este valor esta rotina deve retorna um Int64, ou seja,
  o mesmo que default  = 0 , então atribuo o valor 0, desta forma o tratamento
  da rotina irá atribuir o tipo devido, quando o programador estiver passando
  um TTypeDataReflection correto.

  No caso de tratamento de tipo para string, qualquer valor acima de 255 já
  poderia voltar para o valor default 0, mas este código já resolve o problema
  de Instâncias com valor não assinalado.

   4294967295 = Maior valor para um cardinal
  -2147483648 = Menor valor para um Inteiro, acima disso é Int64.
  * curioso,o help do Delphi informa este valor como limite de um Integer,
  mas vc recebe um erro de conversão ao tentar verificar se o valor é superior
  ex:
     if (VariavelInt64 < -2147483648) then ....
  Resolvido: utilizando a função Low(Integer);

  ! Atenção

  as principais propriedades na hora de fazer uma conversão:

  DataSize
  NativeType
  BasicTypeKind

  Quando procurar por erros dê atenção especial aos valores destas propriedades
  para os tipos conhecidos o método SetDefaults deverá assinalar os valores.
*)
procedure TAbstractDataManager.ConvertDataType(var dtReflection :TDataReflection);
begin
  dtReflection.TypeReflection    := ReflectionType;
  dtReflection.TypeDatabase      := FTypeDatabase;

  if trim(dtReflection.OriginalDataTypeName) = '' then
    dtReflection.OriginalDataTypeName := dtReflection.DataTypeName;

  if (dtReflection.DataSize < Low(Integer))
  or (dtReflection.DataSize > High(Cardinal)) then
    dtReflection.DataSize   := 0;

  if (dtReflection.DataSizeScale < Low(Integer))
  or (dtReflection.DataSizeScale > High(Cardinal)) then
    dtReflection.DataSizeScale   := 0;

  if dtReflection.NativeType = ntUnknow then
    dtReflection.NativeType  := ValidateNativeTypeByName(dtReflection.DataTypeName);

  if DelphiTypeNameToDelphiTypeKind(dtReflection.OriginalDataTypeName) <> tkUnknown then
    dtReflection.BasicTypeKind := DelphiTypeNameToDelphiTypeKind(dtReflection.OriginalDataTypeName);

  case dtReflection.TypeReflection of
    trDelphiToDatabase:
    begin
      ConvertStringAndSetToDatabase(dtReflection);
      ConvertClassToDatabase(dtReflection);
      ConvertEnumerationToDatabase(dtReflection);
      ConvertFloatToDatabase(dtReflection);
      ConvertIntegerToDatabase(dtReflection);
      (* convenção *)
      dtReflection.FullNameDatabaseType := UpperCase(dtReflection.FullNameDatabaseType);
      dtReflection.DataTypeName         := UpperCase(dtReflection.DataTypeName);
    end;

    trDatabaseToDelphi:
    begin
      dtReflection.ClassOrTableName := Format('T%s',[dtReflection.ClassOrTableName]);
      ConvertStringAndSetToDelphi(dtReflection);
      ConvertClassToDelphi(dtReflection);
      ConvertEnumerationToDelphi(dtReflection);
      ConvertFloatToDelphi(dtReflection);
      ConvertIntegerToDelphi(dtReflection);
    end;
  end;
end;

function TAbstractDataManager.SetupIndex(modelIndex:TIndex):Integer;
var
  i :Integer;
begin
  Result := -1;
  for i:= 0 to Length(FmdIndexes)-1 do
    if SameText(FmdIndexes[i].IndexName,modelIndex.IndexName) then
      Result := i;

  if (Result = -1) then
  begin
    Result := Length(FmdIndexes);
    SetLength(FmdIndexes,(Length(FmdIndexes)+1));
  end;

  with FmdIndexes[Result] do
  begin
    IndexName := modelIndex.IndexName;
    TableName := modelIndex.TableName;
    SetLength(Fields,length(modelIndex.Fields));
    for i:=0 to length(modelIndex.Fields)-1 do
      Fields[i] := modelIndex.Fields[i];
    Unique    := modelIndex.Unique;
    DescOrd   := modelIndex.DescOrd
  end;
end;

function TAbstractDataManager.SetupPrimaryKey(pmKey:TConstraintPrimaryKey):Integer;
var
  i,j :Integer;
begin
  Result := -1;
  for i:=0 to Length(FmdPrimaryKeys)-1 do
    if SameText(FmdPrimaryKeys[i].PrimaryKeyName,pmKey.PrimaryKeyName) then
      Result := i;

  if (Result = -1) then
  begin
    Result := Length(FmdPrimaryKeys);
    SetLength(FmdPrimaryKeys,(Length(FmdPrimaryKeys)+1));
  end;

  with FmdPrimaryKeys[Result] do
  begin
    PrimaryKeyName         := pmKey.PrimaryKeyName;
    PrimaryKeyTable        := pmKey.PrimaryKeyTable;
    PrimaryKeyField        := pmKey.PrimaryKeyField;

    for i:=0 to Length(FTableReflections)-1 do
    begin
      for j:=0 to Length(FTableReflections[i])-1 do
        if SameText(TableReflections[i][j].PropertyOrColumnName,pmKey.PrimaryKeyField) then
          begin
            TableReflections[i][j].AutoInc     := True;
            TableReflections[i][j].PrimaryKey  := True;
            TableReflections[i][j].AcceptsNull := False;
          end;
    end;
  end;
end;

function TAbstractDataManager.SetupForeignKey(fhKey:TConstraintForeignKey):Integer;
var
  i,j :Integer;
begin
  Result := -1;
  for i:=0 to Length(FmdForeignKeys)-1 do
    if SameText(FmdForeignKeys[i].ForeignKeyName,fhKey.ForeignKeyName) then
      Result := i;

  if (Result = -1) then
  begin
    Result := Length(FmdForeignKeys);
    SetLength(FmdForeignKeys,Length(FmdForeignKeys)+1);
  end;

  with FmdForeignKeys[Result] do
  begin
    ForeignKeyName         := fhKey.ForeignKeyName;
    ForeignKeyTable        := fhKey.ForeignKeyTable;
    ForeignKeyTargetTable  := fhKey.ForeignKeyTargetTable;
    IndexName              := fhKey.IndexName;
    RuleOnUpdate           := fhKey.RuleOnUpdate;
    RuleOnDelete           := fhKey.RuleOnDelete;

    SetLength(LocalFields,length(fhKey.LocalFields));
    for j:=0 to length(fhKey.LocalFields)-1 do
      LocalFields[j] := fhKey.LocalFields[j];

    SetLength(TargetFields,length(fhKey.TargetFields));
    for j:=0 to length(fhKey.TargetFields)-1 do
      TargetFields[j] := fhKey.TargetFields[j];
  end;
end;

function TAbstractDataManager.SetupUniqueKey(unKey:TConstraintUniqueKey):Integer;
var
  i,j :Integer;
begin
  Result := -1;
  for i:=0 to Length(FmdUniqueKeys)-1 do
    if SameText(FmdUniqueKeys[i].UniqueKeyName,unKey.UniqueKeyName) then
      Result := i;

  if (Result = -1) then
  begin
    Result := Length(FmdUniqueKeys);
    SetLength(FmdUniqueKeys,Length(FmdUniqueKeys)+1);
  end;

  with FmdUniqueKeys[Result] do
  begin
    UniqueKeyName        := unKey.UniqueKeyName;
    UniqueKeyTable       := unKey.UniqueKeyTable;

    SetLength(LocalFields,length(unKey.LocalFields));
    for j:=0 to length(unKey.LocalFields)-1 do
      LocalFields[j] := unKey.LocalFields[j];
  end;
end;


procedure TAbstractDataManager.setVersionCoreDB(const Value: Int64);
begin
  FVersionCoreDB := Value;
end;

procedure TAbstractDataManager.setVersionDatabase(const Value: Int64);
begin
  FVersionDatabase := Value;
end;

procedure TAbstractDataManager.ResetLogBusinessRule;
begin
  FLogs.Clear;
  FCountErrors   := 0;
  FCountWarnings := 0;
  FCountHints    := 0;
  SetLength(FBusinessRules,0);
end;

(*
    Quando a tabela não tem chave primária esta rotina traz todos os campos.

    Nesta rotina vamos retornar apenas o primeiro resultado SEMPRE.
    fará parte das  "regras" que o programador deve
    definir esta propriedade, de preferência no construtor da classe
    assim como os constraints.
*)

function TAbstractDataManager.getTableKeyFieldFromDatabase(sTable: String): String;
var
  mdBestrowId :IZDatabaseMetadata;
  rsetBestID  :IZResultSet;
begin
  Result   := '';
  mdBestrowId := getconnection.GetMetadata;
  rsetBestID  := mdBestrowId.GetBestRowIdentifier('','',sTable,0,False);// scope,nullable default em TZSqlMetadata implementation
  if rsetBestID.Next then
    Result := rsetBestID.GetStringByName('COLUMN_NAME');
end;

function TAbstractDataManager.getTableReflections: TTableReflections;
begin
  Result := FTableReflections;
end;

function TAbstractDataManager.OwnTypeExists(OwnTypeName:String):Boolean;
var
  sql_qr_types : string;
  rset_types : IZResultSet;
begin
  Result := False;
  case TypeDatabase of
    tdbFirebird : sql_qr_types := ' select fn.rdb$field_name from rdb$fields fn'
                                 +' where  upper(fn.rdb$field_name) = upper('+QuotedStr(OwnTypeName)+');';
    tdbPostgreSQL:sql_qr_types := '';
    tdbSQLite3:sql_qr_types    := '';
  end;

  rset_types := getConnection.CreateStatement.ExecuteQuery(sql_qr_types);
  result := rset_types.next;
  rset_types.Close;
end;


function TAbstractDataManager.TableExists(TableName:String):boolean;
var
  rset_tables :IZResultSet;
  sql_qr_table_exists:string;
begin
  case TypeDatabase of
    tdbFirebird: sql_qr_table_exists := 'select rdb$relation_name from rdb$relations'
                                       +' where rdb$view_blr is null and upper(rdb$relation_name)'
                                       +' =upper('+QuotedStr(trim(TableName))+')';

    tdbPostgreSQL:sql_qr_table_exists:= 'select tablename from pg_tables where upper(tablename)'
                                       +'=upper('+QuotedStr(trim(TableName))+')';

    tdbSQLite3: sql_qr_table_exists  := 'select * from sqlite_master where upper(tbl_name)'
                                       +' = upper('+QuotedStr(trim(TableName))+')';
  end;

  rset_tables := getConnection.CreateStatement.ExecuteQuery(sql_qr_table_exists);
  result := rset_tables.Next;
  rset_tables.Close;
end;

function TAbstractDataManager.FieldInTableExists(TableName:String;FieldName:String):boolean;
var
    sql_qr_field_exist:string;
    rset_field :IZResultSet;
begin
  case FTypeDatabase of
    tdbFirebird:   sql_qr_field_exist :=' select rf.rdb$relation_name,rf.rdb$field_name'
                                       +' from rdb$fields f  join rdb$relation_fields rf'
                                       +' on rf.rdb$field_source = f.rdb$field_name'
                                       +' where upper(rf.rdb$relation_name) = upper('+QuotedStr(TableName)+')'
                                       +' and upper(rf.rdb$field_name) = upper('+QuotedStr(FieldName)+')';
    tdbPostgreSql: sql_qr_field_exist :='';
    tdbSQLite3:    sql_qr_field_exist :='';
  end;
  rset_field := getConnection.CreateStatement.ExecuteQuery(sql_qr_field_exist);
  Result := rset_field.Next;
  rset_field.Close;
end;


function TAbstractDataManager.IndexExists(indexName:String):boolean;
var
  rset_index:IZResultSet;
  sql_index :string;
begin
  case TypeDatabase of
    tdbFirebird : sql_index := 'select rdb$index_name from rdb$indices'
                               +' where upper(RDB$INDEX_NAME)=upper('+quotedStr(indexName)+')';
    tdbPostgreSQL:;
    tdbSQLite3:;
  end;
  rset_index := getConnection.CreateStatement.ExecuteQuery(sql_index);
  Result := rset_index.Next;
  rset_index.Close;
end;


(*  same for pk,fk,uk *)
function  TAbstractDataManager.ConstraintExists(ConstraintName:String):boolean;
var
  sql_constraint:string;
  rset_constraint :IZResultSet;
begin
  case FTypeDatabase of
    tdbFirebird: sql_constraint := 'select distinct rc.rdb$constraint_name'
                                  +' from rdb$relation_constraints rc'
                                  +' where upper(rdb$constraint_name) = upper('
                                  +QuotedStr(ConstraintName)+')';
    tdbPostgreSQL:;
    tdbSQLite3:;
  end;
  rset_constraint := getConnection.CreateStatement.ExecuteQuery(sql_constraint);
  Result := rset_constraint.Next;
  rset_constraint.Close;
end;


function TAbstractDataManager.GeneratorExists(generatorName: String): boolean;
var
  sql :string;
  rset :IZResultSet;
begin
  result := false;
  case FTypeDatabase of
    tdbFirebird:
    begin
      sql := format('SELECT RDB$GENERATOR_NAME FROM RDB$GENERATORS WHERE UPPER(RDB$GENERATOR_NAME) = %s',[QuotedStr(UpperCase(generatorName))]);
      rset := getconnection.createStatement.ExecuteQuery(sql);
      Result := rset.Next;
    end;
  end;
end;


procedure TAbstractDataManager.GenerateScriptOwnTypes;
var
  i,j:Integer;
  command :string;
begin
  command := '';
  for i:=0 to Length(FDmReflections)-1 do
  begin
    if (FDmReflections[i].DataTypeName <> '') then
    begin
      ConvertDataType(FDmReflections[i]);
      if  (FDMReflections[i].NativeType in [ntUnknow])
      and not (OwnTypeExists(FDmReflections[i].DataTypeName))
      then
      begin
        command := Format('  create domain %s as %s',[FDmReflections[i].DataTypeName,
                                                      FDmReflections[i].FullNameDatabaseType]);
        if (trim(FDmReflections[i].DefaultValue) <> '') then
          command := Format('%s default %s ',[command,FDmReflections[i].DefaultValue]);

        if (FDmReflections[i].DatabaseCheck <> nil) then
          for j:=0 to Length(FDmReflections[i].DatabaseCheck)-1 do
          begin
            (* enumeracoes serão inteiros, só terão um check sobre o range permitido *)
            if  (j < Length(FDmReflections[i].DatabaseCheck[j]))
            and (FDmReflections[i].BasicTypeKind <> tkEnumeration) then
              command := Format('%s check %s or',[command,FDmReflections[i].DatabaseCheck[j]])
            else
              command := Format('%s check %s ',[command,FDmReflections[i].DatabaseCheck[j]]);
          end;
          command := format('%s;',[command]);
          ExecuteScript(command);
      end;
    end;
  end;
end;

procedure TAbstractDataManager.GenerateScriptConstraintsPrimaryKey;
var
  i:Integer;
  command_sql :string;
begin
  ReflectionType := trDelphiToDatabase;
  for i := 0 to Length(FmdPrimaryKeys)-1 do
  begin
    command_sql := '';
    if not ConstraintExists(FmdPrimaryKeys[i].PrimaryKeyName)
    then begin
           command_sql := format('alter table %s add constraint %s primary key(%s);',
                                 [FmdPrimaryKeys[i].PrimaryKeyTable,
                                  FmdPrimaryKeys[i].PrimaryKeyName,
                                  FmdPrimaryKeys[i].PrimaryKeyField]);
           ExecuteScript(command_sql);
         end;
  end;
end;

procedure TAbstractDataManager.GenerateScriptConstraintsForeignKey;
var
  i,j:Integer;
  command_sql :string;
begin
  ReflectionType := trDelphiToDatabase;
  for i := 0 to Length(FmdForeignKeys)-1 do
  begin
    if not ConstraintExists(FmdForeignKeys[i].ForeignKeyName) then
    begin
      command_sql := format('alter table %s add constraint %s foreign key (',
                            [FmdForeignKeys[i].ForeignKeyTable,FmdForeignKeys[i].ForeignKeyName]);

      for j:=0 to length(FmdForeignKeys[i].LocalFields)-1 do
        if j < length(FmdForeignKeys[i].LocalFields)-1 then
          command_sql := format('%s%s,',[command_sql,FMdForeignKeys[i].LocalFields[j]])
        else
          command_sql := format('%s%s) references %s (',[command_sql,FmdForeignKeys[i].LocalFields[j],
                                                         FmdForeignKeys[i].ForeignKeyTargetTable]);

      for j:=0 to length(FmdForeignKeys[i].TargetFields)-1 do
        if j < length(FmdForeignKeys[i].TargetFields)-1 then
          command_sql := format('%s%s,',[command_sql,FmdForeignKeys[i].TargetFields[j]])
        else
          command_sql := format('%s%s)',[command_sql,FmdForeignKeys[i].TargetFields[j]]);

      if trim(FmdForeignKeys[i].IndexName) <> '' then
      begin
        if FmdForeignKeys[i].IndexDescOrd then
          command_sql := format('%s using desc index %s',[command_sql,FmdForeignKeys[i].IndexName])
        else
          command_sql := format('%s using index %s',[command_sql,FmdForeignKeys[i].IndexName]);
      end;
      command_sql := format('%s;',[command_sql]);
      ExecuteScript(command_sql);
    end;
  end;
end;

procedure TAbstractDataManager.GenerateScriptConstraintsUniqueKey;
var
  i,j:Integer;
  command_sql :string;
begin
  ReflectionType := trDelphiToDatabase;
  for i := 0 to Length(FMdUniqueKeys)-1 do
  begin
    if not ConstraintExists(FMdUniqueKeys[i].UniqueKeyName) then
    begin
      command_sql := format('  alter table %s add constraint %s',
                            [FMdUniqueKeys[i].UniqueKeyTable,FmdUniqueKeys[i].UniqueKeyName]);
      command_sql := format('%s unique (',[command_sql]);
      for j:=0 to length(FmdUniqueKeys[i].LocalFields)-1 do
        if j < length(FmdUniqueKeys[i].LocalFields)-1 then
          command_sql := format('%s%s,',[command_sql,FmdUniqueKeys[i].LocalFields[j]])
        else
          command_sql := format('%s%s)',[command_sql,FmdUniqueKeys[i].LocalFields[j]]);
      ExecuteScript(format('%s;',[command_sql]));
    end;
  end;
end;

procedure TAbstractDataManager.GenerateScriptIndexs;
var
  i,j:Integer;
  command_sql :string;
begin
  ReflectionType := trDelphiToDatabase;
  for i:=0 to Length(TableReflections)-1 do
    for j:=0 to Length(TableReflections[i])-1 do
      ConvertDataType(TableReflections[i][j]);

  for i:=0 to Length(fmdIndexes)-1 do
  begin
    if not( IndexExists(FmdIndexes[i].IndexName) ) then
    begin
      command_sql := 'create';
      if FmdIndexes[i].Unique then
        command_sql := format('%s unique',[command_sql]);

      if FmdIndexes[i].DescOrd then
        command_sql := format('%s desc',[command_sql]);

      command_sql := format('%s index %s on %s (',[command_sql,FmdIndexes[i].IndexName,FmdIndexes[i].TableName]);

      for j:=0 to length(FmdIndexes[i].Fields)-1 do
        if j < length(FmdIndexes[i].Fields)-1 then
          command_sql := format(command_sql+'%s, ',[FmdIndexes[i].Fields[j]])
        else
          command_sql := format(command_sql+'%s); ',[FmdIndexes[i].Fields[j]]);
      ExecuteScript(command_sql);
    end;
  end;
end;

procedure TAbstractDataManager.ExecuteScript(temp_script: String);
begin
  try
    getConnection.CreateStatement.Execute(temp_script)
  except
    on e:exception do
    if FMonitor.Active then
    begin
      with TStringList.Create do
      begin
        try
          if FileExists(FMonitor.FileName)
            then LoadFromFile(FMonitor.FileName);
          Add(FormatDateTime('hh:mm:ss dd/mm/yyyy "["dddd d "de" mmmm"]"',now));
          Add('---------------------------------------------------');
          Add('comando: '+temp_script);
          Add('   erro: '+e.Message);
          Add('---------------------------------------------------');
          SaveToFile(FMonitor.FileName);
        finally
          free;
        end;
      end;
    end;
  end;
end;

procedure TAbstractDataManager.GenerateScriptTables;
var
  i,j:Integer;
  scr_tabela:TStringList;
  tabName,dbTypename,notNull,primaryKey:string;
begin
  ReflectionType := trDelphiToDatabase;
  scr_tabela     := TStringList.create;
  try
    for i:=0 to Length(FTableReflections)-1 do
    begin
      (* criação das tabela *)
      tabName := FTableReflections[i][0].ClassOrTableName;

      for j:=0 to Length(FTableReflections[i])-1 do
        ConvertDataType(FTableReflections[i][j]);

      scr_tabela.Clear;
      if not (TableExists(tabName)) then
      begin
        scr_tabela.Add(format('  create table %s (',[tabName]));
        for j:=0 to Length(TableReflections[i])-1 do
        begin
          notNull := '';
          primaryKey := '';

          if TableReflections[i][j].NativeType in [ntUnknow] then
            dbTypename := TableReflections[i][j].DataTypeName
          else
            dbTypename := TableReflections[i][j].FullNameDatabaseType;

          if not (TableReflections[i][j].AcceptsNull) then
            notNull := 'not null';

          if j < Length(TableReflections[i])-1 then
            scr_tabela.add(format('  %s %s %s %s,',[TableReflections[i][j].PropertyOrColumnName
                                             ,dbTypename
                                             ,notNull
                                             ,primaryKey]))
          else
            scr_tabela.add(format('  %s %s %s %s);',[TableReflections[i][j].PropertyOrColumnName
                                              ,dbTypename
                                              ,notNull
                                              ,primaryKey]));
        end;
        ExecuteScript(scr_tabela.Text);
      end
        else
          begin
            (* atualização da tabela *)
            for j:=0 to Length(TableReflections[i])-1 do
              begin
                if not (FieldInTableExists(tabName,TableReflections[i][j].PropertyOrColumnName)) then
                  begin
                    notNull := '';
                    if not (TableReflections[i][j].AcceptsNull) then
                      notNull := 'not null';
                    if TableReflections[i][j].NativeType in [ntUnknow] then
                      dbTypename := TableReflections[i][j].DataTypeName
                    else
                      dbTypename := TableReflections[i][j].FullNameDatabaseType;
                    scr_tabela.Add(format('  alter table %s add %s %s ;',[tabName,
                                                                          TableReflections[i][j].PropertyOrColumnName
                                                                         ,dbTypename]));
                    ExecuteScript(scr_tabela.Text);
                  end;
              end;
          end;
      end;
  finally
    scr_tabela.Free;
  end;
end;

procedure TAbstractDataManager.UpdateStructureDatabase(NewVersion:Integer);
begin
  FNewVersionDB  := NewVersion;
  ReflectionType := trDelphiToDatabase;
  CreateDatabase;
end;

procedure TAbstractDataManager.AddLogBusinessRule(ruleCode: String; fmtMessageRule: String;tpRule: TTypeBusinessRule);
var
  x:Integer;
  tpsStr:string;
begin
  SetLength(FBusinessRules,1+length(FBusinessRules));
  x := Length(FBusinessRules)-1;

  FBusinessRules[x].CodeRule            := ruleCode;
  FBusinessRules[x].FormatedRuleMessage := fmtMessageRule;
  FBusinessRules[x].TypeRule            := tpRule;

  case tpRule of
    sbrError   : FCountErrors   := FCountErrors   + 1;
    sbrHint    : FCountHints    := FCountHints    + 1;
    sbrWarning : FCountWarnings := FCountWarnings + 1;
  end;

  case tpRule of
    sbrError    : tpsStr := 'Erro';
    sbrHint     : tpsStr := 'Dica.';
    sbrWarning  : tpsStr := 'Aviso';
  end;

  FLogs.Add( format('[%s] [%s] %s',[tpsStr,ruleCode,fmtMessageRule]) );
end;


function TDPSAbstractModel.SetupDynamicType(TypeInfo:PTypeInfo;friendlyValues:array of String):Integer;
var
  T:PTypeData;
  i:integer;
begin
  Result := -1;
  if TypeInfo^.Kind = tkEnumeration  then
  begin
    for i:=0 to length(FModelDynamicTypes)-1 do
      if SameText(TypeInfo.Name,FModelDynamicTypes[i].Name) then
        Result := i;

    (* registra o tipo dinamico, se não foi registrado ainda *)
    if Result = -1 then
    begin
      Result := length(FModelDynamicTypes);
      SetLength(FModelDynamicTypes,length(FModelDynamicTypes)+1);
    end;

    FModelDynamicTypes[Result].Name := TypeInfo.Name;
    T := GetTypeData(GetTypeData(TypeInfo)^.BaseType^);
    SetLength(FModelDynamicTypes[Result].DynamicValues,T^.MaxValue);
    (* tratamento especial para tipo boolean ... vide GetEnumName() * TypInfo.pas *)
    if SameText(TypeInfo.Name,'Boolean') then
    begin
      SetLength(FModelDynamicTypes[Result].DynamicValues,2);

      FModelDynamicTypes[Result].DynamicValues[0].Index                 := 0;
      FModelDynamicTypes[Result].DynamicValues[0].ValueAsString         := 'False';
      FModelDynamicTypes[Result].DynamicValues[0].FriedlyValueAsString  := 'False';

      if (length(friendlyValues)> 0 ) then
        FModelDynamicTypes[Result].DynamicValues[0].FriedlyValueAsString := friendlyValues[0];

      FModelDynamicTypes[Result].DynamicValues[1].Index                 := 1;
      FModelDynamicTypes[Result].DynamicValues[1].ValueAsString         := 'True';
      FModelDynamicTypes[Result].DynamicValues[1].FriedlyValueAsString  := 'True';

      if (length(friendlyValues)> 1 ) then
        FModelDynamicTypes[Result].DynamicValues[1].FriedlyValueAsString := friendlyValues[1];
    end
    else
      begin
        SetLength(FModelDynamicTypes[Result].DynamicValues,T^.MaxValue+1);
        for i := T^.MinValue to T^.MaxValue do
          begin
            FModelDynamicTypes[Result].DynamicValues[i].Index                 := i;
            FModelDynamicTypes[Result].DynamicValues[i].ValueAsString         := GetEnumName(TypeInfo,i);
            FModelDynamicTypes[Result].DynamicValues[i].FriedlyValueAsString  := GetEnumName(TypeInfo,i);
          end;
      end;
    if Datamanager <> nil then
      Datamanager.SetupDynamicType(FModelDynamicTypes[Result]);
  end;
end;

function TDPSAbstractModel.SetupReflection(dataTypeName:String;
                                           typeKind:TTypeKind;
                                           frdValues:array of String;
                                           size:Int64=0;
                                           precision:Int64=0;
                                           defaultValue:string='';
                                           ntNativeType:TNativeType=ntUnknow;
                                           alowNull:Boolean= True):Integer;
var
  i,j: integer;
begin
  Result := -1;
  if (trim(dataTypeName)='') then  exit;

  for i:=0 to Length(FModelReflection)-1 do
    if  (SameText(FModelReflection[i].DataTypeName,dataTypeName)) then
      Result := i;

  if Result =-1 then
  begin
    Result := Length(FModelReflection);
    SetLength(FModelReflection,Length(FModelReflection)+1);
  end;

  if trim(FModelReflection[Result].OriginalDataTypeName) = '' then
    FModelReflection[Result].OriginalDataTypeName     := dataTypeName;

  FModelReflection[Result].DataTypeName             := dataTypeName;
  FModelReflection[Result].TypeDatabase             := TypeDatabase;   // do datamanager
  if Datamanager <> nil
  then begin
         FModelReflection[Result].VersionDB                := Datamanager.VersionDatabase;      // do datamanager
         FModelReflection[Result].VersionCoreDB            := Datamanager.VersionCoreDB;  // do datamanager
         FModelReflection[Result].DialectCoreDB            := Datamanager.DialectCoreDB;  // do datamanager
       end;
  FModelReflection[Result].TypeReflection           := trDelphiToDatabase;
  FModelReflection[Result].BasicTypeKind            := typeKind;
  FModelReflection[Result].AcceptsNull              := alowNull;
  FModelReflection[Result].AutoInc                  := FKeyFieldAutoGenerated;

  FModelReflection[Result].IndexDynamicType         := -1;
  if FModelReflection[Result].BasicTypeKind in [tkSet,tkEnumeration] then
  begin
    for j:=0 to length(FModelDynamicTypes)-1 do
      if SameText(FModelReflection[Result].DataTypeName,dataTypeName)then
        FModelReflection[Result].IndexDynamicType  := j;
  end;

  FModelReflection[Result].DataSize                 := size;
  FModelReflection[Result].DataSizeScale            := precision;
  FModelReflection[Result].DefaultValue             := defaultValue;
  FModelReflection[Result].NativeType               := ntNativeType;
  FModelReflection[Result].DisplayMask              := '';

  //FModelReflection[Result].ClassOrTableName         := '';
  //FModelReflection[Result].PropertyOrColumnName     := '';
  //FModelReflection[Result].PropertyOrColumnDescript := '';

  if Datamanager <> nil then
    Datamanager.SetupReflection(FModelReflection[Result]);
end;


procedure TDPSAbstractModel.SetupModelReflection;
var
  Count,i,j: Integer;
  List:TPropList;
begin
  (* só executa esta tarefa para classses descendentes *)
  if (InheritsFrom(TDPSAbstractModel)) and (ClassModelName <> '') then
  begin
    Count := GetPropList(self.ClassInfo,tkProperties,@List);
    for i:=0 to count-1 do
    begin
      (* 1 reflexo para cada propriedade do modelo *)
      SetLength(FModelReflection , length(FModelReflection)+1 );

      FModelReflection[i].TypeReflection            := trDelphiToDatabase;
      FModelReflection[i].ClassName                 := self.getClassModelName;
      FModelReflection[i].ClassOrTableName          := Self.getTableName;
      FModelReflection[i].PropertyOrColumnName      := List[i]^.Name;
      FModelReflection[i].PropertyOrColumnDescript  := List[i]^.Name;
      FModelReflection[i].DisplaySize               := 40; //default
      FModelReflection[i].DataTypeName              := List[i]^.PropType^.Name;
      FModelReflection[i].OriginalDataTypeName      := List[i]^.PropType^.Name;//p ñ perder referencia
      FModelReflection[i].BasicTypeKind             := List[i]^.PropType^.Kind;
      FModelReflection[i].DatabaseCheck             := nil;
      FModelReflection[i].FriendlyValues            := nil;
      FModelReflection[i].NativeType                := ntUnknow;

      if FDatamanager <> nil
      then begin
             FModelReflection[i].VersionDB          := Datamanager.VersionDatabase;
             FModelReflection[i].VersionCoreDB      := Datamanager.VersionCoreDB;
             FModelReflection[i].DialectCoreDB      := Datamanager.DialectCoreDB;
           end;

      FModelReflection[i].PrimaryKey            := False;
      FModelReflection[i].AcceptsNull           := True;
      FModelReflection[i].AutoInc               := FKeyFieldAutoGenerated;

      if (SameText(FModelReflection[i].PropertyOrColumnName,FKeyFieldName) ) then
      begin
        FModelReflection[i].PrimaryKey          := True;
        FModelReflection[i].AcceptsNull         := False;
      end;
      FModelReflection[i].IndexDynamicType      := -1;// default

      if (List[i]^.PropType^.Kind in [tkChar,tkWChar,tkLString,tkWString,tkString])
      and not(SameText(List[i]^.PropType^.Name,'Char'))
      and not(SameText(List[i]^.PropType^.Name,'AnsiChar'))
      and not(SameText(List[i]^.PropType^.Name,'WideChar'))
      and not(SameText(List[i]^.PropType^.Name,'String'))
      and not(SameText(List[i]^.PropType^.Name,'AnsiString'))
      and not(SameText(List[i]^.PropType^.Name,'WideString'))
      and not(SameText(List[i]^.PropType^.Name,'ShortString')) then
      begin
        FModelReflection[i].DataSize      := GetTypeData(List[i]^.PropType^).MaxLength;
        FModelReflection[i].DisplaySize   := GetTypeData(List[i]^.PropType^).MaxLength;
        FModelReflection[i].DataSizeScale := 0;
      end
      else
        if (List[i]^.PropType^.Kind in [tkInteger,tkInt64,tkSet,tkEnumeration]) then
        begin
          FModelReflection[i].DataSize      := GetTypeData(List[i]^.PropType^).MinValue;
          FModelReflection[i].DataSizeScale := GetTypeData(List[i]^.PropType^).MaxValue;
        end
        else
          if (List[i]^.PropType^.Kind in [tkfloat]) then
          begin
            if SameText(List[i]^.PropType^.Name,'TDate') then
              FModelReflection[i].DataSize    := -1
            else
              if SameText(List[i]^.PropType^.Name,'TTime') then
                FModelReflection[i].DataSize  := -2
              else
                if SameText(List[i]^.PropType^.Name,'TDateTime') then
                  FModelReflection[i].DataSize:= -3;
            FModelReflection[i].DataSizeScale := 0;
          end;

      case List[i]^.PropType^.Kind of
        tkEnumeration:
          FModelReflection[i].IndexDynamicType := SetupDynamicType(List[i]^.PropType^,[]);
      end;
      (* verifica se o datamanager possui as informações default do tipo atual *)
      SetDefaultsTypeReflection(FModelReflection[i],List[i]^.PropType^.Kind,FModelReflection);
      (* adiciona o novo tipo se ainda não tiver *)
      SetupReflection(FModelReflection[i].DataTypeName,
                      FModelReflection[i].BasicTypeKind,
                      FModelReflection[i].FriendlyValues,
                      FModelReflection[i].DataSize,
                      FModelReflection[i].DataSizeScale,
                      FModelReflection[i].DefaultValue,
                      FModelReflection[i].NativeType);

       (* atualiza os tipos no datamanager ... *)
       if FDatamanager <> nil then
         FDatamanager.SetupReflection(FModelReflection[i]);
    end;
    (* atualiza as tabelas tipos no datamanager ... *)
    if FDatamanager <> nil then
      FDatamanager.SetupTableReflection(FModelReflection);
  end;
end;

procedure TAbstractDataManager.CreateDatabase_Firebird;
var
  db:TZConnection;
begin
  if trim(getParam(dpsPATH)) = ''
    then
      AddLogBusinessRule(codSEDatabasePathNotSpecified,SEDatabasePathNotSpecified,sbrError)
    else
      begin
          db := TZConnection.Create(nil);
          try
            with db do
            begin
              Protocol               := trim(getParam(dpsZEOSDRIVER));
              ClientCodepage         := 'WIN1252';
              TransactIsolationLevel := tiReadCommitted;
              LibraryLocation        := 'fbclient.dll';
              Database               := getParam(dpsPATH);
              Properties.Clear;
              Properties.Values['dialect'] := '3';
              Properties.Values['CreateNewDatabase'] :=
                'CREATE DATABASE ' + QuotedStr(Database) +
                ' USER ' + QuotedStr(trim(getParam(dpsUSUARIO))) +
                ' PASSWORD ' + QuotedStr(trim(getParam(dpsSENHA))) +
                ' PAGE_SIZE 16384 DEFAULT CHARACTER SET WIN1252';
              User                   := trim(getParam(dpsUSUARIO));
              Password               := trim(getParam(dpsSENHA));
              Connect;
              Disconnect;
            end;
          finally
            FreeAndNil(db);
          end;
      end;
end;

procedure TAbstractDataManager.CreateDatabase;
begin

  if (FTypeDatabase = tdbFirebird)
  and not (FileExists(getParam(dpsPATH)))
    then
    begin
      CreateDatabase_Firebird;
      FVersionDatabase := 0;
    end;

  if (FVersionDatabase < FNewVersionDB) then
    begin
      ReflectionType := trDelphiToDatabase;
      GenerateScriptOwnTypes;              // 1º
      GenerateScriptTables;                // 2º
      GenerateScriptGeneratorsFirebirdOnly;// 3º
      GenerateScriptConstraintsUniqueKey;  // 4º
      GenerateScriptConstraintsPrimaryKey; // 5º
      GenerateScriptConstraintsForeignKey; // 6º
      GenerateScriptIndexs;                // 7º

      setParamFromIni(ALIAS,dpsVERSAODB,IntToStr(FNewVersionDB));
    end;
end;



function TAbstractDataManager.ValidateNativeTypeByName(sNameType:String):TNativeType;
var
  i:integer;
begin
  Result := ntUnknow;
  (* verifica se o tipo é um tipo básico do delphi ou do banco de dados do contexto... *)
  for i:=0 to length(FDmReflections)-1 do
  begin
    if SameText(sNameType,FDmReflections[i].DataTypeName) then
      Result := FDmReflections[i].NativeType;
  end;

  if Result = ntUnknow then
  begin
    for i:=0 to Length(DelphiTypeNames)-1 do
    begin
      if SameText(sNameType , DelphiTypeNames[i]) then
        Result := ntDelphi;
    end;

    case FTypeDatabase of
      tdbFirebird:
      begin
        for i:=0 to Length(FirbirdTypeNames)-1 do
          if SameText(sNameType , FirbirdTypeNames[i]) then
          begin
            if Result = ntDelphi then
              Result := ntDelphiAndDatabase
            else
              Result := ntDatabase;
          end;
      end;

      tdbPostgreSQL:
      begin
        for i:=0 to Length(PostgreSQLTypeNames)-1 do
          if SameText(sNameType , PostgreSQLTypeNames[i]) then
          begin
            if Result = ntDelphi then
              Result := ntDelphiAndDatabase
            else
              Result := ntDatabase;
          end;
      end;

      tdbSQLite3:
      begin
        for i:=0 to Length(SQLite3TypeNames)-1 do
          if SameText(sNameType ,SQLite3TypeNames[i]) then
          begin
            if Result = ntDelphi then
              Result := ntDelphiAndDatabase
            else
              Result := ntDatabase;
          end;
      end;
    end;
  end;
end;


(*
   A Zeos lib traduz de forma genérica entre todos os bancos suportados
   e padroniza o resultado, desta forma alguns bancos não suportam todos
   os results.

   ex: Firebird armazena nas tabelas de sistema o tipo na sequencia,
   "restrict","cascade","set null" ,"set default" = 0,1,2,3
   na zeos lib os retornos correspondentes são:
   1,0,2,3   o 1 "restrict" já é o "nada a fazer" do Firebird
*)
procedure TAbstractDataManager.getForeignKeysFromDatabase(table:string;var rsForeignKeys:TConstraintForeignKeys);
var
  i,j,x:integer;
  mdForeignkeys :IZDatabaseMetadata;
  rset_foreignkeys :IZResultSet;
begin
  SetLength(rsForeignKeys,0);
  mdForeignkeys := getConnection.GetMetadata;
  rset_foreignkeys := mdForeignkeys.GetImportedKeys('','',table);
  while rset_foreignkeys.Next do
  begin
    if not AnsiStartsStr('RDB$',rset_foreignkeys.GetStringByName('FK_NAME')) then
    begin
      x := -1;
      for i:=0 to length(rsForeignKeys)-1 do
        if SameText(rsForeignKeys[i].ForeignKeyName,rset_foreignkeys.GetStringByName('FK_NAME')) then
          x := i;
       if x=-1 then
       begin
         x := length(rsForeignKeys);
         SetLength(rsForeignKeys,1+length(rsForeignKeys));
       end;
       rsForeignKeys[x].ForeignKeyName        := rset_foreignkeys.GetStringByName('FK_NAME');
       rsForeignKeys[x].ForeignKeyTable       := rset_foreignkeys.GetStringByName('FKTABLE_NAME');(* onde a FK será declarada !*)
       rsForeignKeys[x].ForeignKeyTargetTable := rset_foreignkeys.GetStringByName('PKTABLE_NAME');(* tabela alvo onde tem a PK desta referencia! *)

       rsForeignKeys[x].RuleOnUpdate := trcNone;
       case rset_foreignkeys.GetIntByName('UPDATE_RULE') of
         0 : rsForeignKeys[x].RuleOnUpdate := trcCascade;
         1 : rsForeignKeys[x].RuleOnUpdate := trcNone;
         2 : rsForeignKeys[x].RuleOnUpdate := trcSetNull;
         3 : rsForeignKeys[x].RuleOnUpdate := trcNone; // sem correspondente no Firebird
         4 : rsForeignKeys[x].RuleOnUpdate := trcSetDefault;
         5 : rsForeignKeys[x].RuleOnUpdate := trcNone; // sem correspondente no Firebird
         6 : rsForeignKeys[x].RuleOnUpdate := trcNone; // sem correspondente no Firebird
         7 : rsForeignKeys[x].RuleOnUpdate := trcNone; // sem correspondente no Firebird
       end;

       rsForeignKeys[x].RuleOnDelete := trcNone;
       case rset_foreignkeys.GetIntByName('DELETE_RULE') of
         0 : rsForeignKeys[x].RuleOnUpdate := trcCascade;
         1 : rsForeignKeys[x].RuleOnUpdate := trcNone;
         2 : rsForeignKeys[x].RuleOnUpdate := trcSetNull;
         3 : rsForeignKeys[x].RuleOnUpdate := trcNone; // sem correspondente no Firebird
         4 : rsForeignKeys[x].RuleOnUpdate := trcSetDefault;
         5 : rsForeignKeys[x].RuleOnUpdate := trcNone; // sem correspondente no Firebird
         6 : rsForeignKeys[x].RuleOnUpdate := trcNone; // sem correspondente no Firebird
         7 : rsForeignKeys[x].RuleOnUpdate := trcNone; // sem correspondente no Firebird
       end;

       (* alimentando campos locais da chave estrangeira *)
       if rset_foreignkeys.GetStringByName('FKCOLUMN_NAME') <> '' then
       begin
         j:=-1;
         for i:=0 to length(rsForeignKeys[x].LocalFields)-1 do
           if sametext(rsForeignKeys[x].LocalFields[i],rset_foreignkeys.GetStringByName('FKCOLUMN_NAME')) then
             j := i;
         if j = -1 then
         begin
           j := length(rsForeignKeys[x].LocalFields);
           setlength(rsForeignKeys[x].LocalFields,1+length(rsForeignKeys[x].LocalFields));
           rsForeignKeys[x].LocalFields[j] := rset_foreignkeys.GetStringByName('FKCOLUMN_NAME');
         end;
       end;

       (* alimentando campos na tabela estrangeira  *)
       if rset_foreignkeys.GetStringByName('PKCOLUMN_NAME') <> '' then
       begin
         j:=-1;
         for i:=0 to length(rsForeignKeys[x].TargetFields)-1 do
           if sametext(rsForeignKeys[x].TargetFields[i],rset_foreignkeys.GetStringByName('PKCOLUMN_NAME')) then
             j := i;
         if j = -1 then
         begin
           j := length(rsForeignKeys[x].TargetFields);
           setlength(rsForeignKeys[x].TargetFields,1+length(rsForeignKeys[x].TargetFields));
           rsForeignKeys[x].TargetFields[j] := rset_foreignkeys.GetStringByName('PKCOLUMN_NAME');
         end;
       end;
    end;
  end;
end;

function TAbstractDataManager.getFullPathIniFileConfig: String;
begin
  Result := format('%s%s',[ExtractFilePath(ParamStr(0)),dps_config_file]);
  if Trim( IniFileConfig ) <> ''
    then
       Result := format('%s%s',[ExtractFilePath(ParamStr(0)),FIniFileConfig]);
end;

procedure TAbstractDataManager.getIndexesFromDatabase(table:string;var rsIndexes:TIndexes);
var
  i,j,x:integer;
  mdIndex:IZDatabaseMetadata;
  rset_index:IZResultSet;
begin
  SetLength(rsIndexes,0);
  mdIndex      := getconnection.GetMetadata;
  rset_index   := mdIndex.GetIndexInfo('','',table,False,False);
  while rset_index.Next do
  begin
    if not AnsiStartsStr('RDB$',rset_index.GetStringByName('INDEX_NAME')) then
    begin
      x := -1;
      for i:=0 to length(rsIndexes)-1 do
        if SameText(rsIndexes[i].IndexName,rset_index.GetStringByName('INDEX_NAME')) then
         x := i;
      if x = -1 then
      begin
        x := length(rsIndexes);
        SetLength(rsIndexes,1+length(rsIndexes));
      end;

      j := -1;
      for i:=0 to length(rsIndexes[x].Fields)-1 do
        if SameText(rsIndexes[x].Fields[i],rset_index.GetStringByName('COLUMN_NAME'))then
          j := i;
      if j = -1 then
      begin
        j := length(rsIndexes[x].Fields);
        SetLength(rsIndexes[x].Fields,1+length(rsIndexes[x].Fields));
      end;
      rsIndexes[x].Fields[j] := rset_index.GetStringByName('COLUMN_NAME');
      rsIndexes[x].IndexName := rset_index.GetStringByName('INDEX_NAME');
      rsIndexes[x].TableName := rset_index.GetStringByName('TABLE_NAME');
      rsIndexes[x].Unique    := not StrToBoolDef(rset_index.GetStringByName('NON_UNIQUE'),False);
      rsIndexes[x].DescOrd   := not SameText('DESC',rset_index.GetStringByName('ASC_OR_DESC'));
    end;
  end;
end;

function TAbstractDataManager.getIniFileConfig: String;
begin
  Result := FIniFileConfig;
end;

function TAbstractDataManager.getKeyFieldAutoGenerated: Boolean;
begin
  Result := FKeyFieldAutoGenerated;
end;

function TAbstractDataManager.getLocalServer: Boolean;
begin
  Result := FLocalServer;
end;

function TAbstractDataManager.getLogs: TStringList;
begin
  Result := FLogs;
end;

function TAbstractDataManager.getMdForeignKeys: TConstraintForeignKeys;
begin
  Result := FmdForeignKeys;
end;

function TAbstractDataManager.getMdIndexes: TIndexes;
begin
  Result := FmdIndexes;
end;

function TAbstractDataManager.getMdPrimaryKeys: TConstraintPrimaryKeys;
begin
  Result := FmdPrimaryKeys;
end;

function TAbstractDataManager.getMdUniqueKeys: TConstraintUniqueKeys;
begin
  Result := FmdUniqueKeys;
end;

procedure TAbstractDataManager.getPrimaryKeysFromDatabase(table:string;var rsPrimaryKeys:TConstraintPrimaryKeys);
var
  i,x:integer;
  mdPrimaryKeys    :IZDatabaseMetadata;
  rset_primarykeys :IZResultSet;
begin
  SetLength(rsPrimaryKeys,0);
  mdPrimaryKeys    := getConnection.GetMetadata;
  rset_primarykeys := mdPrimaryKeys.GetPrimaryKeys('','',table);
  while rset_primarykeys.Next do
  begin
    if not AnsiStartsStr('RDB$',rset_primarykeys.GetStringByName('PK_NAME')) then
    begin
      x := -1;
      for i:=0 to length(rsPrimarykeys)-1 do
        if Sametext(rsPrimarykeys[i].PrimaryKeyName,rset_primarykeys.GetStringByName('PK_NAME')) then
          x := i;
      if x = -1 then
      begin
        x := length(rsPrimaryKeys);
        setLength(rsPrimaryKeys,1+length(rsPrimaryKeys));
      end;
      rsPrimaryKeys[x].PrimaryKeyName  := rset_primarykeys.GetStringByName('PK_NAME');
      rsPrimaryKeys[x].PrimaryKeyTable := rset_primarykeys.GetStringByName('TABLE_NAME');
      rsPrimaryKeys[x].PrimaryKeyField := rset_primarykeys.GetStringByName('COLUMN_NAME');
    end;
  end;
end;

procedure TAbstractDataManager.getUniqueKeysFromDatabase(table:string;var rsUniqueKeys:TConstraintUniqueKeys);
begin
  (*
    rotina criada por compatibilidade, ainda sem implementação.

    Não utilizada na importação de dados do Firebird, porém se depois da importação
    base do Datamanager o PROGRAMADOR embutir nas classes modelo a configuração da
    Chave única ela será criada pela Classe Datamanager nas novas bases de dados.
  *)
end;

function TAbstractDataManager.getVersionCoreDB: Int64;
begin
  Result := FVersionCoreDB;
end;

function TAbstractDataManager.getVersionDatabase: Int64;
begin
  Result := FVersionDatabase;
end;

procedure TAbstractDataManager.GenerateScriptGeneratorsFirebirdOnly;
var
  i,j:Integer;
begin
  if TypeDatabase in [tdbFirebird] then
    for i:=0 to Length(FTableReflections)-1 do
      begin
        for j:=0 to length(FTableReflections[i])-1 do
          begin
            if (FTableReflections[i][j].AutoInc) and (FTableReflections[i][j].PrimaryKey) then
              if not GeneratorExists(format('id%s',[FTableReflections[i][j].ClassOrTableName]))
                 then ExecuteScript( format('create generator id%s',[FTableReflections[i][j].ClassOrTableName]));
          end;
      end;
end;

function TDPSAbstractModel.getList(sWhere:String = '';sOrder:String = '';externalDataSet:TClientDataSet = nil):TObjectList;
var
  qrGetList:TZQuery;
  sql :String;
begin
  Result  := TObjectList.Create;
  sql  := format('select * from %s where (0=0)',[self.TableName,sWhere,sOrder]);

  if trim(sWhere) <> ''
    then sql := format('%s and %s',[sql,sWhere]);

  if trim(sOrder) <> ''
    then sql := format('%s %s',[sql,sOrder]);

  qrGetList  := Datamanager.getTempQuery(sql);
  try
    configureExternalDataset(externalDataSet);
    if not (qrGetList.IsEmpty)
    then while not qrGetList.Eof
         do begin
              Result.add( TObject(new(FDatamanager,qrGetList) ));
              if externalDataSet <> nil
                then TDPSAbstractModel(Result[Result.Count-1]).fillDataset(externalDataSet);
              qrGetList.Next;
            end;
  finally
    if externalDataSet <> nil
    then Datamanager.AddLogBusinessRule(codSWarningRecordsInResultsetList,format(SWarningRecordsInResultsetList,[qrGetList.RecordCount]),sbrWarning);
    qrGetList.Connection.free;
    freeandnil(qrGetList)
  end;
end;


function TAbstractDataManager.CreateGenerator(sGeneratorName: String): Boolean;
var
  sql_query,sql_execute:string;
  qrTemp:TZQuery;
begin
  Result := False;
  case TypeDatabase of
    tdbFirebird:
    begin
      try
        sql_execute := format(' CREATE GENERATOR %s',[UpperCase(sGeneratorName)]);
        ExecuteScript(sql_execute);
        sql_query  := format('SELECT RDB$GENERATOR_NAME FROM RDB$GENERATORS WHERE UPPER(RDB$GENERATOR_NAME) = %s',[QuotedStr(UpperCase(sGeneratorName))]);
        qrTemp := getTempQuery(sql_query);
        Result := not qrTemp.IsEmpty;
      finally
        qrTemp.Connection.Free;
        qrTemp.free;
      end;
    end;
  end;
end;

destructor TAbstractDataManager.Destroy;
begin
  if Assigned(FMonitor)
    then FMonitor.Free;
end;

constructor TDPSStandardModel.Create(dmgr:IDataManager);
begin
  FId                    := -1;
  FGuid                  := '';
  FKeyFieldName          := 'id';
  FKeyFieldAutoGenerated := True;
  inherited;
  SetupPrimaryKey(Format('pk_id_%s',[TableName]),TableName,'id',[]);
  SetupUniqueKey(Format('uk_guid_%s',[TableName]),TableName,['guid']);
end;

function TDPSAbstractModel.GenerateNewID(inc:Int64=1): Int64;
var
  sql_query:string;
  qrTemp:TZQuery;
begin
  Result := -1;
  case Datamanager.TypeDatabase of
    tdbFirebird:
    begin
      try
        UpdateLastID;
        sql_query := format('select gen_id(%s,%d)new_id from rdb$database',[UpperCase( KeyFieldName+TableName),inc]);
        qrTemp := Datamanager.getTempQuery(sql_query);
        if not qrTemp.IsEmpty then
          Result := qrTemp.fieldbyName('new_id').AsLargeInt;
      finally
        qrTemp.Connection.free;
        qrTemp.Free;
      end;
    end;
  end;
end;


end.
