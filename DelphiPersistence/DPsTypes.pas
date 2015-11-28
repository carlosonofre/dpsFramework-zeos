{******************************************************************************}
{                                                                              }
{          Test Name:   Delphi Persistence Framework                           }
{             Author:   Bianco - conofresilva@gmail.com                        }
{            Version:   3.0                                                    }
{            Summary:   FrameWork persistência em Delphi                       }
{           Comments:   2011-2013                                              }
{                                                                              }
{******************************************************************************}

unit DPsTypes;

interface

uses

 Windows,Messages,SysUtils,Classes,TypInfo,Graphics,Controls,Variants,Forms,
 Dialogs,StdCtrls, Registry,IniFiles,DB,ComObj,Math,StrUtils,IdHashMessageDigest;

{$M+}
type
  (* Char *)
  dps_Char_1   = String[1];    dps_Char_2   = String[2];    dps_Char_3   = String[3];
  dps_Char_4   = String[4];    dps_Char_5   = String[5];    dps_Char_6   = String[6];
  dps_Char_7   = String[7];    dps_Char_8   = String[8];    dps_Char_9   = String[9];
  dps_Char_10  = String[10];   dps_Char_11  = String[11];   dps_Char_12  = String[12];
  dps_Char_13  = String[13];   dps_Char_14  = String[14];   dps_Char_15  = String[15];
  dps_Char_16  = String[16];   dps_Char_17  = String[17];   dps_Char_18  = String[18];
  dps_Char_19  = String[19];   dps_Char_20  = String[20];   dps_Char_21  = String[21];
  dps_Char_22  = String[22];   dps_Char_23  = String[23];   dps_Char_24  = String[24];
  dps_Char_25  = String[25];   dps_Char_26  = String[26];   dps_Char_27  = String[27];
  dps_Char_28  = String[28];   dps_Char_29  = String[29];   dps_Char_30  = String[30];
  dps_Char_31  = String[31];   dps_Char_32  = String[32];   dps_Char_33  = String[33];
  dps_Char_34  = String[34];   dps_Char_35  = String[35];   dps_Char_36  = String[36];
  dps_Char_37  = String[37];   dps_Char_38  = String[38];   dps_Char_39  = String[39];
  dps_Char_40  = String[40];   dps_Char_41  = String[41];   dps_Char_42  = String[42];
  dps_Char_43  = String[43];   dps_Char_44  = String[44];   dps_Char_45  = String[45];
  dps_Char_46  = String[46];   dps_Char_47  = String[47];   dps_Char_48  = String[48];
  dps_Char_49  = String[49];   dps_Char_50  = String[50];   dps_Char_51  = String[51];
  dps_Char_52  = String[52];   dps_Char_53  = String[53];   dps_Char_54  = String[54];
  dps_Char_55  = String[55];   dps_Char_56  = String[56];   dps_Char_57  = String[57];
  dps_Char_58  = String[58];   dps_Char_59  = String[59];   dps_Char_60  = String[60];
  dps_Char_61  = String[61];   dps_Char_62  = String[62];   dps_Char_63  = String[63];
  dps_Char_64  = String[64];   dps_Char_65  = String[65];   dps_Char_66  = String[66];
  dps_Char_67  = String[67];   dps_Char_68  = String[68];   dps_Char_69  = String[69];
  dps_Char_70  = String[70];   dps_Char_71  = String[71];   dps_Char_72  = String[72];
  dps_Char_73  = String[73];   dps_Char_74  = String[74];   dps_Char_75  = String[75];
  dps_Char_76  = String[76];   dps_Char_77  = String[77];   dps_Char_78  = String[78];
  dps_Char_79  = String[79];   dps_Char_80  = String[80];   dps_Char_81  = String[81];
  dps_Char_82  = String[82];   dps_Char_83  = String[83];   dps_Char_84  = String[84];
  dps_Char_85  = String[85];   dps_Char_86  = String[86];   dps_Char_87  = String[87];
  dps_Char_88  = String[88];   dps_Char_89  = String[89];   dps_Char_90  = String[90];
  dps_Char_91  = String[91];   dps_Char_92  = String[92];   dps_Char_93  = String[93];
  dps_Char_94  = String[94];   dps_Char_95  = String[95];   dps_Char_96  = String[96];
  dps_Char_97  = String[97];   dps_Char_98  = String[98];   dps_Char_99  = String[99];
  dps_Char_100 = String[100];  dps_Char_101 = String[101];  dps_Char_102 = String[102];
  dps_Char_103 = String[103];  dps_Char_104 = String[104];  dps_Char_105 = String[105];
  dps_Char_106 = String[106];  dps_Char_107 = String[107];  dps_Char_108 = String[108];
  dps_Char_109 = String[109];  dps_Char_110 = String[110];  dps_Char_111 = String[111];
  dps_Char_112 = String[112];  dps_Char_113 = String[113];  dps_Char_114 = String[114];
  dps_Char_115 = String[115];  dps_Char_116 = String[116];  dps_Char_117 = String[117];
  dps_Char_118 = String[118];  dps_Char_119 = String[119];  dps_Char_120 = String[120];
  dps_Char_121 = String[121];  dps_Char_122 = String[122];  dps_Char_123 = String[123];
  dps_Char_124 = String[124];  dps_Char_125 = String[125];  dps_Char_126 = String[126];
  dps_Char_127 = String[127];  dps_Char_128 = String[128];  dps_Char_129 = String[129];
  dps_Char_130 = String[130];  dps_Char_131 = String[131];  dps_Char_132 = String[132];
  dps_Char_133 = String[133];  dps_Char_134 = String[134];  dps_Char_135 = String[135];
  dps_Char_136 = String[136];  dps_Char_137 = String[137];  dps_Char_138 = String[138];
  dps_Char_139 = String[139];  dps_Char_140 = String[140];  dps_Char_141 = String[141];
  dps_Char_142 = String[142];  dps_Char_143 = String[143];  dps_Char_144 = String[144];
  dps_Char_145 = String[145];  dps_Char_146 = String[146];  dps_Char_147 = String[147];
  dps_Char_148 = String[148];  dps_Char_149 = String[149];  dps_Char_150 = String[150];
  dps_Char_151 = String[151];  dps_Char_152 = String[152];  dps_Char_153 = String[153];
  dps_Char_154 = String[154];  dps_Char_155 = String[155];  dps_Char_156 = String[156];
  dps_Char_157 = String[157];  dps_Char_158 = String[158];  dps_Char_159 = String[159];
  dps_Char_160 = String[160];  dps_Char_161 = String[161];  dps_Char_162 = String[162];
  dps_Char_163 = String[163];  dps_Char_164 = String[164];  dps_Char_165 = String[165];
  dps_Char_166 = String[166];  dps_Char_167 = String[167];  dps_Char_168 = String[168];
  dps_Char_169 = String[169];  dps_Char_170 = String[170];  dps_Char_171 = String[171];
  dps_Char_172 = String[172];  dps_Char_173 = String[173];  dps_Char_174 = String[174];
  dps_Char_175 = String[175];  dps_Char_176 = String[176];  dps_Char_177 = String[177];
  dps_Char_178 = String[178];  dps_Char_179 = String[179];  dps_Char_180 = String[180];
  dps_Char_181 = String[181];  dps_Char_182 = String[182];  dps_Char_183 = String[183];
  dps_Char_184 = String[184];  dps_Char_185 = String[185];  dps_Char_186 = String[186];
  dps_Char_187 = String[187];  dps_Char_188 = String[188];  dps_Char_189 = String[189];
  dps_Char_190 = String[190];  dps_Char_191 = String[191];  dps_Char_192 = String[192];
  dps_Char_193 = String[193];  dps_Char_194 = String[194];  dps_Char_195 = String[195];
  dps_Char_196 = String[196];  dps_Char_197 = String[197];  dps_Char_198 = String[198];
  dps_Char_199 = String[199];  dps_Char_200 = String[200];  dps_Char_201 = String[201];
  dps_Char_202 = String[202];  dps_Char_203 = String[203];  dps_Char_204 = String[204];
  dps_Char_205 = String[205];  dps_Char_206 = String[206];  dps_Char_207 = String[207];
  dps_Char_208 = String[208];  dps_Char_209 = String[209];  dps_Char_210 = String[210];
  dps_Char_211 = String[211];  dps_Char_212 = String[212];  dps_Char_213 = String[213];
  dps_Char_214 = String[214];  dps_Char_215 = String[215];  dps_Char_216 = String[216];
  dps_Char_217 = String[217];  dps_Char_218 = String[218];  dps_Char_219 = String[219];
  dps_Char_220 = String[220];  dps_Char_221 = String[221];  dps_Char_222 = String[222];
  dps_Char_223 = String[223];  dps_Char_224 = String[224];  dps_Char_225 = String[225];
  dps_Char_226 = String[226];  dps_Char_227 = String[227];  dps_Char_228 = String[228];
  dps_Char_229 = String[229];  dps_Char_230 = String[230];  dps_Char_231 = String[231];
  dps_Char_232 = String[232];  dps_Char_233 = String[233];  dps_Char_234 = String[234];
  dps_Char_235 = String[235];  dps_Char_236 = String[236];  dps_Char_237 = String[237];
  dps_Char_238 = String[238];  dps_Char_239 = String[239];  dps_Char_240 = String[240];
  dps_Char_241 = String[241];  dps_Char_242 = String[242];  dps_Char_243 = String[243];
  dps_Char_244 = String[244];  dps_Char_245 = String[245];  dps_Char_246 = String[246];
  dps_Char_247 = String[247];  dps_Char_248 = String[248];  dps_Char_249 = String[249];
  dps_Char_250 = String[250];  dps_Char_251 = String[251];  dps_Char_252 = String[252];
  dps_Char_253 = String[253];  dps_Char_254 = String[254];  dps_Char_255 = String[255];

  (* String *)
  dps_String_1   = String[1];    dps_String_2   = String[2];    dps_String_3   = String[3];
  dps_String_4   = String[4];    dps_String_5   = String[5];    dps_String_6   = String[6];
  dps_String_7   = String[7];    dps_String_8   = String[8];    dps_String_9   = String[9];
  dps_String_10  = String[10];   dps_String_11  = String[11];   dps_String_12  = String[12];
  dps_String_13  = String[13];   dps_String_14  = String[14];   dps_String_15  = String[15];
  dps_String_16  = String[16];   dps_String_17  = String[17];   dps_String_18  = String[18];
  dps_String_19  = String[19];   dps_String_20  = String[20];   dps_String_21  = String[21];
  dps_String_22  = String[22];   dps_String_23  = String[23];   dps_String_24  = String[24];
  dps_String_25  = String[25];   dps_String_26  = String[26];   dps_String_27  = String[27];
  dps_String_28  = String[28];   dps_String_29  = String[29];   dps_String_30  = String[30];
  dps_String_31  = String[31];   dps_String_32  = String[32];   dps_String_33  = String[33];
  dps_String_34  = String[34];   dps_String_35  = String[35];   dps_String_36  = String[36];
  dps_String_37  = String[37];   dps_String_38  = String[38];   dps_String_39  = String[39];
  dps_String_40  = String[40];   dps_String_41  = String[41];   dps_String_42  = String[42];
  dps_String_43  = String[43];   dps_String_44  = String[44];   dps_String_45  = String[45];
  dps_String_46  = String[46];   dps_String_47  = String[47];   dps_String_48  = String[48];
  dps_String_49  = String[49];   dps_String_50  = String[50];   dps_String_51  = String[51];
  dps_String_52  = String[52];   dps_String_53  = String[53];   dps_String_54  = String[54];
  dps_String_55  = String[55];   dps_String_56  = String[56];   dps_String_57  = String[57];
  dps_String_58  = String[58];   dps_String_59  = String[59];   dps_String_60  = String[60];
  dps_String_61  = String[61];   dps_String_62  = String[62];   dps_String_63  = String[63];
  dps_String_64  = String[64];   dps_String_65  = String[65];   dps_String_66  = String[66];
  dps_String_67  = String[67];   dps_String_68  = String[68];   dps_String_69  = String[69];
  dps_String_70  = String[70];   dps_String_71  = String[71];   dps_String_72  = String[72];
  dps_String_73  = String[73];   dps_String_74  = String[74];   dps_String_75  = String[75];
  dps_String_76  = String[76];   dps_String_77  = String[77];   dps_String_78  = String[78];
  dps_String_79  = String[79];   dps_String_80  = String[80];   dps_String_81  = String[81];
  dps_String_82  = String[82];   dps_String_83  = String[83];   dps_String_84  = String[84];
  dps_String_85  = String[85];   dps_String_86  = String[86];   dps_String_87  = String[87];
  dps_String_88  = String[88];   dps_String_89  = String[89];   dps_String_90  = String[90];
  dps_String_91  = String[91];   dps_String_92  = String[92];   dps_String_93  = String[93];
  dps_String_94  = String[94];   dps_String_95  = String[95];   dps_String_96  = String[96];
  dps_String_97  = String[97];   dps_String_98  = String[98];   dps_String_99  = String[99];
  dps_String_100 = String[100];  dps_String_101 = String[101];  dps_String_102 = String[102];
  dps_String_103 = String[103];  dps_String_104 = String[104];  dps_String_105 = String[105];
  dps_String_106 = String[106];  dps_String_107 = String[107];  dps_String_108 = String[108];
  dps_String_109 = String[109];  dps_String_110 = String[110];  dps_String_111 = String[111];
  dps_String_112 = String[112];  dps_String_113 = String[113];  dps_String_114 = String[114];
  dps_String_115 = String[115];  dps_String_116 = String[116];  dps_String_117 = String[117];
  dps_String_118 = String[118];  dps_String_119 = String[119];  dps_String_120 = String[120];
  dps_String_121 = String[121];  dps_String_122 = String[122];  dps_String_123 = String[123];
  dps_String_124 = String[124];  dps_String_125 = String[125];  dps_String_126 = String[126];
  dps_String_127 = String[127];  dps_String_128 = String[128];  dps_String_129 = String[129];
  dps_String_130 = String[130];  dps_String_131 = String[131];  dps_String_132 = String[132];
  dps_String_133 = String[133];  dps_String_134 = String[134];  dps_String_135 = String[135];
  dps_String_136 = String[136];  dps_String_137 = String[137];  dps_String_138 = String[138];
  dps_String_139 = String[139];  dps_String_140 = String[140];  dps_String_141 = String[141];
  dps_String_142 = String[142];  dps_String_143 = String[143];  dps_String_144 = String[144];
  dps_String_145 = String[145];  dps_String_146 = String[146];  dps_String_147 = String[147];
  dps_String_148 = String[148];  dps_String_149 = String[149];  dps_String_150 = String[150];
  dps_String_151 = String[151];  dps_String_152 = String[152];  dps_String_153 = String[153];
  dps_String_154 = String[154];  dps_String_155 = String[155];  dps_String_156 = String[156];
  dps_String_157 = String[157];  dps_String_158 = String[158];  dps_String_159 = String[159];
  dps_String_160 = String[160];  dps_String_161 = String[161];  dps_String_162 = String[162];
  dps_String_163 = String[163];  dps_String_164 = String[164];  dps_String_165 = String[165];
  dps_String_166 = String[166];  dps_String_167 = String[167];  dps_String_168 = String[168];
  dps_String_169 = String[169];  dps_String_170 = String[170];  dps_String_171 = String[171];
  dps_String_172 = String[172];  dps_String_173 = String[173];  dps_String_174 = String[174];
  dps_String_175 = String[175];  dps_String_176 = String[176];  dps_String_177 = String[177];
  dps_String_178 = String[178];  dps_String_179 = String[179];  dps_String_180 = String[180];
  dps_String_181 = String[181];  dps_String_182 = String[182];  dps_String_183 = String[183];
  dps_String_184 = String[184];  dps_String_185 = String[185];  dps_String_186 = String[186];
  dps_String_187 = String[187];  dps_String_188 = String[188];  dps_String_189 = String[189];
  dps_String_190 = String[190];  dps_String_191 = String[191];  dps_String_192 = String[192];
  dps_String_193 = String[193];  dps_String_194 = String[194];  dps_String_195 = String[195];
  dps_String_196 = String[196];  dps_String_197 = String[197];  dps_String_198 = String[198];
  dps_String_199 = String[199];  dps_String_200 = String[200];  dps_String_201 = String[201];
  dps_String_202 = String[202];  dps_String_203 = String[203];  dps_String_204 = String[204];
  dps_String_205 = String[205];  dps_String_206 = String[206];  dps_String_207 = String[207];
  dps_String_208 = String[208];  dps_String_209 = String[209];  dps_String_210 = String[210];
  dps_String_211 = String[211];  dps_String_212 = String[212];  dps_String_213 = String[213];
  dps_String_214 = String[214];  dps_String_215 = String[215];  dps_String_216 = String[216];
  dps_String_217 = String[217];  dps_String_218 = String[218];  dps_String_219 = String[219];
  dps_String_220 = String[220];  dps_String_221 = String[221];  dps_String_222 = String[222];
  dps_String_223 = String[223];  dps_String_224 = String[224];  dps_String_225 = String[225];
  dps_String_226 = String[226];  dps_String_227 = String[227];  dps_String_228 = String[228];
  dps_String_229 = String[229];  dps_String_230 = String[230];  dps_String_231 = String[231];
  dps_String_232 = String[232];  dps_String_233 = String[233];  dps_String_234 = String[234];
  dps_String_235 = String[235];  dps_String_236 = String[236];  dps_String_237 = String[237];
  dps_String_238 = String[238];  dps_String_239 = String[239];  dps_String_240 = String[240];
  dps_String_241 = String[241];  dps_String_242 = String[242];  dps_String_243 = String[243];
  dps_String_244 = String[244];  dps_String_245 = String[245];  dps_String_246 = String[246];
  dps_String_247 = String[247];  dps_String_248 = String[248];  dps_String_249 = String[249];
  dps_String_250 = String[250];  dps_String_251 = String[251];  dps_String_252 = String[252];
  dps_String_253 = String[253];  dps_String_254 = String[254];  dps_String_255 = String[255];

  (* nativos ponto flutuante *)
  dps_TDate     = TDate;
  dps_TTime     = TTime;
  dps_TDateTime = TDateTime;
  dps_Currency  = Currency;
  dps_Extended  = Extended;
  dps_Double    = Double;
  dps_Single    = Single;

  (* nativos Inteiro *)
  dps_Byte                 = Byte;
  dps_ShortInt             = ShortInt;
  dps_Word                 = Word;
  dps_Smallint             = Smallint;
  dps_Cardinal_e_LongWord  = Cardinal;// Cardinal é a implementacao do delphi para LongWord
  dps_LongInt_e_Integer    = Integer; // Integer é a implementacao do delphi para LongInt
  dps_Int64                = Int64;

  dps_Blob = TBlobData;

  dps_Enumeration = array[1..80] of Byte;

  TPatternCreateUnits = (tcuMultiplesUnits,tcuSingleUnits);
  TPatternGettersAndSetters = (tpatDelphiShort,tpatDelphi,tpatJava);
  TTypeOfDatabase = (tdbFirebird,tdbPostgreSQL,tdbSQLite3,tdbOracle);
  TNativeType = (ntUnknow,ntDelphi,ntDatabase,ntDelphiAndDatabase);

  TDynamicValue = packed record
     Index :integer;
     ValueAsString :String;
     FriedlyValueAsString:String;
  end;

  TDynamicType = packed record
    Name:string;
    DynamicValues : array of TDynamicValue;
  end;

  TDynamicTypes = array of TDynamicType ;

  TTypeNode = (ncLocalHost,ncDatabaseServer,ncWebServer);

