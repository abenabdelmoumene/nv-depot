import random

# Liste des mots
mots = ["python", "voiture", "ordinateur", "maison", "chat"]

# Choix aléatoire d'un mot
mot = random.choice(mots)

# Variables du jeu
lettres = []
vies = 3

# Fonction qui affiche le mot caché
def afficher_mot(mot, lettres):
    for lettre in mot:
        if lettre in lettres:
            print(lettre, end=" ")
        else:
            print("_", end=" ")
    print()

# Boucle principale
while vies > 0:

    print("\nNombre de vies restantes :", vies)
    print("Lettres déjà essayées :", lettres)

    print("Mot à trouver :", end=" ")
    afficher_mot(mot, lettres)

    lettre = input("Quelle lettre voulez-vous essayer ? ").lower()

    # Vérifie si la lettre a déjà été essayée
    if lettre in lettres:
        print("Vous avez déjà essayé cette lettre.")
        continue

    # Ajoute la lettre à la liste
    lettres.append(lettre)

    # Vérifie si la lettre est dans le mot
    if lettre not in mot:
        vies -= 1
        print("Cette lettre n'est pas dans le mot.")

    # Vérifie si le joueur a gagné
    gagne = True

    for l in mot:
        if l not in lettres:
            gagne = False

    if gagne:
        print("\nBravo ! Vous avez trouvé le mot :", mot)
        break

# Si le joueur n'a plus de vies
if vies == 0:
    print("\nVous avez perdu !")
    print("Le mot était :", mot)