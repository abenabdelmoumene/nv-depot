Creer un script bonjour.sh:
sudo nano /usr/local/bin/bonjour.sh = creer un nvx fichier nommé bonjour.sh en privilege Administrateur.
sudo chmod +x /usr/local/bin/bonjour.sh = donne les droits executable
/usr/local/bin/bonjour.sh = executer le script en 1er plan
/usr/local/bin/bonjour.sh & = executer le script en arriere-plan




sudo nano /etc/systemd/system/bonjour.service = creer une unité bonjour.service
sudo systemctl daemon-reload = recharger le fichiers pour MAJ systemd
sudo systemctl start bonjour
systemctl status bonjour = affiche le status du service
sudo systemctl enable bonjour = enable au boot 


troobleshoot error script: 
status
journalctl -u | grep ""

Dans un terminal : Ctrl + C = arreter le script en 1er plan.
Avec systemd → sudo systemctl stop bonjour.service
En arrière-plan → kill %1 ou kill PID





Provoquer un echec :
sudo sed -i 's|/usr/local/bin/bonjour.sh|/usr/local/bin/bonjjour.sh|' /etc/systemd/system/bonjour.s
ervice  = creer une erreur
sudo systemctl restart bonjour = redemmarer le service
systemctl status bonjour.service = verifier status du service
journalctl -u bonjour -n 10 --no-pager = affiche les 10 dernieres ligne du journalctl sans menu interactif (--no-pager)