//  TPropConnection = packed record
//    ConectionName :string;
//    Host          :string;
//    Port          :Integer;
//    User          :string;
//    Pass          :string;
//    PathDB        :string;
//    DriverZeos    :string;
//    Embedded      :Boolean;
//    ConnectionString :string;
//    VersaoAtual   :String;
//  end;

  TTpOrdIndex       = (toAsc,toDesc);
  TIndex = packed record
    TableName     :string;
    IndexName     :string;
    Fields        :Array of String;
    Unique        :Boolean;
    DescOrd       :Boolean;
  end;

  TIndexes = array of TIndex;

  TTpRuleConstraint = (trcNone,trcCascade,trcSetDefault,trcSetNull);

  TConstraintPrimaryKey = packed record
    PrimaryKeyName  :String;
    PrimaryKeyTable :String;
    PrimaryKeyField :String;
  end;
  TConstraintPrimaryKeys = array of TConstraintPrimaryKey;

  TConstraintForeignKey = packed record
    ForeignKeyName  :String;
    ForeignKeyTable :String;
    ForeignKeyTargetTable :String;
    RuleOnUpdate    :TTpRuleConstraint;
    RuleOnDelete    :TTpRuleConstraint;
    LocalFields     :array of string;
    TargetFields    :array of string;
    CheckList       :array of string;
    IndexName       :String;
    IndexDescOrd    :Boolean;
  end;
  TConstraintForeignKeys = array of TConstraintForeignKey;

  TConstraintUniqueKey = packed record
    UniqueKeyName  :String;
    UniqueKeyTable :String;
    LocalFields    :array of string;
  end;
  TConstraintUniqueKeys = array of TConstraintUniqueKey;
  TChecks = array of string;

  TDynamicArrayofString = Array of array of string;

  TTypeReflection = (trDatabaseToDelphi,trDelphiToDatabase);

  TDataReflection = packed record
    ClassName               : String;
    TypeReflection          : TTypeReflection;
    TypeDatabase            : TTypeOfDatabase;
    ClassOrTableName        : String;
    PropertyOrColumnName    : String;
    PropertyOrColumnDescript: String;
    DataTypeName            : String;
    OriginalDataTypeName    : String;
    FullNameDatabaseType    : String;
    FullNameDelphiType      : String;
    DefaultValue            : String;
    DataSize                : Int64;
    DataSizeScale           : Int64;
    NativeType              : TNativeType;
    BasicTypeKind           : TTypeKind;
    DatabaseCheck           : array of string;
    FriendlyValues          : array of string;
    IndexDynamicType        : Integer;
    VersionDB               : Integer;
    VersionCoreDB           : Integer;
    DialectCoreDB           : Integer;
    AcceptsNull             : Boolean;
    PrimaryKey              : Boolean;
    AutoInc                 : Boolean;
    DBPosition              : Integer;
    DisplaySize             : Integer;
    DisplayMask             : String;
  end;

  TReflection       = array of TDataReflection;(* pacote de tipos *)
  TTableReflection  = TReflection;             (* tipo pacote de tipos *)
  TTableReflections = array of TReflection;    (* pacote de pacote de tipos *)

  EDPSException = class(Exception);

  TTypeBusinessRule = (sbrError,sbrHint,sbrWarning);

  TBusinessRule = packed record
    CodeRule    :String;
    TypeRule    :TTypeBusinessRule;
    FormatedRuleMessage :string;
    FormatedRuleParams  :array of String;
  end;
  TBusinessRules = array of TBusinessRule;

  function TypeKindToStr(tkTypeKind:TTypeKind):String;
  function TypeKindToFirebird(tkTypeKind:TTypeKind):String;
  function TypeKindToPostgreSQL(tkTypeKind:TTypeKind):String;
  function TypeKindToSQLite3(tkTypeKind:TTypeKind):String;
  function TypeKindToOracle(tkTypeKind:TTypeKind):String;
  function TypeKindToADO(tkTypeKind:TTypeKind):String;

  (* funcoes para tipos conhecidos, tipos básicos do delphi para um tipo básico do banco *)
  function DelphiTypeNameToDatabase(DelphiNameType:String;Database:TTypeOfDatabase;VersionCoreDB:Integer=0;DialectCoreDB:Integer=0):String;

  function DelphiTypeNameToFirebird(DelphiNameType:String;VersionCore:Integer;DialectCore:Integer):String;
  function DelphiTypeNameToPostgreSQL(DelphiNameType:String;VersionCore:Integer;DialectCore:Integer):String;
  function DelphiTypeNameToSQLite3(DelphiNameType:String;VersionCore:Integer;DialectCore:Integer):String;
  function DelphiTypeNameToOracle(DelphiNameType:String;VersionCore:Integer;DialectCore:Integer):String;
  function DelphiTypeNameToADO(DelphiNameType:String;VersionCore:Integer;DialectCore:Integer):String;

  function FirebirdTypeNameToDelphi(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):String;
  function PostgreSQLTypeNameToDelphi(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):String;
  function SQLite3TypeNameToDelphi(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):String;
  function OracleTypeNameToDelphi(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):String;
  function ADOTypeNameNameToDelphi(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):String;

  function DelphiTypeNameToDelphiTypeKind(DelphiNameType:String):TTypeKind;
  function FirebirdTypeNameToDelphiTypeKind(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):TTypeKind;
  function PostgreSQLTypeNameToDelphiTypeKind(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):TTypeKind;
  function SQLite3TypeNameToDelphiTypeKind(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):TTypeKind;
  function OracleTypeNameToDelphiTypeKind(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):TTypeKind;
  function ADOTypeNameNameToDelphiTypeKind(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):TTypeKind;

  function DatabaseTypeNameToDelphi(DatabaseNameType:String;Database:TTypeOfDatabase;VersionCoreDB:Integer=0;DialectCoreDB:Integer=0):String;
  function DatabaseTypeNameToDelphiTypeKind(DatabaseNameType:String;Database:TTypeOfDatabase;VersionCoreDB:Integer=0;DialectCoreDB:Integer=0):TTypeKind;

  procedure ConvertStringAndSetToDatabase(var AReflection:TDataReflection);
  procedure ConvertStringAndSetToDelphi(var AReflection:TDataReflection);

  procedure ConvertClassToDatabase(var AReflection:TDataReflection);
  procedure ConvertClassToDelphi(var AReflection:TDataReflection);

  procedure ConvertIntegerToDatabase(var AReflection:TDataReflection);
  procedure ConvertIntegerToDelphi(var AReflection:TDataReflection);

  procedure ConvertFloatToDatabase(var AReflection:TDataReflection);
  procedure ConvertFloatToDelphi(var AReflection:TDataReflection);

  procedure ConvertEnumerationToDatabase(var AReflection:TDataReflection);
  procedure ConvertEnumerationToDelphi(var AReflection:TDataReflection);

  procedure SetDefaultsTypeReflection(var DataReflection:TDataReflection;tpKind:TTypeKind;ReferenceReflections:TReflection);

  function UpperFirstChar(sWord:String):String;
  function GeraMD5(sTexto: string): String; // para token

