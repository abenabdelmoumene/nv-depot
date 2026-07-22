menu = [("Croissant", 1.00), ("Café",1.20), ("Thé",0.90), ("Sandwich",2.30)]


print("========== MENU ==========")

for produit,prix in menu:
    print(produit,prix, "€")

choix = input("Veuillez faire votre choix :")

for produit,prix in menu:
    if choix == produit:
        print("vous avez choisi un",choix,",cela vous fera", prix, "€")
        break
else:
    print("article indisponible")
