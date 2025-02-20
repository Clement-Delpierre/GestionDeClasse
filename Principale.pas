unit Principale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, System.JSON, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, System.Generics.Collections;

type
  TEleve = class
    Fnom : string;
    Fprenom : string;
    Fmoyenne : string;
    Ftelephone : string;
    constructor Create(nom, prenom, moyenne, telephone : string);
  end;

  TProfesseur = class
    Fnom : string;
    Fmatiere : string;
  end;

  TClasse = class(TObjectList<TEleve>)
    Fprof_principal : TProfesseur;
  end;

  TForm1 = class(TForm)
    fenetre_liste: TListView;
    edit_prenom: TEdit;
    edit_nom: TEdit;
    edit_moyenne: TEdit;
    edit_telephone: TEdit;
    btn_ajout: TButton;
    btn_retrait: TButton;
    btn_sauvegarde: TButton;
    btn_edit: TButton;
    edt_professeur: TEdit;
    edt_prof_matiere: TEdit;
    btn_prof: TButton;
    lbl_nom_prof: TLabel;
    lbl_matiere_prof: TLabel;
    lbl_prof_principal: TLabel;
    lbl_eleve_telephone: TLabel;
    lbl_moyenne: TLabel;
    lbl_eleve_nom: TLabel;
    lbl_eleve_prenom: TLabel;
    btn_afficher_prof: TButton;
    btn_load: TButton;
    edt_loadFile: TEdit;
    lbl_loadedFile: TLabel;
    btntruc: TButton;
    LoadJSON: TButton;
    procedure Initialisation(Sender: TObject);
    procedure btn_ajoutClick(Sender: TObject);
    procedure btn_retraitClick(Sender: TObject);
    procedure btn_sauvegardeBinaireClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure SelectionChange(Sender: TObject);
    procedure btn_definirProfClick(Sender: TObject);
    procedure btn_afficher_profClick(Sender: TObject);
    procedure btn_loadBinaireClick(Sender: TObject);
    procedure WriteStringFile(fs : TFileStream; contenu : string);
    procedure AjoutEleveVue(eleve : TEleve);
    function ReadStringFile(fs : TFileStream) : string;
    procedure SaveJSON(Sender: TObject);
    procedure LoadJSONClick(Sender: TObject);
    procedure Reset();
  private
    Feleves : TClasse;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Initialisation(Sender: TObject);
/// <summary>
/// Initialise le programme
/// </summary>
begin
  self.Feleves := TClasse.Create;
  self.Feleves.Fprof_principal := TProfesseur.Create;
  Feleves.Fprof_principal.Fnom := '';
  Feleves.Fprof_principal.Fmatiere := '';
end;

procedure TForm1.Reset();
/// <summary>
/// Reset la liste des �l�ves et leur affichage
/// </summary>
begin
  for var i := (Feleves.Count - 1) downto 0 do
  begin
    Self.Feleves.Delete(i);
    Self.fenetre_liste.Items[i].Delete;
  end;
  Feleves.Fprof_principal.Fnom := '';
  Feleves.Fprof_principal.Fmatiere := '';
end;

constructor TEleve.Create(nom, prenom, moyenne, telephone : string);
begin
  Fnom := nom;
  Fprenom := prenom;
  Fmoyenne := moyenne;
  Ftelephone := telephone;
end;

procedure TForm1.SelectionChange(Sender: TObject);
/// <summary>
/// Affiche les informations de l'�l�ve s�lectionn�
/// </summary>
var
  i : Integer;
begin
  if Self.fenetre_liste.Selected <> nil then
  begin
    i := Self.fenetre_liste.Selected.Index;

    Form1.edit_nom.Text := Self.Feleves.Items[i].Fnom;
    Form1.edit_prenom.Text := Self.Feleves.Items[i].Fprenom;
    Form1.edit_moyenne.Text := Self.Feleves.Items[i].Fmoyenne;
    Form1.edit_telephone.Text := Self.Feleves.Items[i].Ftelephone;
  end;
end;

procedure TForm1.btn_afficher_profClick(Sender: TObject);
/// <summary>
/// Affiche les informations du professeur principal enregistr�
/// </summary>
begin
  if (self.Feleves.Fprof_principal = nil) then
    ShowMessage('Il n y a pas de professeur principal !')
  else
  begin
    edt_professeur.Text := self.Feleves.Fprof_principal.Fnom;
    edt_prof_matiere.Text := self.Feleves.Fprof_principal.Fmatiere;
  end
end;