{$M-}

  const
  (*  NOME ARQUIVO DE CONFIGURAÇÃO DO FRAMEWORK *)
  dps_config_file                            =  'dps.framework.conf';

  (* PROGRAMADOR, CUIDADO! ANTES DE ALTERAR A ORDEM DESTAS CONSTANTES ABAIXO
     VERIFIQUE POIS EXISTEM ROTINAS QUE LÊEM E IDENTIFICAM O VALOR PELO INDICE
  *)
  DelphiTypeNames:array[ 0..26] of string    =('Char','AnsiChar','WideChar','String','ShortString',
                                               'AnsiString','WideString','TBlobData','TBitmap','Byte',
                                               'ShortInt','SmallInt','LongWord','Cardinal','Word','Integer',
                                               'LongInt','Int64','Single','Double','Extended','Real',
                                               'Currency','TDate','TTime','TDateTime','TArray<System.Byte>');


  FirbirdTypeNames:array [0..12] of string   =('CHAR','VARCHAR','SMALLINT','INTEGER','BIGINT',
                                               'FLOAT','DOUBLE PRECISION','DATE','TIME','TIMESTAMP',
                                               'DECIMAL','NUMERIC','BLOB');

  PostgreSQLTypeNames:array [0..1] of string =('CHAR','VARCHAR');

  SQLite3TypeNames:array [0..1] of string    =('CHAR','VARCHAR');

