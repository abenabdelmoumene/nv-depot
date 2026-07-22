1. Les processus :
ps aux | grep ssh  = affiche tout les processus en filtrant avec "ssh"

ETATS d'un processus : R(running);S(sleeping);T(stopped)

SIGTERM : termine processus de maniere propre
SIGKILL : tuer processus de maniere brutal
SIGHUP : recharge une configuration

kill 1290 (PID) : SIGTERM (15) : terminez proprement
kill -15 1290  : identique a SIGTERM (-15)
kill -9 1290 : SIGKILL (9) : le noyau tue sans nettoyage possible
kill %1 = tue proprement

pkill sleep /SIGTERM à tout les processus nommés "sleep"
pkill -u alice : SIGTERM à tout les processus de l'user alice


###############################
diagnostic à connaitre par coeur !
systemctl status nginx : service activé au boot.
curl -I http://localhost  : verifié si le service est actif
###############################

Un service ne marche pas ? Toujours la même séquence, dans cet ordre :

systemctl status monservice # 1. constat : failed ? depuis quand ?

journalctl -u monservice -n 50 # 2. les 50 dernières lignes de journal

sudo nano /etc/systemd/system/monservice.service # 3. corriger la cause

sudo systemctl daemon-reload # 4. si l'unité a été modifiée, recharge

sudo systemctl restart monservice # 5. relancer

systemctl status monservice # 6. vérifier : active (running)


L'erreur est presque toujours écrite en clair dans le journal (étape 2).
daemon-reload : systemd garde les unités en cache — tant que vous ne le lancez pas,
Il exécute l'ancienne version du fichier. Piège n°1 du métier.

###############################
modifier enable/disable au boot du service ou l'etat du service :
###############################
sudo systemctl disable nginx => passe du boot enable à disable

sudo systemctl stop ngix => stop le service










































