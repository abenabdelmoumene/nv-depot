Creer une nouvelle machine virtuelle Ubuntu :
multipass launch 24.04 --name srv-linux --cpus 2 --memory 4G --disk 20G --cloud-init cloud_init.yaml

Si tout fonctionne, tu verras un prompt similaire à :
ubuntu@srv-linux:~$

Se connecter à une machine virtuelle : 
multipass shell srv-linux         #correction
multipass shell srv-linux-test    #exercice

################
Exercice 1-2 — Droits d'un répertoire partagé
################

1-Creer un user + password :
sudo adduser alice

2-Crer un groupe :
sudo addgroup projet

3-Ajouter des utilisateurs au groupe : user modify
sudo usermod -aG projet alice              #-aG : etre membre du group projet en + de leur groupes deja affectés avant.

4- verifier si elle appartient bien au group projet :
id alice

5- se connecter sur Alice :
su - alice    #demande de password ensuite.

--verifier si un utilisateurs à les droits admin :
sudo ls -la /root

6- getent group projet

7- sudo mkdir -p /srv/partage = permet de creer le dossier avec les droits sudo

8- ls -ld /srv/partage

9- Changer le proprietaire : Le proprietaire:root et groupe:projet
sudo chown root:projet /srv/partage
### permet de gerer acces/permission aux fichiers.

d=dossier  : proprietaire-group-utilisateurs
drwxr-xr-x

10- setgid:2 permission : 770
sudo chmod 2770 /srx/partage
2 : Sans setgid :
Alice crée un fichier → groupe = groupe personnel d'Alice

2 : Avec setgid :
Alice (membre du groupe projet) crée :
touch rapport.txt

Le fichier aura :
-rw-rw---- alice projet rapport.txt
et non :
-rw-rw---- alice alice rapport.txt

su - alice  : switch user vers alice

