{
  resourcestring

    modelsUses                = 'Windows,Messages,SysUtils,Variants,Classes,DB,Graphics,DPsDatamanager,DPSTypes,Contnrs;';
    msg_type_db_no_defined    = 'Tipo %s do campo %s da tabela %s não tem um tipo correspondente para o banco de dados.';
    msg_desc_conection_fail   = 'Falha de conexão, alias : %s';

   SEDatabasePathNotSpecified =  'Banco de dados não pode ser criado,caminho do banco não foi especificado.';
}
implementation

function UpperFirstChar(sWord:String):String;
var
  s :string;
begin
  s := UpperCase(sWord[1]);
  Delete(sWord,1,1);
  Result :=  s+LowerCase(sWord);
end;

(*    COMENTÁRIO PARA REFERÊNCIA

      Byte     - (Tipo por valor) - Inteiro de 8 bits sem sinal (0 a 255).
      Shortint - (Tipo por valor) - Inteiro de16 bits com sinal ( -32768 a 32767).
      Integer  - (Tipo por valor) - Inteiro de 32 bits com sinal (- 2147483648 a 2147483647).
      Long     - (Tipo por valor) - Inteiro de 64 bits com sinal (-9223372036854775808 a 9223372036854775807).
      Single   - (Tipo por valor) - Ponto flutuante 32 bits.
      Double   - (Tipo por valor) - Ponto Flutuante 64 bits.
      Decimal  - (Tipo por valor) - Ponto Flutuante decimal de 128 bits ( 1.0 x 10^ -28 a 7.9 x 10^ -28),
      Boolean  - (Tipo por valor) - Pode ter os valores True e False.
      Char     - (Tipo por valor) - Representa um único caractere unicode de 16 bits.
      Date     - (Tipo por valor) - Representa uma data ou hora.
      String   - (Tipo por referência) - Representa uma sequência de caracteres unicode.
*)


(*  função que retorna o nome do tipo no delphi com base no typeKind, tipo
    mais básico que toda propriedade tem *)

function TypeKindToStr(tkTypeKind:TTypeKind):String;
begin
  Result := 'String';//'Unknown';
  case tkTypeKind of
    tkUnknown:     Result := 'String';//'Unknown';
    tkInteger:     Result := 'Integer';
    tkChar:        Result := 'Char';//'Char';
    tkEnumeration: Result := 'Enumeration';
    tkFloat:       Result := 'Float';
    tkString:      Result := 'String';
    tkSet:         Result := 'Set of dps_Enumeration';
    tkClass:       Result := 'TBlobData';
    tkMethod:      Result := 'Method';
    tkWChar:       Result := 'Char';//'WChar';
    tkLString:     Result := 'String';//'LString';
    tkWString:     Result := 'String';//'WString';
    tkVariant:     Result := 'Variant';
    tkArray:       Result := 'Array';// pensei em blob talvez
    tkRecord:      Result := 'Record';
    tkInterface:   Result := 'Interface';
    tkInt64:       Result := 'Int64';
    tkDynArray:    Result := 'DynArray';
  end;
end;

(* Conversor de tipo Básico do Delphi --> para Tipos Básicos do Firebird *)
function  TypeKindToFirebird(tkTypeKind:TTypeKind):String;
begin
  (* Os tipos comentados ainda Não foram implementados ... *)
  Result := 'VARCHAR';//'Unknown';
  case tkTypeKind of
    tkInteger:     Result := 'INTEGER';
    tkInt64:       Result := 'BIGINT';
    tkChar:        Result := 'CHAR';
    tkWChar:       Result := 'CHAR';
    tkEnumeration: Result := 'INTEGER';
    tkFloat:       Result := 'DOUBLE';
    tkSet:         Result := 'VARCHAR';
    tkClass:       Result := 'BLOB';
    tkDynArray:    Result := 'BLOB';
    tkString:      Result := 'VARCHAR';
    tkLString:     Result := 'VARCHAR';
    tkWString:     Result := 'VARCHAR';
    tkVariant:     Result := 'BLOB';
  end;
end;

(* Conversor de tipo Básico do Delphi --> para Tipos Básicos do PostgreSQL *)
function  TypeKindToPostgreSQL(tkTypeKind:TTypeKind):String;
begin
  (* Os tipos comentados ainda Não foram implementados ... *)
  Result := 'CHARACTER';//'Unknown';
  case tkTypeKind of
    tkInteger:     Result := 'INTEGER';
    tkChar:        Result := 'CHARACTER';
    tkEnumeration: Result := 'INTEGER';
    tkFloat:       Result := 'REAL';
    tkString:      Result := 'CHARACTER';
    tkSet:         Result := 'CHARACTER';
    tkClass:       Result := 'BLOB';
    tkWChar:       Result := 'CHARACTER';
    tkLString:     Result := 'CHARACTER';
    tkWString:     Result := 'CHARACTER';
    tkInt64:       Result := 'INTEGER';
  end;
end;

(* Conversor de tipo Básico do Delphi --> para Tipos Básicos do SQLite3 *)
function  TypeKindToSQLite3(tkTypeKind:TTypeKind):String;
begin
  (* Os tipos comentados ainda Não foram implementados ... *)
  Result := 'TEXT';//'Unknown';
  case tkTypeKind of
    tkInteger:     Result := 'INTEGER';
    tkChar:        Result := 'TEXT';
    tkEnumeration: Result := 'INTEGER';
    tkFloat:       Result := 'REAL';
    tkString:      Result := 'TEXT';
    tkSet:         Result := 'TEXT';
    tkClass:       Result := 'BLOB';
    tkWChar:       Result := 'TEXT';
    tkLString:     Result := 'TEXT';
    tkWString:     Result := 'TEXT';
    tkInt64:       Result := 'INTEGER';
  end;
end;

(* Conversor de tipo Básico do Delphi --> para Tipos Básicos do Oracle *)
function  TypeKindToOracle(tkTypeKind:TTypeKind):String;
begin
  (* Os tipos comentados ainda Não foram implementados ... *)
  Result := 'VARCHAR';//'Unknown';
  case tkTypeKind of
    tkInteger:     Result := 'INTEGER';
    tkChar:        Result := 'CHAR';
    tkEnumeration: Result := 'INTEGER';
    tkFloat:       Result := 'DOUBLE';
    tkString:      Result := 'VARCHAR';
    tkSet:         Result := 'VARCHAR';
    tkClass:       Result := 'BLOB';
    tkWChar:       Result := 'CHAR';
    tkLString:     Result := 'VARCHAR';
    tkWString:     Result := 'VARCHAR';
    tkVariant:     Result := 'BLOB';
    tkInt64:       Result := 'NUMBER';
  end;
end;

(* Conversor de tipo Básico do Delphi --> para Tipos Básicos do ADO *)
function  TypeKindToADO(tkTypeKind:TTypeKind):String;
begin
  (* Os tipos comentados ainda Não foram implementados ... *)
  Result := 'VARCHAR';//'Unknown';
  case tkTypeKind of
    tkInteger:     Result := 'INTEGER';
    tkChar:        Result := 'CHAR';
    //tkEnumeration: Result := 'Enumeration';
    tkFloat:       Result := 'DOUBLE';
    tkString:      Result := 'VARCHAR';
    tkSet:         Result := 'VARCHAR';
    tkClass:       Result := 'BLOB';
    //tkMethod:      Result := 'Method';
    tkWChar:       Result := 'CHAR';
    tkLString:     Result := 'VARCHAR';
    tkWString:     Result := 'VARCHAR';
    tkVariant:     Result := 'BLOB';
    //tkArray:       Result := 'Array';
    //tkRecord:      Result := 'Record';
    //tkInterface:   Result := 'Interface';
    tkInt64:       Result := 'BIGINT';
    //tkDynArray:    Result := 'DynArray';
  end;
end;

