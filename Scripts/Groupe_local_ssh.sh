#!/bin/bash

# Vérifie si sudo est installé
if ! command -v sudo > /dev/null; then
    echo "Erreur : sudo n'est pas installé sur ce système."
    exit 1
fi

read -rp "Entrez l'adresse IP ou le nom d'hôte du serveur distant : " remote_host
read -rp "Entrez le nom d'utilisateur SSH distant : " ssh_user

while true; do
    echo "--------------------------------------"
    echo "  Gestion des groupes Linux (à distance)"
    echo "--------------------------------------"
    echo "1) Ajouter un utilisateur à un groupe"
    echo "2) Retirer un utilisateur d'un groupe"
    echo "3) Quitter"
    read -rp "Choisissez une option (1-3) : " choice

    case "$choice" in
        1)
            read -rp "Entrez le nom de l'utilisateur à ajouter : " username
            read -rp "Entrez le nom du groupe : " groupname

            ssh -t "$ssh_user@$remote_host" "
                if ! id '$username' > /dev/null 2>&1; then
                    echo \"Erreur : L'utilisateur '$username' n'existe pas.\"; exit 1
                fi
                if ! getent group '$groupname' > /dev/null 2>&1; then
                    echo \"Erreur : Le groupe '$groupname' n'existe pas.\"; exit 1
                fi
                sudo usermod -aG '$groupname' '$username' && \
                echo \"L'utilisateur '$username' a été ajouté au groupe '$groupname'.\"
            "
            ;;
        2)
            read -rp "Entrez le nom de l'utilisateur à retirer : " username
            read -rp "Entrez le nom du groupe : " groupname

            ssh -t "$ssh_user@$remote_host" "
                if ! id '$username' > /dev/null 2>&1; then
                    echo \"Erreur : L'utilisateur '$username' n'existe pas.\"; exit 1
                fi
                if ! getent group '$groupname' > /dev/null 2>&1; then
                    echo \"Erreur : Le groupe '$groupname' n'existe pas.\"; exit 1
                fi
                sudo gpasswd -d '$username' '$groupname' && \
                echo \"L'utilisateur '$username' a été retiré du groupe '$groupname'.\"
            "
            ;;
        3)
            echo "Sortie du programme."
            exit 0
            ;;
        *)
            echo "Option invalide, veuillez choisir entre 1 et 3."
            ;; Groupe_local.sh.ssh
    esac

    echo
    read -rp "Appuyez sur Entrée pour revenir au menu..."
    clear
done
