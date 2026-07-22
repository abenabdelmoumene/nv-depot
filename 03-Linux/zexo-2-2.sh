/!\ CREATION DU SCRIPT => CREATION DE L'UNITE
Partie 1 — Installer et tester le script à la main
1/Installez le script ci-dessus dans /usr/local/bin/inventaire.py
    sudo mkdir -p /usr/local/bin/inventaire.py

2/Rendez-le exécutable pour tout le monde, lisible mais modifiable uniquemt par root
    sudo chmod 755 /usr/local/bin/inventaire.py
    7 = xwr ; 5 = xr
    sudo chmod u=rwx,g=rx,o=r x /usr/local/bin/inventaire.py

3/Créez le répertoire de destination /var/lib/inventaire.
sudo mkdir -p /var/lib/inventaire

4/Exécutez le script à la main
    sudo /usr/local/bin/inventaire.py



Partie 2 — Écrire l'unité
1/Créez le fichier /etc/systemd/system/inventaire.service avec : Unit/Service/Install
sudo nano /etc/systemd/system/inventaire.service
[Unit]
Description=Information sur le PC et le stockage

[Service]
Type=oneshot
ExecStart = /usr/bin/python3 /usr/local/bin/inventaire.py

[Install]
WantedBy=multi-user.target

2/Faites connaître la nouvelle unité à systemd.
    sudo syste daemon-reload

3/Supprimez le rapport existant
    sudo rm /var/lib/inventaire/rapport.txt
    ls -l /var/lib/inventaire/rapport.txt = no such file or directory
    sudo systemctl daemon-reload = MAJ systemd
    sudo systemctl start inventaire.service
    ls -l /var/lib/inventaire/rapport.txt = le rapport.txt a été recrée suite au script
-rw-r--r-- 1 root root 185 Jul 21 09:40 /var/lib/inventaire/rapport.txt

4/ sudo journalctl -u inventaire.service