(* funcoes para tipos conhecidos, tipos básicos do delphi para um tipo básico do banco *)
function DelphiTypeNameToFirebird(DelphiNameType:String;VersionCore:Integer;DialectCore:Integer):String;
var
  i,x:integer;
begin
  Result := UpperCase(DelphiNameType);
  x:= -1;
  for i:=0 to Length(DelphiTypeNames)-1 do
    if SameText(DelphiNameType , DelphiTypeNames[i]) then
      x:= i;
  case x of
    0..2  : Result := 'CHAR';            //'CHAR','ANSICHAR','WIDECHAR'
    3..6  : Result := 'VARCHAR';         //'STRING','SHORTSTRING','ANSISTRING','WIDESTRING'
    7..8  : Result := 'BLOB';            //'TBLOBDATA','TBITMAP'
    9..11 : Result := 'SMALLINT';        //'BYTE','SHORTINT','SMALLINT',
    12..17:begin
             if DialectCore = 3 then
                Result := 'BIGINT'       //'LONGWORD','CARDINAL','WORD','INTEGER','LONGINT','INT64'
             else
                Result := 'INTEGER';     //'LONGINT','INT64'
           end;
    18..21: Result := 'DOUBLE PRECISION';//'SINGLE','DOUBLE','EXTENDED','REAL'
        22: Result := 'NUMERIC[18,4]';   //'CURRENCY'
    23..25:begin
             if DialectCore = 3 then
               Result := 'TIMESTAMP' //'TDATE','TTIME','TDATETIME'
             else
               begin
                 case x of
                   23: Result := 'DATE';     //'TDATE'
                   24: Result := 'TIME';     // 'TTIME'
                   25: Result := 'TIMESTAMP';//'TDATETIME'
                 end;
               end;
           end;
    26  : Result := 'BLOB';   //'TBLOBDATA','TBITMAP'
  end;
end;

function  DelphiTypeNameToPostgreSQL(DelphiNameType:String;VersionCore:Integer;DialectCore:Integer):String;
begin
  ShowMessage(' falta implementar,use como base TypeNameToFirebird()  ');
end;

function  DelphiTypeNameToSQLite3(DelphiNameType:String;VersionCore:Integer;DialectCore:Integer):String;
begin
  ShowMessage(' falta implementar,use como base TypeNameToFirebird()  ');
end;

function  DelphiTypeNameToOracle(DelphiNameType:String;VersionCore:Integer;DialectCore:Integer):String;
begin
  ShowMessage(' falta implementar,use como base TypeNameToFirebird()  ');
end;

function  DelphiTypeNameToADO(DelphiNameType:String;VersionCore:Integer;DialectCore:Integer):String;
begin
  ShowMessage(' falta implementar,use como base TypeNameToFirebird()  ');
end;

(* conversao inversa  com base em nomes apenas *)
function FirebirdTypeNameToDelphi(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):String;
var
  i,x:integer;
begin
  Result := DatabaseNameType;
  x:= -1;
  for i:=0 to Length(FirbirdTypeNames)-1 do
    if SameText(DatabaseNameType , FirbirdTypeNames[i]) then
      x:= i;
 (*
 'CHAR','VARCHAR','SMALLINT','INTEGER','BIGINT',
 'FLOAT','DOUBLE PRECISION','DATE','TIME','TIMESTAMP',
 'DECIMAL','NUMERIC','BLOB',TEXT);
 *)
  case x of
    0 : Result := 'Char';
    1 : Result := 'String';
    2 : Result := 'Smallint';
    3 : Result := 'Integer';
    4 : Result := 'Int64';
    5 : Result := 'Float';
    6 : Result := 'Double';
    7 : Result := 'TDate';
    8 : Result := 'TTime';
    9 : Result := 'TDateTime';
   10..11: Result := 'Extended';
   12 : Result := 'TBlobData';
  end;
end;

function PostgreSQLTypeNameToDelphi(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):String;
begin

end;

function SQLite3TypeNameToDelphi(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):String;
begin

end;

function OracleTypeNameToDelphi(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):String;
begin

end;

function ADOTypeNameNameToDelphi(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):String;
begin

end;

function DelphiTypeNameToDelphiTypeKind(DelphiNameType:String):TTypeKind;
var
  i,x:integer;
begin
  Result := tkUnknown;
  x:= -1;
  for i:=0 to Length(DelphiTypeNames)-1 do
    if SameText(DelphiNameType , DelphiTypeNames[i]) then
      x:= i;
  case x of
    0..2   : Result := tkChar;
    3..6   : Result := tkString;
    7..8   : Result := tkClass;  //para blob
    9..11  : Result := tkInteger;
    12..13 : Result := tkInt64;
    14..16 : Result := tkInteger;
        17 : Result := tkInt64;
    18..25 : Result := tkFloat;
    26     : Result := tkDynArray; // adicionado depois do xe3
  end;
end;

function FirebirdTypeNameToDelphiTypeKind(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):TTypeKind;
var
  i,x:integer;
begin
  Result := tkUnknown;
  x:= -1;
  for i:=0 to Length(FirbirdTypeNames)-1 do
    if SameText(DatabaseNameType , FirbirdTypeNames[i]) then
      x:= i;
  case x of
    0  : Result := tkChar;
    1  : Result := tkString;
    2  : Result := tkFloat;
    3  : Result := tkInteger;
    4  : Result := tkInt64;
    5..11  : Result := tkFloat;
    12: Result := tkClass;
  end;
end;

function PostgreSQLTypeNameToDelphiTypeKind(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):TTypeKind;
begin
  Result := tkUnknown;
end;

function SQLite3TypeNameToDelphiTypeKind(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):TTypeKind;
begin
  Result := tkUnknown;

end;

function OracleTypeNameToDelphiTypeKind(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):TTypeKind;
begin
  Result := tkUnknown;

end;

function ADOTypeNameNameToDelphiTypeKind(DatabaseNameType:String;VersionCoreDB,DialectCoreDB:Integer):TTypeKind;
begin
  Result := tkUnknown;

end;

procedure SetDefaultsTypeReflection(var DataReflection:TDataReflection; tpKind:TTypeKind; ReferenceReflections:TReflection);
var
  i:integer;
  class_table_name,
  column_property_name,
  column_property_descript:String;
  column_data_size,
  column_data_size_scale : Int64;
begin
  column_data_size       := 0;
  column_data_size_scale := 0;

  for i:=0 to length(ReferenceReflections)-1 do
  begin
    if  (DataReflection.TypeReflection = ReferenceReflections[i].TypeReflection)
    and (SameText(DataReflection.DataTypeName,ReferenceReflections[i].DataTypeName)) then
    begin
      column_data_size       := 0;
      column_data_size_scale := 0;

      if DataReflection.DataSize <> 0
        then column_data_size  := DataReflection.DataSize
        else column_data_size  := ReferenceReflections[i].DataSize;

      if DataReflection.DataSizeScale <> 0
        then column_data_size_scale := DataReflection.DataSizeScale
        else column_data_size_scale := ReferenceReflections[i].DataSizeScale;

      class_table_name         := DataReflection.ClassOrTableName;
      column_property_name     := DataReflection.PropertyOrColumnName;
      column_property_descript := DataReflection.PropertyOrColumnDescript;

     // DataReflection           := ReferenceReflections[i];

      DataReflection.ClassOrTableName         := class_table_name;         // '' para tipos,aqui devolve o valor para campos
      DataReflection.PropertyOrColumnName     := column_property_name;     // '' para tipos,aqui devolve o valor para campos
      DataReflection.PropertyOrColumnDescript := column_property_descript; // '' para tipos,aqui devolve o valor para campos

      if (column_data_size <> DataReflection.DataSize)
      then
        begin
          DataReflection.DataSize    := column_data_size;
          DataReflection.DisplaySize := column_data_size;
        end;
      if column_data_size_scale <> DataReflection.DataSizeScale
        then  DataReflection.DataSizeScale := column_data_size_scale;
    end;
  end;
end;

(* Tratamento para propriedades do tipo Set
   Semelhante a ConvertEnumeration, com a diferença que o campo que conterá o
   resultado será um string de 255 o que permitirá guardar enumerações com no
   máximo 85 elementos - Limitação do framework.
   Mas também se o programador precisar mais que isso, sugiro fazer associamento
   master-detalhe.
*)
procedure ConvertStringAndSetToDelphi(var AReflection:TDataReflection);
  function ResultTypeName(var ref:TDataReflection):String;
  begin
    Result := ref.DataTypeName;
    if (ref.DataSize in [0..255]) then
    begin
      if (ref.NativeType = ntUnknow) then
        ref.DataTypeName     := format('%s'  ,[TypeKindToStr(ref.BasicTypeKind)]);

      if (ref.DataSize = 0) then
        ref.FullNameDelphiType := format('%s',[TypeKindToStr(ref.BasicTypeKind)])
      else
        ref.FullNameDelphiType := format('%s[%d]',[TypeKindToStr(ref.BasicTypeKind),ref.DataSize])
    end
      else
        ref.FullNameDelphiType := 'TBlobData';
  end;
