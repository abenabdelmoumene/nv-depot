Partie 1 — Constater et qualifier la panne
1-Affichez l'état du service horodatage. Relevez son état (active / failed / autre) et le code d'erreur affiché.
    systemctl status horodatage
error : Jul 20 15:59:32 srv-linux-test systemd[1]: Failed to start horodatage.service - Horodatage - journalise la date toutes>

Partie 2
1-Le programme pointé par ExecStart existe-t-il ? (ls -l sur le chemin)
    ls -l /usr/local/bin/horodatage = no such file or directory
    id horodata : no such user

Partie 3 => 2 erreurs (chemin & user inconnu)
Avant : ExecStart=/usr/local/bin/horodatage.sh  => chemin inconnu
Apres : ExecStart=/opt/horodatage/horodatage.sh => chemin OK

ajout de l'user horodata :
sudo adduser horodata
= sudo adduser --system --group --no-create-home --shell /usr/sbin/nologin horodatage
utilisateur system sans groupe ni repertoire, sans connexion dans le chemin "" appelé horodata


sudo systemctl daemon-reload
sudo systemctl restart horodatage
systemctl status horodatage

systemctl is-active horodatage && systemctl is-enabled horodatage

/AIDE\ = cat /etc/systemd/system/horodatage.sh


Restart =on-failure = si script crash, permet de relancer le script

arreter brutalement un script =
sudo kill -9 "PID" = tue processus brutal SIGKILL
systemctl start horodatage = inactive actuellement