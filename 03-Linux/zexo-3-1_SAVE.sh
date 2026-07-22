##############################################
1er Version : script de sauvegarde_V1
##############################################

mkdir -p ~/scripts

cd ~/scripts

nano backup-v1.sh
#!/usr/bin/env bash
#v1 : ça marche, mais tout est en dur et rien n'est verifier
mkdir -p /var/backups/demo
tar -czf /var/backups/demo/etc-$(date '+%Y%m%d-%H%M%S').tar.gz -C / etc
echo "Sauvegarde terminée"

*/\*czf=creer fichier format compressé en .tar.gz

chmod +x backup-v1.sh 

sudo ./backup-v1.sh
    Sauvegarde terminée

ls -lh /var/backups/demo


##############################################
2eme Version : script de sauvegarde_V2
##############################################

nano backup-v2.sh
#!/usr/bin/env bash
#v2 : arguments avec valeurs par défaut - le script devient réutilisable
SOURCE_DIR=${1:-/etc}
DEST_DIR=${2:-/var/backups/demo}

mkdir -p "$DEST_DIR"
PREFIXE=$(basename "$SOURCE_DIR")
HORODATAGE=$(date '+%Y%m%d-%H%M%S')
tar -czf "$DEST_DIR/${PREFIXE}-${HORODATAGE}.tar.gz" -C "$(dirname "$SOURCE_DIR")" "$PREFIXE"
echo "Sauvegarde de $SOURCE_DIR terminée dans $DEST_DIR"


chmod +x backup-v2.sh
sudo ./backup-v2.sh /home /var/backups/demo    #/home:1er argumt  ; /var/backups/demo:2eme argumt
    Sauvegarde de /home terminée dans /var/backups/demo

#Faille du script = si un dossier est inexistant, fait une sauvegarde


##############################################
3eme Version : script de sauvegarde_V3
##############################################

#!/usr/bin/env bash
set -euo pipefail # stop à la 1re erreur & variable non définie, pipe cassé
SOURCE_DIR="${1:-/etc}"             #1er argument
DEST_DIR="${2:-/var/backups/demo}"  #2eme argument
RETENTION=7 #nbre d'archives max les + récentes. //supprime les anciennes

if [ ! -d "$SOURCE_DIR" ]; then  #Si SOURCE_DIR n'est pas un dossier existant, alors (! -d)
 echo "[$(date '+%F %T')] ERREUR : source $SOURCE_DIR absente" >&2
 exit 1  #arrete le script car erreur 
fi

mkdir -p "$DEST_DIR"  # créer le dossier de destination pour la sauvegarde 
tar -czf "${DEST_DIR}/$(basename "$SOURCE_DIR")-$(date +%Y%m%d-%H%M%S).tar.gz" "$SOURCE_DIR"
ls -1t "$DEST_DIR"/*.tar.gz | tail -n +$((RETENTION + 1)) | xargs -r rm --
echo "[$(date '+%F %T')] OK : $(ls "$DEST_DIR" | wc -l) archives conservées"




##########################################################################
3eme.2 Version : script de sauvegarde_V3.2
##########################################################################

#!/usr/bin/env bash
# Mode strict : arrêt à la première erreur (-e), variable non définie = erreur (-u),
# une erreur dans un pipe fait échouer tout le pipe (pipefail)
set -euo pipefail
 
#nbre d'archives max les + récentes. //supprime les anciennes
RETENTION=7
 
# Affiche un message horodaté
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}
 
# Aide affichée avec l'option -h
usage() {
    cat <<EOF
Usage : $(basename "$0") [SOURCE_DIR] [DEST_DIR]
 
Sauvegarde SOURCE_DIR (défaut : /etc) dans une archive tar.gz horodatée
placée dans DEST_DIR (défaut : /var/backups/demo), puis ne conserve que
les $RETENTION archives les plus récentes portant le même préfixe.
 
Codes retour : 0 = succès, 1 = source absente, 2 = destination non inscriptible
 
Exemple : $(basename "$0") /opt/stockline/data /var/backups/stockline
EOF
}
 
# Option -h / --help : afficher l'aide et sortir proprement
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    usage
    exit 0
fi
 
# Arguments avec valeurs par défaut
SOURCE_DIR=${1:-/etc}
DEST_DIR=${2:-/var/backups/demo}
 
# Vérification 1 : la source doit exister
if [[ ! -d "$SOURCE_DIR" ]]; then
    log "ERREUR : le répertoire source '$SOURCE_DIR' n'existe pas."
    exit 1
fi
 
# Vérification 2 : la destination doit être créable et accessible en écriture
if ! mkdir -p "$DEST_DIR" 2>/dev/null || [[ ! -w "$DEST_DIR" ]]; then
    log "ERREUR : destination '$DEST_DIR' non inscriptible (droits ? sudo ?)."
    exit 2
fi
 
# Construction du nom de l'archive
PREFIXE=$(basename "$SOURCE_DIR")
HORODATAGE=$(date '+%Y%m%d-%H%M%S')
ARCHIVE="$DEST_DIR/${PREFIXE}-${HORODATAGE}.tar.gz"
 
log "Sauvegarde de '$SOURCE_DIR' vers '$ARCHIVE'"
 
# Création de l'archive
tar -czf "$ARCHIVE" -C "$(dirname "$SOURCE_DIR")" "$PREFIXE"
 
# Rétention des archives
log "Rétention : conservation des $RETENTION archives les plus récentes."
 
ls -1t "$DEST_DIR/${PREFIXE}-"*.tar.gz |
    tail -n +$((RETENTION + 1)) |
    while read -r ancienne; do
        log "Suppression de l'ancienne archive : $ancienne"
        rm -f "$ancienne"
    done
 
# Bilan
log "Archive créée : $(du -h "$ARCHIVE" | cut -f1) — $ARCHIVE"
log "Sauvegarde terminée avec succès."
 
exit 0




#habitude pour un admin systeme (mettre ses fichier dans un sous repertoire)
sudo cp backup.sh /usr/local/bin/backup.sh     #copie colle sur le repertoire /usr/local...
sudo chmod +x /usr/local/bin/backup.sh         #parametre les permissions 
sudo nano /etc/systemd/system/backup.service   #creer une unité.
sudo nano /etc/systemd/system/backup.timer     #creer une unité timer pour automatiser le script tout les jours à 3jours
sudo systemctl daemon-reload                   # faire connaitre à systemD
sudo systemctl enable --now backup.timer       #enable le script maintenant et en boot

sudo systemctl start backup.service            #
journalctl -u backup.service -n 6 --no-pager


lien entre backup.service et backup.timer = #lien entre le nom soit backup



