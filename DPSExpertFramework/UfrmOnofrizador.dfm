object frmOnofrizador: TfrmOnofrizador
  Left = 402
  Top = 186
  BorderStyle = bsSingle
  Caption = 'Onofrizador de banco de dados....'
  ClientHeight = 356
  ClientWidth = 485
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 485
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object rcEditInfo: TRichEdit
      Left = 0
      Top = 0
      Width = 485
      Height = 62
      TabStop = False
      Align = alClient
      BevelInner = bvNone
      BevelKind = bkFlat
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object pnlMidle: TPanel
    Left = 0
    Top = 62
    Width = 485
    Height = 301
    Align = alTop
    TabOrder = 1
    object ntbookGeraClasses: TNotebook
      Left = 1
      Top = 1
      Width = 483
      Height = 299
      Align = alClient
      TabOrder = 0
      object TPage
        Left = 0
        Top = 0
        Caption = 'selecao_database'
        object Panel2: TPanel
          Left = 2
          Top = 68
          Width = 479
          Height = 182
          TabOrder = 0
          object gpboxConfigAcesso: TGroupBox
            Left = 4
            Top = 4
            Width = 472
            Height = 144
            Caption = 'Configura'#231#245'es de acesso:'
            TabOrder = 0
            object Label1: TLabel
              Left = 172
              Top = 57
              Width = 40
              Height = 14
              Caption = 'Usu'#225'rio:'
            end
            object Label2: TLabel
              Left = 172
              Top = 98
              Width = 34
              Height = 14
              Caption = 'Senha:'
            end
            object lblHost: TLabel
              Left = 8
              Top = 58
              Width = 25
              Height = 14
              Caption = 'Host:'
            end
            object Label5: TLabel
              Left = 8
              Top = 99
              Width = 28
              Height = 14
              Caption = 'Porta:'
            end
            object Label3: TLabel
              Left = 334
              Top = 57
              Width = 126
              Height = 14
              Caption = 'Sufixo para Datamanager:'
              Visible = False
            end
            object edtusuario: TEdit
              Left = 172
              Top = 73
              Width = 135
              Height = 20
              TabOrder = 3
              Text = 'SYSDBA'
            end
            object edtSenha: TEdit
              Left = 172
              Top = 114
              Width = 135
              Height = 20
              PasswordChar = '*'
              TabOrder = 4
              Text = 'masterkey'
            end
            object edt_path_banco: TEdit
              Left = 36
              Top = 31
              Width = 432
              Height = 20
              ReadOnly = True
              TabOrder = 0
            end
            object btnAbrirBanco: TButton
              Left = 7
              Top = 30
              Width = 24
              Height = 21
              Action = acLocalizarBanco
              Caption = '...'
              TabOrder = 5
            end
            object edtHost: TEdit
              Left = 8
              Top = 73
              Width = 135
              Height = 20
              TabOrder = 1
            end
            object edtPorta: TEdit
              Left = 8
              Top = 113
              Width = 135
              Height = 20
              TabOrder = 2
            end
          end
          object btnTestarConexao: TButton
            Left = 367
            Top = 152
            Width = 108
            Height = 26
            Action = acTesteConexao
            TabOrder = 1
          end
          object edtSufixoMasterDatamamanager: TEdit
            Left = 336
            Top = 77
            Width = 135
            Height = 20
            TabOrder = 2
            Text = 'MasterDataManager'
            Visible = False
          end
        end
        object cbDriverBanco: TComboBox
          Left = 13
          Top = 32
          Width = 461
          Height = 22
          Enabled = False
          ItemIndex = 6
          TabOrder = 1
          Text = 'Firebird 2.5 - Cliente/Servidor'
          Items.Strings = (
            'Firebird 1.5 - Cliente/Servidor'
            'Firebird 1.5 - Embarcado'
            'Firebird 2.0 - Cliente/Servidor'
            'Firebird 2.0 - Embarcado'
            'Firebird 2.1 - Cliente/Servidor'
            'Firebird 2.1 - Embarcado'
            'Firebird 2.5 - Cliente/Servidor'
            'Firebird 2.5 - Embarcado')
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'opcoes_geracao_classes'
        ExplicitWidth = 0
        ExplicitHeight = 0
        object chListBoxTabelas: TCheckListBox
          Left = 0
          Top = 25
          Width = 483
          Height = 274
          Align = alClient
          Columns = 2
          Ctl3D = False
          ItemHeight = 14
          ParentCtl3D = False
          TabOrder = 0
        end
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 483
          Height = 25
          Align = alTop
          BevelOuter = bvLowered
          TabOrder = 1
          object chBoxTodos: TCheckBox
            Left = 2
            Top = 4
            Width = 255
            Height = 17
            Caption = 'Todos:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = chBoxTodosClick
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'finaliza_importacao_modelos'
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnlFinalizaImportacao: TPanel
          Left = 0
          Top = 0
          Width = 483
          Height = 299
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object rgTypeCreatingUnits: TRadioGroup
            Left = 5
            Top = 83
            Width = 474
            Height = 69
            Caption = '  Forma de cria'#231#227'o dos modelos:'
            Enabled = False
            ItemIndex = 1
            Items.Strings = (
              'Criar uma Unit para cada Modelo.(recomendado)'
              'Criar todos os Modelos na mesma Unit.')
            TabOrder = 0
            Visible = False
          end
          object rgTypeCreatingGetterAndSetters: TRadioGroup
            Left = 5
            Top = 6
            Width = 474
            Height = 69
            Caption = 'Padr'#227'o para Get e Set'
            Enabled = False
            ItemIndex = 0
            Items.Strings = (
              'Padr'#227'o Delphi Resumido ( read F.... write F....) -(Recomendado)'
              'Padr'#227'o Delphi ( read F.... write Set....)'
              'Padr'#227'o Java   (read Get... write Set...)')
            TabOrder = 1
            Visible = False
          end
        end
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 313
    Width = 485
    Height = 43
    Align = alBottom
    TabOrder = 2
    object btnCancelaFinaliza: TBitBtn
      Left = 393
      Top = 3
      Width = 89
      Height = 38
      Action = acCancelar
      Caption = 'Cancelar'
      TabOrder = 1
    end
    object btnAnterior: TBitBtn
      Left = 304
      Top = 3
      Width = 89
      Height = 38
      Action = acAnterior
      Caption = 'Voltar'
      TabOrder = 0
    end
  end
  object opdlg_selecaoArquivo: TOpenDialog
    Left = 54
    Top = 370
  end
  object acListDpsFramework: TActionList
    Left = 85
    Top = 370
    object acTesteConexao: TAction
      Category = 'Wizard'
      Caption = 'Testar Conex'#227'o'
      Hint = 'Testar Conex'#227'o com Banco de Dados'
      ShortCut = 16468
      OnExecute = acTesteConexaoExecute
    end
    object acProximo: TAction
      Category = 'Wizard'
      Caption = 'Proximo'
      Hint = 'Pr'#243'ximo Passo...'
      ShortCut = 16462
    end
    object acAnterior: TAction
      Category = 'Wizard'
      Caption = 'Anterior'
      Hint = 'Retornar a Op'#231#227'o anterior.'
      ShortCut = 16450
      OnExecute = acAnteriorExecute
    end
    object acCancelar: TAction
      Category = 'Wizard'
      Caption = 'Cancelar'
      ShortCut = 16430
      OnExecute = acCancelarExecute
    end
    object acProcessar: TAction
      Category = 'Wizard'
      Caption = 'Processar'
      OnExecute = acProcessarExecute
    end
    object acLocalizarBanco: TAction
      Category = 'Wizard'
      Caption = 'Abrir Banco'
      Hint = 'Escolher o banco de dados que ser'#225' Onofrizado.'
      OnExecute = acLocalizarBancoExecute
    end
  end
end
