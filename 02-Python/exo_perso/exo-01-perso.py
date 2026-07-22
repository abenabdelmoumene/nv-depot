from datetime import date
nom = input("veuillez entrer votre nom : ") 

prenom = input("veuillez entrer votre prenom : ") 

age = int(input("veuillez entrer votre age : ")) #casting = transforme le input(string) -> Int

print("Bonjour", prenom, nom +",", "Vous avez", age, "ans !")

annee_naissance = int(input("veuillez entrer votre année de naissance :"))
annee_actuel = date.today().year

age_actuel = annee_actuel - annee_naissance
print("vous avez ",age_actuel)