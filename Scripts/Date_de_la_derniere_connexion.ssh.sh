#!/bin/bash

# Demande l'adresse du serveur distant et le nom d'utilisateur
read -p "Adresse du serveur distant (ex: user@ip) : " serveur
read -p "Nom de l'utilisateur à vérifier : " utilisateur

while true; do
    echo "==== MENU ===="
    echo "1) Afficher la dernière connexion de l'utilisateur"
    echo "2) Quitter"
    read -p "Choisissez une option : " choix

    case $choix in
        1)
            ssh -t "$serveur" "lastlog -u '$utilisateur'"
            ;;
        2)
            echo "Fin du script."
            break
            ;;
        *)
            echo "Option invalide. Veuillez réessayer."
            ;;
    esac
done
