import random

gobelet = [] #creation liste gobelet, reconnaissable avec []

for i in range (5):
    gobelet.append("gobelet")

print(gobelet)

#creation variable pour stocker la valeur aleatoire de 0 à 5.
position_balle = random.randint(0, 4)
#creation variable vies au nbre de 3
vies = 3

while vies > 0: #boucle pour melanger les gobelet (position_balle : change à chaque boucle)
    print("\nIl vous reste", vies, "tentatives.")

# choix du joueur
    choix = int(input("Choisissez un gobelet (1 à 5) : "))

    choix = choix - 1#si l'utilisateur entre 3, il s'agit de 2 pour l'ordinateur.

# Si choix utilisateur = la position de la balle OU pas !
    if choix == position_balle:
        print("Vous avez trouvé la balle ! ")
        break
    else:
        print("Il n'y a pas de balle sous ce gobelet.")
        vies = vies -1
        print("Il vous reste :", vies,"vies")













