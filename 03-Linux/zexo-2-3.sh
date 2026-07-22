²²²²sudo nano /etc/systemd/system//test_repertoire.sh
#! /usr/bin/env bash
if [ -d "$1" ]; then
    echo "Le repertoire $1 existe"
else
    echo "ERROR : répertoire $1 est introuvable"
    exit 1
fi

²²²²sudo chmod +x /etc/systemd/system//test_repertoire.sh

.test_repertoire.sh /home/Documents
Resultat = Le repertoire /home/Documents existe

