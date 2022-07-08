object Form1: TForm1
  Left = 0
  Top = 0
  Anchors = [akTop]
  Caption = ' '
  ClientHeight = 379
  ClientWidth = 856
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  CustomTitleBar.ShowCaption = False
  CustomTitleBar.ShowIcon = False
  Constraints.MaxHeight = 418
  Constraints.MaxWidth = 872
  Constraints.MinHeight = 418
  Constraints.MinWidth = 872
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = Initialisation
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_nom_prof: TLabel
    Left = 529
    Top = 320
    Width = 91
    Height = 13
    Caption = 'Nom du Professeur'
  end
  object lbl_matiere_prof: TLabel
    Left = 522
    Top = 347
    Width = 106
    Height = 13
    Caption = 'Matiere du Professeur'
  end
  object lbl_prof_principal: TLabel
    Left = 528
    Top = 274
    Width = 94
    Height = 13
    Caption = 'Professeur Principal'
  end
  object lbl_eleve_telephone: TLabel
    Left = 543
    Top = 142
    Width = 50
    Height = 13
    Caption = 'Telephone'
  end
  object lbl_moyenne: TLabel
    Left = 546
    Top = 103
    Width = 44
    Height = 13
    Caption = 'Moyenne'
  end
  object lbl_eleve_nom: TLabel
    Left = 558
    Top = 67
    Width = 21
    Height = 13
    Caption = 'Nom'
  end
  object lbl_eleve_prenom: TLabel
    Left = 550
    Top = 29
    Width = 36
    Height = 13
    Caption = 'Prenom'
  end
  object lbl_loadedFile: TLabel
    Left = 528
    Top = 181
    Width = 80
    Height = 13
    Caption = 'Fichier a charger'
  end
  object fenetre_liste: TListView
    Left = 20
    Top = 15
    Width = 491
    Height = 348
    Columns = <
      item
        Caption = 'nom'
        Width = 130
      end
      item
        Alignment = taCenter
        Caption = 'prenom'
        Width = 150
      end
      item
        Alignment = taCenter
        Caption = 'moyenne'
        Width = 100
      end
      item
        Alignment = taCenter
        Caption = 'telephone'
        Width = 100
      end>
    ColumnClick = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = SelectionChange
  end
  object edit_prenom: TEdit
    Left = 623
    Top = 24
    Width = 121
    Height = 21
    Alignment = taCenter
    TabOrder = 1
  end
  object edit_nom: TEdit
    Left = 623
    Top = 61
    Width = 121
    Height = 21
    Alignment = taCenter
    TabOrder = 2
  end
  object edit_moyenne: TEdit
    Left = 623
    Top = 99
    Width = 121
    Height = 21
    Alignment = taCenter
    TabOrder = 3
  end
  object edit_telephone: TEdit
    Left = 623
    Top = 138
    Width = 121
    Height = 21
    Alignment = taCenter
    TabOrder = 4
  end
  object btn_ajout: TButton
    Left = 766
    Top = 24
    Width = 65
    Height = 25
    Caption = '+'
    TabOrder = 5
    OnClick = btn_ajoutClick
  end
  object btn_retrait: TButton
    Left = 766
    Top = 60
    Width = 65
    Height = 25
    Caption = '-'
    TabOrder = 6
    OnClick = btn_retraitClick
  end
  object btn_sauvegarde: TButton
    Left = 766
    Top = 135
    Width = 65
    Height = 25
    Caption = 'Save'
    TabOrder = 7
    OnClick = btn_sauvegardeBinaireClick
  end
  object btn_edit: TButton
    Left = 766
    Top = 98
    Width = 65
    Height = 25
    Caption = 'Edit'
    TabOrder = 8
    OnClick = btn_editClick
  end
  object edt_professeur: TEdit
    Left = 646
    Top = 316
    Width = 153
    Height = 21
    TabOrder = 9
  end
  object edt_prof_matiere: TEdit
    Left = 646
    Top = 344
    Width = 153
    Height = 21
    TabOrder = 10
  end
  object btn_prof: TButton
    Left = 646
    Top = 254
    Width = 153
    Height = 25
    Caption = 'Definir professeur principal'
    TabOrder = 11
    OnClick = btn_definirProfClick
  end
  object btn_afficher_prof: TButton
    Left = 646
    Top = 284
    Width = 153
    Height = 25
    Caption = 'Afficher professeur principal'
    TabOrder = 12
    OnClick = btn_afficher_profClick
  end
  object btn_load: TButton
    Left = 624
    Top = 213
    Width = 97
    Height = 24
    Caption = 'Load'
    TabOrder = 13
    OnClick = btn_loadBinaireClick
  end
  object edt_loadFile: TEdit
    Left = 623
    Top = 175
    Width = 121
    Height = 21
    TabOrder = 14
  end
  object btntruc: TButton
    Left = 766
    Top = 174
    Width = 65
    Height = 25
    Caption = 'Save JSON'
    TabOrder = 15
    OnClick = SaveJSON
  end
  object LoadJSON: TButton
    Left = 735
    Top = 213
    Width = 97
    Height = 25
    Caption = 'Load JSON'
    TabOrder = 16
    OnClick = LoadJSONClick
  end
end
