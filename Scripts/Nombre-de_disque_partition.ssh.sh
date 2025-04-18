#!/bin/bash

# Demande les infos SSH une seule fois
read -rp "Entrez l'adresse IP ou le nom d'hôte du serveur distant : " remote_host
read -rp "Entrez le nom d'utilisateur SSH distant : " ssh_user

while true; do
    echo "--------------------------------------"
    echo "  Informations sur les partitions (à distance)"
    echo "--------------------------------------"
    echo "1) Compter et afficher les partitions"
    echo "2) Quitter"
    read -rp "Choisissez une option (1-2) : " choice

    case "$choice" in
        1)
            ssh -t "$ssh_user@$remote_host" '
                count=0
                for type in $(lsblk -n -o TYPE); do
                    if [ "$type" = "part" ]; then
                        count=$((count + 1))
                    fi
                done
                echo "Nombre de partitions détectées : $count"
                for ligne in $(df -h | grep "^/dev/" | awk "{print \$1\":\"\$4}"); do
                    partition=$(echo "$ligne" | cut -d: -f1)
                    libre=$(echo "$ligne" | cut -d: -f2)
                    echo "$partition -> Espace libre : $libre"
                done
            '
            ;;
        2)
            echo "Sortie du programme."
            exit 0
            ;;
        *)
            echo "Option invalide, veuillez choisir entre 1 et 2."
            ;;
    esac

    echo
    read -rp "Appuyez sur Entrée pour revenir au menu..."
    clear
done
