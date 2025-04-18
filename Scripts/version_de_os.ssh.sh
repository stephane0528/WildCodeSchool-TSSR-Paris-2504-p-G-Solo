
  #!/bin/bash

read -p "Adresse du serveur distant (ex: user@ip) : " serveur
read -p "Nom de l'utilisateur à vérifier : " utilisateur

while true; do
    echo "1) Dernière connexion"
    echo "2) Connexions en cours"
    echo "3) 5 dernières connexions"
    echo "4) Quitter"
    read -p "Choix : " choix

    case $choix in
        1)
            ssh -t "$serveur" "lastlog -u '$utilisateur'"
            ;;
        2)
            ssh -t "$serveur" "who"
            ;;
        3)
            ssh -t "$serveur" "last -n 5 $utilisateur"
            ;;
        4)
            break
            ;;
        *)
            echo "Choix invalide"
            ;;
    esac
done    