begin
  (* TIPOS DE STRING  *)
  case AReflection.BasicTypeKind of
    tkChar,
    tkString,
    tkWChar,
    tkLString,
    tkWString,
    tkSet:
    begin
      if AReflection.BasicTypeKind = tkSet then
      begin
        AReflection.DataSize      := 0;
        AReflection.DataSizeScale := 0;
      end;

      case AReflection.NativeType of
        //ntDatabase: AReflection.DataTypeName       := DatabaseTypeNameToDelphi(AReflection.DataTypeName,AReflection.TypeDatabase,AReflection.VersionCoreDB,AReflection.DialectCoreDB);
        ntDelphiAndDatabase:
          begin
            AReflection.DataTypeName       := ResultTypeName(AReflection);
            if (AReflection.DataSize in [1..255]) then
              AReflection.FullNameDelphiType := format('%s[%d]',[TypeKindToStr(AReflection.BasicTypeKind),AReflection.DataSize])
            else if (AReflection.DataSize = 0) then
                   AReflection.FullNameDelphiType := format('%s',[TypeKindToStr(AReflection.BasicTypeKind)]);
          end;
        ntUnknow: AReflection.DataTypeName       := DatabaseTypeNameToDelphi(AReflection.DataTypeName,AReflection.TypeDatabase,AReflection.VersionCoreDB,AReflection.DialectCoreDB);
      end;

      if (AReflection.DataSize in [0..255]) then
      begin
        if (AReflection.DataSize = 0) then
          AReflection.FullNameDelphiType := format('%s',[TypeKindToStr(AReflection.BasicTypeKind)])
        else
          AReflection.FullNameDelphiType := format('%s[%d]',[TypeKindToStr(AReflection.BasicTypeKind),AReflection.DataSize])
      end
        else
          AReflection.FullNameDelphiType := 'TBlobData';
    end;
  end;
end;


(* Tratamento para propriedades do tipo Set
   Semelhante a ConvertEnumeration, com a diferença que o campo que conterá o
   resultado será um string de 255 o que permitirá guardar enumerações com no
   máximo 85 elementos - Limitação do framework.
   Mas também se o programador precisar mais que isso, sugiro fazer associamento
   master-detalhe.
*)

procedure ConvertStringAndSetToDatabase(var AReflection:TDataReflection);
begin
  with AReflection do
  begin
    (* TIPOS DE STRING  *)
    case BasicTypeKind of
      tkChar,
      tkString,
      tkWChar,
      tkLString,
      tkWString,
      tkSet:
      begin
        if BasicTypeKind = tkSet then
        begin
          DataSize      := 0;
          DataSizeScale := 0;
        end;

        if DataSize > 255 then
        begin
          if NativeType <> ntUnknow then
            DataTypeName := 'BLOB';
          case TypeDatabase of
            tdbFirebird:  FullNameDatabaseType := 'BLOB';
            tdbPostgreSQL:FullNameDatabaseType := 'BLOB';
            tdbSQLite3:   FullNameDatabaseType := 'BLOB';
            tdbOracle:    FullNameDatabaseType := 'BLOB';
//            tdbADO:       FullNameDatabaseType := 'BLOB';
          end;
        end
        else
          if DataSize in [1..255] then
          begin
            case TypeDatabase of
              tdbFirebird:
              begin
                if NativeType <> ntUnknow then
                  DataTypeName := TypeKindToFirebird(BasicTypeKind);
                FullNameDatabaseType := format('%s(%d)',[TypeKindToFirebird(BasicTypeKind),DataSize]);
              end;
              tdbPostgreSQL:
              begin
                if NativeType <> ntUnknow then
                  DataTypeName := TypeKindToPostgreSQL(BasicTypeKind);
                FullNameDatabaseType := format('%s(%d)',[TypeKindToPostgreSQL(BasicTypeKind),DataSize]);
              end;
              tdbSQLite3:
              begin
                if NativeType <> ntUnknow then
                  DataTypeName := TypeKindToSQLite3(BasicTypeKind);
                FullNameDatabaseType := format('%s(%d)',[TypeKindToSQLite3(BasicTypeKind),DataSize]);
              end;
              tdbOracle:
              begin
                if NativeType <> ntUnknow then
                  DataTypeName := TypeKindToOracle(BasicTypeKind);
                FullNameDatabaseType := format('%s(%d)',[TypeKindToOracle(BasicTypeKind),DataSize]);
              end;
//              tdbADO:
//              begin
//                if NativeType <> ntUnknow then
//                  DataTypeName := TypeKindToADO(BasicTypeKind);
//                FullNameDatabaseType := format('%s(%d)',[TypeKindToADO(BasicTypeKind),DataSize]);
//              end;
            end;
          end
          else   (*  zero *)
            case TypeDatabase of
              tdbFirebird:
              begin
                if NativeType <> ntUnknow then
                  DataTypeName := TypeKindToFirebird(BasicTypeKind);
                FullNameDatabaseType := format('%s(%d)',[TypeKindToFirebird(BasicTypeKind),255]);
              end;
              tdbPostgreSQL:
              begin
                if NativeType <> ntUnknow then
                  DataTypeName := TypeKindToPostgreSQL(BasicTypeKind);
                FullNameDatabaseType := format('%s(%d)',[TypeKindToPostgreSQL(BasicTypeKind),255]);
              end;
              tdbSQLite3:
              begin
                if NativeType <> ntUnknow then
                  DataTypeName := TypeKindToSQLite3(BasicTypeKind);
                FullNameDatabaseType := format('%s(%d)',[TypeKindToSQLite3(BasicTypeKind),255]);
              end;
              tdbOracle:
              begin
                if NativeType <> ntUnknow then
                  DataTypeName := TypeKindToOracle(BasicTypeKind);
                FullNameDatabaseType := format('%s(%d)',[TypeKindToOracle(BasicTypeKind),255]);
              end;
//              tdbADO:
//              begin
//                if NativeType <> ntUnknow then
//                  DataTypeName := TypeKindToADO(BasicTypeKind);
//                FullNameDatabaseType := format('%s(%d)',[TypeKindToADO(BasicTypeKind),255]);
//              end;
            end;
      end;
    end;
  end;
end;

procedure ConvertIntegerToDatabase(var AReflection:TDataReflection);
begin
  with AReflection do
  begin
    (* Integer Types  *)
    case BasicTypeKind of
      tkInteger:
      begin
        if  (DataSize        >=    Low(ShortInt))
        and (DataSize        <         Low(Byte))
        and (DataSizeScale  in         [1..127]) then
        begin
          case TypeDatabase of
            tdbFirebird  :FullNameDatabaseType:= 'SMALLINT';
            tdbPostgreSQL:FullNameDatabaseType:= 'SMALLINT';
            tdbSQLite3   :FullNameDatabaseType:= 'SMALLINT';
            tdbOracle    :FullNameDatabaseType:= 'SMALLINT';
//            tdbADO       :FullNameDatabaseType:= 'SMALLINT';
          end;
        end
        else
          if  (DataSize      in [0..255])
          and (DataSizeScale in [1..255]) then // 1 ... MIAL, pulo enorme do gato
          begin
            case TypeDatabase of
              tdbFirebird  :FullNameDatabaseType:= 'SMALLINT';
              tdbPostgreSQL:FullNameDatabaseType:= 'SMALLINT';
              tdbSQLite3   :FullNameDatabaseType:= 'SMALLINT';
              tdbOracle    :FullNameDatabaseType:= 'SMALLINT';
//              tdbADO       :FullNameDatabaseType:= 'SMALLINT';
            end;
          end
          else
            if  (DataSize        <   Low(ShortInt))
            and (DataSize        >=  Low(Smallint))
            and (DataSizeScale   >   High(ShortInt))
            and (DataSizeScale   <=  High(Smallint)) then
            begin
              case TypeDatabase of
                tdbFirebird  :FullNameDatabaseType := 'SMALLINT';
                tdbPostgreSQL:FullNameDatabaseType := 'SMALLINT';
                tdbSQLite3   :FullNameDatabaseType := 'SMALLINT';
                tdbOracle    :FullNameDatabaseType := 'SMALLINT';
//                tdbADO       :FullNameDatabaseType := 'SMALLINT';
              end;
            end
            else
              if  (DataSize      >=     Low(Word))
              and (DataSizeScale >      Low(Word))
              and (DataSizeScale <=    High(Word)) then
              begin
                case TypeDatabase of
                  tdbFirebird  :FullNameDatabaseType:= TypeKindToFirebird(tkInteger);
                  tdbPostgreSQL:FullNameDatabaseType:= TypeKindToPostgreSQL(tkInteger);
                  tdbSQLite3   :FullNameDatabaseType:= TypeKindToSQLite3(tkInteger);
                  tdbOracle    :FullNameDatabaseType:= TypeKindToOracle(tkInteger);
