animaux =[]
nb=int(input("combien as-tu d'animeaux ? "))

for i in range(nb):
    ni=i+1
    nom = input(f"Nom de l'animal numero {ni} :")
    animaux.append(nom)

print (f"Tu as {ni} animaux :")

for i in range(nb):
    print(f"{i+1}) {animaux[i]}")

