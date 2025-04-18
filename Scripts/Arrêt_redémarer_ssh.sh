
      #!/bin/bash

while true; do
    echo ""
    echo "Que voulez-vous faire ?"
    echo "1) Arrêter le système distant"
    echo "2) Redémarrer le système distant"
    echo "0) Quitter"
    read -p "Entrez votre choix (1, 2 ou 0) : " choix

    if [[ "$choix" == "1" || "$choix" == "2" ]]; then
        read -p "Adresse IP ou nom du serveur distant : " serveur
        read -p "Nom d'utilisateur SSH : " utilisateur
    fi

    case "$choix" in
        1)
            echo "Arrêt du système distant..."
            ssh -t "$utilisateur@$serveur" "sudo shutdown now"
            ;;
        2)
            echo "Redémarrage du système distant..."
            ssh -t "$utilisateur@$serveur" "sudo reboot"
            ;;
        0)
            echo "Quitter le menu."
            break
            ;;
        *)
            echo "Choix invalide. Veuillez entrer 1, 2 ou 0."
            ;;
    esac
done
 