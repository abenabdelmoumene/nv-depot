mode_jeu = {
    1: "solo",
    2: "multi"
}

for mode_nb,mode in mode_jeu.items():
    print(mode_nb,mode)

choix_utilisateur = int(input("Selectionnez votre mode de jeu : "))
if choix_utilisateur == 1:
    print("Vous avez selectionné le mode solo")
elif choix_utilisateur==2:
    print("Vous avez selectionné le mode multi")

nombre_joueur1 = int(input("joueur 1 veuillez entrer un nombre entre 0 et 100: "))

while True:
    nombre_joueur2 = int(input("joueur 2 veuillez entrer un nombre entre 0 et 100: "))

    if nombre_joueur2 < 0 or nombre_joueur2 > 100 :
        print("le numero est invalide, veuillez choisir un numero entre 0 et 100")
        continue

    elif nombre_joueur2 < nombre_joueur1 :
        print("TROP BAS")
        
    elif nombre_joueur2 > nombre_joueur1 :
        print("TROP HAUT")

    else:
        print("FELICITATION")
    break


    
for pain in ["baguette", "croissant"]:
    print(pain)
#affichage mot par mot à la suite :
#baguette
#croissant

#numero_joueur1 = int(input("Joueur 1 veuillez choisir un nombre entre 0 à 100 : "))
#numero_joueur2 = int(input("Joueur 2 veuillez choisir un nombre entre 0 à 100 : "))

#numero_mystere = int(input("Joueur 1 veuillez trouver le nombre choisi par le Joueur 2 : "))

#if numero_mystere == numero_joueur2:
#    print("FELICITATION")

#elif numero_mystere > numero_joueur2:
#        print("TROP HAUT")

#elif numero_mystere < numero_joueur2:
#        print("TROP BAS")