//                  tdbADO       :FullNameDatabaseType:= TypeKindToADO(tkInteger);
                end;
              end
              else
                begin
                  (*  INTEGER E LONGINT *)
                  case TypeDatabase of
                    tdbFirebird  :FullNameDatabaseType:= TypeKindToFirebird(tkInteger);
                    tdbPostgreSQL:FullNameDatabaseType:= TypeKindToPostgreSQL(tkInteger);
                    tdbSQLite3   :FullNameDatabaseType:= TypeKindToSQLite3(tkInteger);
                    tdbOracle    :FullNameDatabaseType:= TypeKindToOracle(tkInteger);
//                    tdbADO       :FullNameDatabaseType:= TypeKindToADO(tkInteger);
                  end;
                end;
      end;
      tkInt64:
      begin
        case TypeDatabase of
          tdbFirebird   : FullNameDatabaseType:= TypeKindToFirebird(tkInt64);
          tdbPostgreSQL : FullNameDatabaseType:= TypeKindToPostgreSQL(tkInt64);
          tdbSQLite3    : FullNameDatabaseType:= TypeKindToSQLite3(tkInt64);
          tdbOracle     : FullNameDatabaseType:= TypeKindToOracle(tkInt64);
        end;
      end;
    end;
  end;
end;

procedure ConvertIntegerToDelphi(var AReflection:TDataReflection);
begin
  with AReflection do
  begin
    (* Integer Types  *)
    case BasicTypeKind of
      tkInt64,tkInteger:
      begin
        if  (DataSize        >=    Low(ShortInt))
        and (DataSize        <         Low(Byte))
        and (DataSizeScale  in         [1..127]) then
        begin
          if NativeType <> ntUnknow then
            DataTypeName        := 'dps_Shortint';
          FullNameDelphiType    := 'Shortint';
        end
        else
          if  (DataSize      in [0..255])
          and (DataSizeScale in [1..255]) then  // 1 ... MIAL, pulo enorme do gato
          begin
            if NativeType <> ntUnknow then
              DataTypeName        := 'dps_Byte';
            FullNameDelphiType    := 'Byte';
          end
          else
            if  (DataSize        <    Low(ShortInt))
            and (DataSize        >=   Low(Smallint))
            and (DataSizeScale   >   High(ShortInt))
            and (DataSizeScale   <=  High(Smallint)) then
            begin
              if NativeType <> ntUnknow then
                  DataTypeName      := 'dps_Smallint';
              FullNameDelphiType    := 'Smallint';
            end
            else
              if  (DataSize      >=     Low(Word))
              and (DataSizeScale >      Low(Word))
              and (DataSizeScale <=    High(Word)) then
              begin
                if NativeType <> ntUnknow then
                    DataTypeName      := 'dps_Word';
                FullNameDelphiType    := 'Word';
              end
              else
                if  (DataSize        <=   Low(Integer))
                and (DataSize         <   Low(Byte))
                and (DataSizeScale    >   Low(Byte))
                and (DataSizeScale   <=   High(Integer)) then
                begin
                  (*  INTEGER E LONGINT *)
                  if NativeType <> ntUnknow then
                    DataTypeName        := 'dps_Integer';
                  FullNameDelphiType    := 'Integer';
                end
                else
                  if  (DataSize         >=   Low(Cardinal))
                  and (DataSize         <=  High(Cardinal))
                  and (DataSizeScale    >=   Low(Cardinal)+1)// pula gatinho! MIALLLLLLL
                  and (DataSizeScale    <=  High(Cardinal))then
                  begin
                    (*  CARDINAL E LONGWORD *)
                    if NativeType <> ntUnknow then
                      DataTypeName        := 'dps_Cardinal';
                    FullNameDelphiType    := 'Cardinal';
                  end
                  else
                    begin
                      if NativeType <> ntUnknow then
                        DataTypeName          := 'dps_Int64';
                      FullNameDelphiType      := 'Int64';
                    end;
      end;
    end;
  end;
end;

(*
  Como regra geral estabeleci o seguinte:

  Conversões de ponto flutuante sempre serão tratadas como NUMERIC (Firebird)
  ou eQuivalente em outros bancos,devido a precisão dos dígitos decimais a esquerda
  que é mais precisa neste tipo.

  *  a escala nunca pode ser maior que a precisão:
  ex:
    Numeric[10,12]  (errado)
    Numeric[12,12]  (certo)

    Precisão e escala não especificado ou igual a zero o retorno será = DOUBLE PRECISION
    Escala  = 4 Sempre será currency
*)
procedure ConvertFloatToDatabase(var AReflection:TDataReflection);
begin
  (* Real Types  *)
  case AReflection.BasicTypeKind of
  tkFloat:
    begin
      if AReflection.NativeType <> ntUnknow then
      begin
       // AReflection.DataTypeName := Format('DPS_%s',[DatabaseTypeNameToDelphi(AReflection.OriginalDataTypeName,AReflection.TypeDatabase,AReflection.VersionCoreDB,AReflection.DialectCoreDB)]);
        AReflection.FullNameDatabaseType := DelphiTypeNameToDatabase(AReflection.OriginalDataTypeName,
                                                                     AReflection.TypeDatabase,
                                                                     AReflection.VersionCoreDB,
                                                                     AReflection.DialectCoreDB);
      end;

      (* Data Size Negativo , será usado para identificar Campos Tipo DATA *)
      case AReflection.DataSize of
      -1:begin
           AReflection.DataTypeName := DatabaseTypeNameToDelphi(AReflection.OriginalDataTypeName,AReflection.TypeDatabase,AReflection.VersionCoreDB,AReflection.DialectCoreDB);
           AReflection.FullNameDatabaseType:= 'DATE';
         end;
      -2:begin
           AReflection.DataTypeName := DatabaseTypeNameToDelphi(AReflection.OriginalDataTypeName,AReflection.TypeDatabase,AReflection.VersionCoreDB,AReflection.DialectCoreDB);
           AReflection.FullNameDatabaseType:= 'TIME';
         end;
      -3:begin
           AReflection.DataTypeName := DatabaseTypeNameToDelphi(AReflection.OriginalDataTypeName,AReflection.TypeDatabase,AReflection.VersionCoreDB,AReflection.DialectCoreDB);
           AReflection.FullNameDatabaseType:= 'TIMESTAMP';
         end
        else   //--> case
          (* DataSizeScale quando é 4 SEMPRE Currency *)
          if  (AReflection.DataSizeScale = 4) then
            begin
              AReflection.FullNameDatabaseType:= 'NUMERIC[18,4]';
            end
              else
                if  (AReflection.DataSize      in [1..3])
                and (AReflection.DataSizeScale in [1..3]) then
                begin
                  AReflection.DataTypeName := Format('DPS_%s',[DatabaseTypeNameToDelphi(AReflection.OriginalDataTypeName,AReflection.TypeDatabase,AReflection.VersionCoreDB,AReflection.DialectCoreDB)]);
                  if AReflection.DataSizeScale < AReflection.DataSize then
                    AReflection.DataSizeScale := AReflection.DataSize;
                  case AReflection.TypeDatabase of
                    tdbFirebird  :AReflection.FullNameDatabaseType := Format('NUMERIC(%d,%d)',[AReflection.DataSize,AReflection.DataSizeScale]);
                    tdbPostgreSQL:AReflection.FullNameDatabaseType := Format('NUMERIC(%d,%d)',[AReflection.DataSize,AReflection.DataSizeScale]);
                    tdbSQLite3   :AReflection.FullNameDatabaseType := Format('NUMERIC(%d,%d)',[AReflection.DataSize,AReflection.DataSizeScale]);
                    tdbOracle    :AReflection.FullNameDatabaseType := Format('NUMERIC(%d,%d)',[AReflection.DataSize,AReflection.DataSizeScale]);
        //              tdbADO       :FullNameDatabaseType := Format('NUMERIC[%d,%d]',[DataSize,DataSizeScale]);
                  end;
                end
                else
                  if  (AReflection.DataSize      in [4..18])
                  and (AReflection.DataSizeScale in [5..18]) then
                  begin
//                    AReflection.DataTypeName := Format('DPS_%s',[DatabaseTypeNameToDelphi(AReflection.OriginalDataTypeName,AReflection.TypeDatabase,AReflection.VersionCoreDB,AReflection.DialectCoreDB)]);
                    if (AReflection.DataSizeScale > AReflection.DataSize) then
                      AReflection.DataSizeScale := AReflection.DataSize;

                    case AReflection.TypeDatabase of
                      tdbFirebird  :AReflection.FullNameDatabaseType:= Format('NUMERIC(%d,%d)',[AReflection.DataSize,AReflection.DataSizeScale]);
                      tdbPostgreSQL:AReflection.FullNameDatabaseType:= Format('NUMERIC(%d,%d)',[AReflection.DataSize,AReflection.DataSizeScale]);
                      tdbSQLite3   :AReflection.FullNameDatabaseType:= Format('NUMERIC(%d,%d)',[AReflection.DataSize,AReflection.DataSizeScale]);
                      tdbOracle    :AReflection.FullNameDatabaseType:= Format('NUMERIC(%d,%d)',[AReflection.DataSize,AReflection.DataSizeScale]);
        //              tdbADO       :FullNameDatabaseType:= Format('NUMERIC[%d,%d]',[DataSize,DataSizeScale]);
                    end;
                  end
                  else
                    begin
                      //AReflection.DataTypeName := Format('DPS_%s',[DatabaseTypeNameToDelphi(AReflection.OriginalDataTypeName,AReflection.TypeDatabase,AReflection.VersionCoreDB,AReflection.DialectCoreDB)]);
                      AReflection.FullNameDatabaseType := 'DOUBLE PRECISION';
                    end;
      end;
    end;
  end;
