menu = [("Croissant", 1.00), ("Café",1.20), ("Thé",0.90), ("Sandwich",2.30)]
solde_utilisateur = 50
print("vous avez un solde de :", solde_utilisateur, "€")

print("========== MENU ==========")

for produit,prix in menu:
    print(produit,prix, "€")

choix = input("Veuillez faire votre choix :")

for produit,prix in menu:
    if choix == produit:
        print("vous avez choisi un",choix,",votre solde est à present de", solde_utilisateur-prix, "€")
        break
else:
    print("article indisponible")
