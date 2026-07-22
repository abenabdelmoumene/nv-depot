notes = []#creation liste notes pour stocker les valeurs de l'utilisateur lorsqu'il entre ses notes.

while True:#boucle infini qui permet d'afficher le PROGRAMME NOTES apres chaque choix.
    print("\n=== PROGRAMME NOTES")
    print("1. Entrer une nouvelle note")
    print("2. Consulter l'ensemble des notes")
    print("3. Connaître la plus petite notes")
    print("4. Connaître la plus grande notes")
    print("5. Connaître la moyenne des notes")
    print("0. Quitter")

    choix_utilisateur=input("faites votre choix : ")

    match choix_utilisateur:
        case "1":
            note = float(input("1. Entrer une nouvelle note : "))
            notes.append(note)
            print("Note ajoutée :", note)

        case "2":
            print("2. Consulter l'ensemble des notes : ")
            print(notes)
        
        case "3":
            note_min=min(notes)
            print(f"3. Connaître la plus petite note {note_min}")
        
        case "4":
            note_max=max(notes)
            print(f"4. Connaître la plus grande note {note_max}")
        
        case "5":
            note_moy=sum(notes) / len(notes)
            print(f"5. Connaître la moyenne des note {note_moy}")
        
        case "0":
            print("Au revoir ! ")
            break



