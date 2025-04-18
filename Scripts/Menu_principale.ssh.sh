#!/bin/bash

while true; do
    echo ""
    echo "===== MENU PRINCIPAL ====="
    echo "1. Arrêt / Redémarrage"
    echo "2. Date de la dernière connexion"
    echo "3. Gestion des utilisateurs"
    echo "4. Groupes locaux"
    echo "5. Disques et partitions"
    echo "6. Version de l'OS"
    echo "0. Quitter"
    echo "=========================="
    read -p "Choix : " choix
    echo ""

    case $choix in
        1) ./arrêt_redémarer.sh ;;
        2) ./Date_de_la_derniere_connexion.sh ;;
        3) ./Gestion_utilisateur.sh ;;
        4) ./Groupe_local.sh ;;
        5) ./Nombre-de_disque_partition.sh ;;
        6) ./Version_de_os.sh ;;
        0) echo "Fermeture du menu..."; exit 0 ;;
        *) echo "Option invalide. Réessaie." ;;
    esac
done
