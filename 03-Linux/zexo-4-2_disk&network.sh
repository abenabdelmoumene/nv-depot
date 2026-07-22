Disque physiques et partitions :

sudo mkdir -p /data
sudo mount /dev/sdb1 /data # on monte la partition dans le repertoire /data
findmnt /data  #verifier si la partition est monté dans /data
sudo umount /data #demonter la partition

Commandes Linux Reseaux :
ip a          #ipconfig
sudo ss -tlnp #-t TCP, -l en écoute, -n ports, -p processus

