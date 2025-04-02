#!/bin/bash

# Vérifie si sudo est installé
if ! command -v sudo &>/dev/null; then
    echo "Erreur : sudo n'est pas installé sur ce système."
    exit 1
fi

# Afficher le menu
echo "--------------------------------------"
echo "  Gestion des groupes Linux"
echo "--------------------------------------"
echo "1) Ajouter un utilisateur à un groupe"
echo "2) Retirer un utilisateur d'un groupe"
echo "3) Quitter"
read -r -p "Choisissez une option (1-3) : " choice

case "$choice" in
    1)
        # Ajout à un groupe
        read -r -p "Entrez le nom de l'utilisateur : " username
        if ! id "$username" &>/dev/null; then
            echo "Erreur : L'utilisateur '$username' n'existe pas."
            exit 1
        fi

        read -r -p "Entrez le nom du groupe : " groupname
        if ! getent group "$groupname" &>/dev/null; then
            echo "Erreur : Le groupe '$groupname' n'existe pas."
            exit 1
        fi

        sudo usermod -aG "$groupname" "$username"
        echo "L'utilisateur '$username' a été ajouté au groupe '$groupname'."
        ;;

    2)
        # Suppression d'un groupe
        read -r -p "Entrez le nom de l'utilisateur : " username
        if ! id "$username" &>/dev/null; then
            echo "Erreur : L'utilisateur '$username' n'existe pas."
            exit 1
        fi

        read -r -p "Entrez le nom du groupe : " groupname
        if ! getent group "$groupname" &>/dev/null; then
            echo "Erreur : Le groupe '$groupname' n'existe pas."
            exit 1
        fi

        sudo gpasswd -d "$username" "$groupname"
        echo "L'utilisateur '$username' a été retiré du groupe '$groupname'."
        ;;

    3)
        echo "Sortie du programme."
        exit 0
        ;;

    *)
        echo "Option invalide, veuillez choisir entre 1 et 3."
        exit 1
        ;;
esac