procedure TForm1.btn_ajoutClick(Sender: TObject);
/// <summary>
/// Cr�er un �l�ve � partir des informations entr�es, l'ajoute � la liste et l'affiche
/// </summary>
begin
  Self.Feleves.Add(TEleve.Create(
                                Form1.edit_nom.Text,
                                Form1.edit_prenom.Text,
                                Form1.edit_moyenne.Text,
                                Form1.edit_telephone.Text
                                ));
  AjoutEleveVue(Feleves.Last);
end;

procedure TForm1.AjoutEleveVue(eleve : TEleve);
/// <summary>
/// Affiche l'�l�ve pass� en param�tre
/// </summary>
var
  ligne : TListItem;
begin
  ligne := Self.fenetre_liste.Items.Add;

  ligne.Caption := eleve.Fnom;
  ligne.SubItems.Add(eleve.Fprenom);
  ligne.SubItems.Add(eleve.Fmoyenne);
  ligne.SubItems.Add(eleve.Ftelephone);
end;

procedure TForm1.btn_retraitClick(Sender: TObject);
/// <summary>
/// Supprime un �l�ve de la liste et de l'affichage
/// </summary>
begin
  if Self.fenetre_liste.Selected <> nil then
  begin
    var i := Self.fenetre_liste.Selected.Index;
    Self.Feleves.Delete(i);
    Self.fenetre_liste.Items[i].Delete;
  end
  else
  ShowMessage('Choisissez l eleve a supprimer');
end;

procedure TForm1.btn_editClick(Sender: TObject);
/// <summary>
/// Modifie l'�l�ve s�lectionn� � partir des informations entr�es
/// </summary>
var
  i : integer;
begin
  if Self.fenetre_liste.Selected <> nil then
  begin
    i := Self.fenetre_liste.Selected.Index;
    Self.Feleves.Items[i].Fnom := Form1.edit_nom.Text;
    Self.Feleves.Items[i].Fprenom := Form1.edit_prenom.Text;
    Self.Feleves.Items[i].Fmoyenne := Form1.edit_moyenne.Text;
    Self.Feleves.Items[i].Ftelephone := Form1.edit_telephone.Text;

    Self.fenetre_liste.Items[i].Caption := Self.Feleves.Items[i].Fnom;
    Self.fenetre_liste.Items[i].SubItems[0] := Self.Feleves.Items[i].Fprenom;
    Self.fenetre_liste.Items[i].SubItems[1] := Self.Feleves.Items[i].Fmoyenne;
    Self.fenetre_liste.Items[i].SubItems[2] := Self.Feleves.Items[i].Ftelephone;
  end
  else
  ShowMessage('Choississez l eleve a editer');
end;

procedure TForm1.SaveJSON(Sender: TObject);
/// <summary>
/// Sauvegarde les donn�es �l�ves et professeur dans un fichier JSON
/// </summary>
begin
  // Cr�ation du JSONArray des �l�ves
  var eleves := TJSONArray.Create;

  // Cr�ation et ajout des JSONObject �l�ves au JSONArray
  for var eleve in self.Feleves do
  begin
    var eleveJSON := TJSONObject.Create;
    eleveJSON.AddPair('nom', eleve.Fnom);
    eleveJSON.AddPair('prenom', eleve.Fprenom);
    eleveJSON.AddPair('moyenne', eleve.Fmoyenne);
    eleveJSON.AddPair('telephone', eleve.Ftelephone);
    eleves.Add(eleveJSON);
  end;

  // Cr�ation du JSONObject professeur
  var professeur := TJSONObject.Create;
  professeur.AddPair('Nom', self.Feleves.Fprof_principal.Fnom);
  professeur.AddPair('Mati�re', self.Feleves.Fprof_principal.Fmatiere);

  // Cr�ation du JSONObject classe
  var classe := TJSONObject.Create;
  classe.AddPair('professeur', professeur);
  classe.AddPair('eleves', eleves);

  // Enregistrement du JSON final dans un fichier
  var ss := TStringStream.Create(classe.ToString);
  ss.SaveToFile('../../fichierJSON.txt');

  classe.Free;
  ss.Free;
end;

