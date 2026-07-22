Partie 3 — Tests croisés : mettez-vous à leur place
Pour chaque test, ouvrez une session avec su - alice ou su - bruno (mot de passe Formation2026!), puis revenez avec exit.

1/En tant qu'alice : placez-vous dans /srv/partage et créez le fichier note-alice.txt contenant la ligne pense-bete d'alice (redirection).
cd /srv/partage
echo "pense-bête d'alice"> note-alice.txt

2/Toujours en tant qu'alice : affichez le fichier en détail avec ls -l. Question A : à quel groupe appartient le fichier ? Pourquoi n'est-ce pas le groupe alice ?
cat note-alice.txt
ls -l  : car nous avons parametré le setgid tout à l'heure sur /srv/partage

3/En tant que bruno : lisez note-alice.txt, puis ajoutez-y la ligne relu par bruno (redirection >>). Créez ensuite votre propre fichier note-bruno.txt.
su - bruno
echo "relu par bruno" >> note-alice.txt
echo "Fichier crée par bruno"> note-bruno.txt

4/De retour en tant qu'ubuntu (sans sudo) : essayez de lister /srv/partage. Question B : que se passe-t-il, et quel chiffre du mode 2770 en est responsable ?
permission denied car 2770, utilisateur ubuntu n'appartient pas au groupe et n'est pas proprietaire, il est autres soit 0 donc 0 droit.

5/Question C : en tant qu'alice, exécutez la commande umask. En combinant sa valeur et le setgid, expliquez pourquoi bruno a pu modifier le fichier d'alice.
grace au setgid 

droits de base d'un fichier : 666




BONUS : 
1/Ajoutez alice au groupe sudo.
sudo usermod -aG sudo alice 
su - alice

2/En tant qu'alice, prouvez que ça fonctionne : sudo whoami doit répondre root (mot de passe demandé : celui d'alice).
sudo whoami

3/Vérifiez dans les journaux que cette élévation de privilèges a laissé une trace (sudo journalctl -t sudo -n 5 en tant qu'ubuntu, 
ou regardez /var/log/auth.log) : sur un serveur de production, tout usage de sudo est audité — c'est l'une des raisons de préférer sudo à root.



