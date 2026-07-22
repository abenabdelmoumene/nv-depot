Grep = Filtrer  / Awk = extraire des colones
grep -i error /var/log/syslog = -i (ignore case), recherche error, ERROR, Error, etc.
grep -c "session opened" = -c (count) : compte le nombre de lignes contenant "session opened"
sudo grep -r "Failed password" /var/log  = -r = recherche recursivement ds tt les fichier du repertoire /var/log
sudo grep -riE "error|failed|critical" /var/log/nginx = récursif + ignore la casse + pls motifs (Etendu)
grep -v "^#" /etc/ssh/sshd_config = -v (invert match) : affiche les lignes qui ne correspondent pas au motif.

df -h = affiche l'espace disque utilisé/disponible sur les systèmes de fichiers

df -h | awk '{print $5 $6}' = (awk) affiche la colonne de l'argument 5 et 6 de la comma df (disk free)
ps aux | awk '{print $2 $8}'= affiche la 2e et 8e collone de la commande ps (processus)

############################################################################################################
sed -i : modifier une config sans ouvrir d'éditeur'
sed 's/ancien/nouveau/'

echo "port=8000" > app.conf
sed 's/8000/9000/' app.conf #en faisant cat app.conf,affiche tjrs 8000
sed -i.bak 's/8000/9000/' app.conf # -i : modifie le fichier, .bak = copie (port =8000)
cat app.conf = affiche : port = 9000
#cat app.conf.bak = affiche 8000

sed -i 's/8000/9000/' app.conf = ecrase le fichier app.conf pour afficher 9000.
############################################################################################################
Partie 1 — Squelette du script et validation des arguments
Partie 2 — Compression et suppression

Script de Compression + Supression de + 1 jours
#!/usr/bin/env bash
set -euo pipefail
CLEAN_DIR="${1:-/var/log/appdemo}" #1er argument = repertoire a nettoyer
RETENTION="${2:-7}"  #2eme argument = l'age max en jour des arhcives compressées


if [ ! -d "$CLEAN_DIR" ]; then  #Si le dossier a nettoyer n'existe pas alors(! -d)
 echo "[$(date '+%F %T')] Erreur : Le dossier "$CLEAN_DIR" est inexistant" >&2
 exit 1  #arrete le script car erreur
fi

echo "[$(date '+%F %T')] Nettoyage de $CLEAN_DIR (rétention $RETENTION jours)"

#compression des fichiers.log du dossier, il y a + de 1j compressés en .log.gz. Fichier du jour intact.
NB_COMPRESSES=$(find "$CLEAN_DIR" -maxdepth 1 -name "*.log" -mtime +0 | wc -l) #compte nb fichier à compresser
find "$CLEAN_DIR"  -maxdepth 1 -name "*.log" -mtime +0 -exec gzip {} \; # compression des fichiers trouvés en .log.gz

#suppression
NB_SUPPRIMES=$(find "$CLEAN_DIR" -maxdepth 1 -name "*.log.gz" -mtime +"$RETENTION" | wc -l) #compte nb fichier à suppri>
find "$CLEAN_DIR"  -maxdepth 1 -name "*.log.gz" -mtime +"$RETENTION" -delete #suppresion des fichiers trouvés en .log.gz

echo "Fichiers compressés: $NB_COMPRESSES"
echo "Archives supprimées : $NB_SUPPRIMES"
exit 0

2/ Le rendre executable :
sudo chmod +x ~/exploitation/scripts/nettoie-logs.sh

3/ Executer le script:
sudo ./exploitation/scripts/nettoie-logs.sh

######################################################################################
Partie 3 — Planification le script avec Cron

crontad -e (ouvre editeur cron pour planifier le script tout les 4h)
0 4 * * * /home/ubuntu/exploitation/scripts/nettoie-logs.sh >> / home/ubuntu/exploitation/rapports/nettoie-logs.journal 2>&1

######################################################################################
Partie 3 — Planification le script avec Systemd
sudo nano /etc/systemd/system/nettoie-logs.service
[Unit]
Description=Nettoyage des logs de /var/log/appdemo

[Service]
Type=oneshot
ExecStart=/home/ubuntu/exploitation/script/nettoie-logs.sh
User=ubuntu #executer uniquement par ubuntu, non pas root.

sudo nano /etc/systemd/system/nettoie-logs.timer
[Unit]
Description=Planification du nettoyage des logs
[Timer]
OnCalendar=*-*-* 04:00:00
Persistent=true
[Install]
WantedBy=timers.target

sudo systemctl daemon-reload
sudo systemctl start nettoie-logs.service && nettoie-logs.timer