procedure TForm1.LoadJSONClick(Sender: TObject);
/// <summary>
/// Charge les donn�es �l�ves et professeur � partir d'un fichier JSON
/// </summary>
/// <exception cref="EFOpenError"></exception>
///  <exception cref="EJSONException"></exception>
begin
  if edt_loadFile.Text = '' then
    ShowMessage('Veuillez indiquer un fichier')
  else
  begin
    var ss := TStringStream.Create;
    try
      try
        ss.LoadFromFile(edt_loadFile.Text);
        var str_tmp := ss.ReadString(ss.Size);

        var jsonInput := TJSONObject.ParseJSONValue(str_tmp);

        var professeur := jsonInput.GetValue<TJSONObject>('professeur');
        self.edt_professeur.Text := professeur.GetValue<string>('Nom');
        self.edt_prof_matiere.Text := professeur.GetValue<string>('Mati�re');

        Reset();
        var eleves := jsonInput.GetValue<TJSONArray>('eleves');
        for var eleve in eleves do
        begin
          Self.Feleves.Add(TEleve.Create(
                                    eleve.GetValue<string>('nom'),
                                    eleve.GetValue<string>('prenom'),
                                    eleve.GetValue<string>('moyenne'),
                                    eleve.GetValue<string>('telephone')
                                    ));
          AjoutEleveVue(Feleves.Last);
        end;
      except
        on e : EFOpenError do
          ShowMessage('Veuillez indiquer un nom de fichier valide');
        on e : EJSONException do
          ShowMessage('Le fichier n est pas au format JSON !');
      else
        ShowMessage('Fichier inexistant ou au mauvais format');
      end;
    finally
      ss.Free;
    end;
  end;
end;

procedure TForm1.btn_loadBinaireClick(Sender: TObject);
/// <summary>
/// Charge les donn�es �l�ves � partir d'un fichier binaire
/// </summary>
/// <exception cref="EFOpenError"></exception>
/// <exception cref="EIntOverflow"></exception>
var
  _fileStream : TFileStream;
  i : integer;
  ligne : TListItem;
  nom_tmp, prenom_tmp, moyenne_tmp, telephone_tmp : string;
begin
  if edt_loadFile.Text = '' then
    ShowMessage('Veuillez indiquer un fichier')
  else
  begin
    _fileStream := nil;
    try
      try
        _fileStream := TFileStream.Create(edt_loadFile.Text, fmOpenRead);

        i := 0;
        while _fileStream.Size <> _fileStream.Position do
        begin
           nom_tmp := ReadStringFile(_fileStream);
           prenom_tmp := ReadStringFile(_fileStream);
           moyenne_tmp := ReadStringFile(_fileStream);
           telephone_tmp := ReadStringFile(_fileStream);

           Self.Feleves.Add(TEleve.Create(nom_tmp, prenom_tmp,
                                          moyenne_tmp, telephone_tmp));

           AjoutEleveVue(Feleves[i]);
           i := i + 1;
        end;
      except
        on e : EFOpenError do
          ShowMessage('Fichier introuvable');
        on e : EIntOverflow do
          ShowMessage('Veuillez verifier le format de votre fichier');
      else
        ShowMessage('Une erreur est survenue, veuillez verifier le format de votre fichier');
      end;
    finally
      if _fileStream <> nil then
         _fileStream.Free;
    end;
  end;
end;

function TForm1.ReadStringFile(fs : TFileStream) : string;
/// <summary>
/// Lit et renvoie le prochain string du FileStream
/// </summary>
var
  _tailleChaine : Integer;
  _machaine : string;
begin
  fs.Read(_tailleChaine, SizeOf(Integer));
  SetLength(_machaine, _tailleChaine);
  fs.Read(_machaine[1], _tailleChaine * SizeOf(Char));

  Result := _machaine;
end;

procedure TForm1.btn_definirProfClick(Sender: TObject);
/// <summary>
/// Enregistre un nouveau professeur pour la classe � partir des informations entr�es
/// </summary>
begin
  self.Feleves.Fprof_principal.Fnom := edt_professeur.Text;
  self.Feleves.Fprof_principal.Fmatiere := edt_prof_matiere.Text;
end;

procedure TForm1.WriteStringFile(fs : TFileStream; contenu : string);
/// <summary>
/// �crit le string (param.1) dans le FileStream (param.2)
/// </summary>
var
  _tailleChaine : Integer;
  _machaine : string;
begin
  _tailleChaine := Length(contenu);
  fs.Write(_tailleChaine, SizeOf(Integer));

  _machaine := contenu;
  fs.Write(_machaine[1], _machaine.Length * SizeOf(char));
end;

procedure TForm1.btn_sauvegardeBinaireClick(Sender: TObject);
/// <summary>
/// Sauvegarde les donn�es �l�ves � partir d'un fichier binaire
/// </summary>
var
  _fileStream : TFileStream;
  _tailleChaine : Integer;
  _machaine : string;
  i : integer;
begin
  _fileStream := TFileStream.Create('../../test.txt', fmCreate);
  for i := 0 to Form1.Feleves.Count - 1 do
  begin
    WriteStringFile(_fileStream, Form1.Feleves[i].Fnom);
    WriteStringFile(_fileStream, Form1.Feleves[i].Fprenom);
    WriteStringFile(_fileStream, Form1.Feleves[i].Fmoyenne);
    WriteStringFile(_fileStream, Form1.Feleves[i].Ftelephone);
  end;
  _fileStream.Free;
end;
end.