end;

(*
   Regra !

   Data size Negativos = Tipos data (TDate,TTime,TDateTime)

   Data size Zero      = Tipo Float com maior capacidade (Extended)

   Data size superior a Zero = Nº de casas a Esquerda do separador decimal
   data SizeScale é o Nº de casas a Direita do separador decimal.

*)
procedure ConvertFloatToDelphi(var AReflection:TDataReflection);
begin
  with AReflection do
  begin
    (* Real Types  *)
    case BasicTypeKind of
      tkFloat:
      begin
        case DataSize of
        -1:
          begin
            if NativeType <> ntUnknow then
              DataTypeName     := 'dps_TDate';
            FullNameDelphiType := 'TDate';
          end;
        -2:
          begin
            if NativeType <> ntUnknow then
                DataTypeName   := 'dps_TTime';
            FullNameDelphiType := 'TTime';
          end;
        -3:
          begin
            if NativeType <> ntUnknow then
              DataTypeName     := 'dps_TDateTime';
            FullNameDelphiType := 'TDateTime';
          end;
        else // do case
          (* DataSizeScale quando é 4 SEMPRE  será convertida em Currency seguindo o padrão para currency  *)
          if  (DataSizeScale = 4) then
          begin
            if NativeType <> ntUnknow then
              DataTypeName        := 'dps_Currency';
            FullNameDelphiType    := 'Currency';
          end
          else
            if  (DataSize      in [1..3])
            and (DataSizeScale in [1..3]) then
            begin
              if NativeType <> ntUnknow then
                DataTypeName     := 'dps_Single';
              FullNameDelphiType := 'Single';
            end
            else
              if  (DataSize      in [4..18])
              and (DataSizeScale in [5..18]) then
              begin
                if NativeType <> ntUnknow then
                  DataTypeName     := 'dps_Double';
                FullNameDelphiType := 'Double';
              end
              else
                begin
                  if NativeType <> ntUnknow then
                    DataTypeName     := 'dps_Extended';
                  FullNameDelphiType := 'Extended';
                end;
        end;
      end;
    end;
  end;
end;


(* Tratamento para propriedades do tipo enumeração
  Será armazenado no banco de dados o índice referente ao atributo,
  o programador deverá lembrar que NUNCA deve alterar a ordem da enumeração
  para não haver problemas, para as propriedades com este tipo básico o
  software poderá buscar a lista de valores "amigáveis" ao usuário na
  propriedade [FriendlyValues] que é um array de String.
 *)
procedure ConvertEnumerationToDatabase(var AReflection:TDataReflection);
begin
  with AReflection do
  begin
    case BasicTypeKind of
      tkEnumeration:
      begin
        if (trim(DefaultValue) = '')then
          DefaultValue := '0';
        if (FriendlyValues <> nil) and (length(FriendlyValues) > 0)  then
        begin
          (* enumeração vai ser gravado no banco integer, aqui gravo o range permitido *)
          SetLength(DatabaseCheck,1);
//          DatabaseCheck[0] := format('(value >= 0 and value <= %s )',[ insttostr(length(FriendlyValues)-1) ]);;
        end;

        if NativeType <> ntUnknow then
          case TypeDatabase of
            tdbFirebird  :DataTypeName:= 'INTEGER';
            tdbPostgreSQL:DataTypeName:= 'INTEGER';
            tdbSQLite3   :DataTypeName:= 'INTEGER';
            tdbOracle    :DataTypeName:= 'INTEGER';
//            tdbADO       :DataTypeName:= 'INTEGER';
          end;

        case TypeDatabase of
          tdbFirebird  :FullNameDatabaseType:= 'INTEGER';
          tdbPostgreSQL:FullNameDatabaseType:= 'INTEGER';
          tdbSQLite3   :FullNameDatabaseType:= 'INTEGER';
          tdbOracle    :FullNameDatabaseType:= 'INTEGER';
//          tdbADO       :FullNameDatabaseType:= 'INTEGER';
        end;
      end;
    end;
  end;
end;

procedure ConvertEnumerationToDelphi(var AReflection:TDataReflection);
begin
  case AReflection.BasicTypeKind of
    tkEnumeration:
    begin
      if (trim(AReflection.DefaultValue) = '')then
        AReflection.DefaultValue := '0';

      if (AReflection.FriendlyValues <> nil) and (length(AReflection.FriendlyValues) > 0)  then
      begin
        (* enumeração vai ser gravado no banco integer, aqui gravo o range permitido *)
        SetLength(AReflection.DatabaseCheck,1);
        AReflection.DatabaseCheck[0] := format('(value >= 0 and value <= %d )',[length(AReflection.FriendlyValues)-1]);
      end;

      if AReflection.NativeType = ntUnknow then
        AReflection.DataTypeName        := 'dps_Integer';
      AReflection.FullNameDelphiType    := 'Integer';
    end;
  end;
end;

procedure ConvertClassToDatabase(var AReflection:TDataReflection);
begin
  with AReflection do
  begin
    (* Tipo Blob,como classe *)
    case BasicTypeKind of
      tkClass,tkDynArray:FullNameDatabaseType := 'BLOB';
    end;
  end;
end;

procedure ConvertClassToDelphi(var AReflection:TDataReflection);
begin
  with AReflection do
  begin
    (* Tipo Blob, como classe ou string > 255 *)
    case BasicTypeKind of
      tkClass,tkDynArray:
      begin
        FullNameDelphiType := 'TBlobData';
        if NativeType <> ntUnknow then
          DataTypeName := 'dps_Blob';
      end;
    end;
  end;
end;

function  DelphiTypeNameToDatabase(DelphiNameType:String;Database:TTypeOfDatabase;VersionCoreDB:Integer=0;DialectCoreDB:Integer=0):String;
begin
  case Database of
    tdbFirebird:   Result := DelphiTypeNameToFirebird(DelphiNameType,VersionCoreDB,DialectCoreDB);
    tdbPostgreSQL: Result := DelphiTypeNameToPostgreSQL(DelphiNameType,VersionCoreDB,DialectCoreDB);
    tdbSQLite3:    Result := DelphiTypeNameToSQLite3(DelphiNameType,VersionCoreDB,DialectCoreDB);
    tdbOracle:     Result := DelphiTypeNameToOracle(DelphiNameType,VersionCoreDB,DialectCoreDB);
//    tdbAdo:        Result := DelphiTypeNameToADO(DelphiNameType,VersionCoreDB,DialectCoreDB);
  end;
end;

function  DatabaseTypeNameToDelphi(DatabaseNameType:String;Database:TTypeOfDatabase;VersionCoreDB:Integer=0;DialectCoreDB:Integer=0):String;
begin
  case Database of
    tdbFirebird:   Result := FirebirdTypeNameToDelphi(DatabaseNameType,VersionCoreDB,DialectCoreDB);
    tdbPostgreSQL: Result := PostgreSQLTypeNameToDelphi(DatabaseNameType,VersionCoreDB,DialectCoreDB);
    tdbSQLite3:    Result := SQLite3TypeNameToDelphi(DatabaseNameType,VersionCoreDB,DialectCoreDB);
    tdbOracle:     Result := OracleTypeNameToDelphi(DatabaseNameType,VersionCoreDB,DialectCoreDB);
//    tdbAdo:        Result := ADOTypeNameNameToDelphi(DatabaseNameType,VersionCoreDB,DialectCoreDB);
  end;
end;

function  DatabaseTypeNameToDelphiTypeKind(DatabaseNameType:String;Database:TTypeOfDatabase;VersionCoreDB:Integer=0;DialectCoreDB:Integer=0):TTypeKind;
begin
  Result := tkString;
  case Database of
    tdbFirebird:   Result := FirebirdTypeNameToDelphiTypeKind(DatabaseNameType,VersionCoreDB,DialectCoreDB);
    tdbPostgreSQL: Result := PostgreSQLTypeNameToDelphiTypeKind(DatabaseNameType,VersionCoreDB,DialectCoreDB);
    tdbSQLite3:    Result := SQLite3TypeNameToDelphiTypeKind(DatabaseNameType,VersionCoreDB,DialectCoreDB);
    tdbOracle:     Result := OracleTypeNameToDelphiTypeKind(DatabaseNameType,VersionCoreDB,DialectCoreDB);
//    tdbAdo:        Result := ADOTypeNameNameToDelphiTypeKind(DatabaseNameType,VersionCoreDB,DialectCoreDB);
  end;
end;


function GeraMD5(sTexto: string): String;
Var
  md5:TIdHashMessageDigest5;
begin
  md5    := TIdHashMessageDigest5.Create;
  Result := md5.HashStringAsHex(sTexto);
end;

end.
