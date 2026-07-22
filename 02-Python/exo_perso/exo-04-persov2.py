notes = []


def ajouter_note():
    matiere = input("Matière : ")
    nom = input("Nom : ")
    prenom = input("Prénom : ")
    classe = input("Classe : ")
    date = input("Date : ")
    heure = input("Heure : ")
    note = float(input("Note : "))

    notes.append({
        "matiere": matiere,
        "nom": nom,
        "prenom": prenom,
        "classe": classe,
        "date": date,
        "heure": heure,
        "note": note
    })

    print("Note ajoutée")


def afficher_notes():
    print("\n=== NOTES ===")

    for n in notes:
        print(
            n["nom"],
            n["prenom"],
            "|",
            n["matiere"],
            "| Note :", 
            n["note"]
        )


def calcul_matiere():
    matiere = input("Matière recherchée : ")

    liste = []

    for n in notes:
        if n["matiere"] == matiere:
            liste.append(n["note"])

    if len(liste) > 0:
        print("Plus petite :", min(liste))
        print("Plus grande :", max(liste))
        print("Moyenne :", sum(liste) / len(liste))
    else:
        print("Aucune note trouvée")


while True:

    print("\n=== PROGRAMME NOTES ===")
    print("1. Ajouter une note")
    print("2. Afficher les notes")
    print("3. Statistiques d'une matière")
    print("0. Quitter")

    choix = input("Choix : ")

    if choix == "1":
        ajouter_note()

    elif choix == "2":
        afficher_notes()

    elif choix == "3":
        calcul_matiere()

    elif choix == "0":
        print("Au revoir")
        break

    else:
        print("Choix incorrect")