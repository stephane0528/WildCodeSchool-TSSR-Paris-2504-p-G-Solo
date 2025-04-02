#!/bin/bash

# Vérifie si sudo est installé
if ! command -v sudo &>/dev/null; then
    echo "Erreur : sudo n'est pas installé sur ce système."
    exit 1
fi

# Boucle pour afficher le menu et attendre une entrée utilisateur
while true; do
    echo "--------------------------------------"
    echo "  Gestion des utilisateurs Linux"
    echo "--------------------------------------"
    echo "1) Créer un utilisateur"
    echo "2) Changer le mot de passe d'un utilisateur"
    echo "3) Supprimer un utilisateur"
    echo "4) Quitter"
    
    # Utilisation de `-r` pour éviter les interprétations de backslashes
    read -r -p "Choisissez une option (1-4) : " choice
    
    case "$choice" in
        1)
            # Création d'un utilisateur
            read -r -p "Entrez le nom du nouvel utilisateur : " username
            if id "$username" &>/dev/null; then
                echo "Erreur : L'utilisateur '$username' existe déjà."
            else
                sudo useradd -m -s /bin/bash "$username"
                if [[ $? -eq 0 ]]; then
                    echo "Utilisateur '$username' créé avec succès."
                    read -r -p "Voulez-vous définir un mot de passe pour '$username' ? (O/N) : " set_password
                    if [[ "$set_password" =~ ^[Oo]$ ]]; then
                        sudo passwd "$username"
                    fi
                else
                    echo "Erreur lors de la création de l'utilisateur."
                fi
            fi
            ;;
        
        2)
            # Changer le mot de passe d'un utilisateur existant
            read -r -p "Entrez le nom de l'utilisateur : " username
            if id "$username" &>/dev/null; then
                sudo passwd "$username"
            else
                echo "Erreur : L'utilisateur '$username' n'existe pas."
            fi
            ;;
        
        3)
            # Supprimer un utilisateur
            read -r -p "Entrez le nom de l'utilisateur à supprimer : " username
            if id "$username" &>/dev/null; then
                read -r -p "Voulez-vous aussi supprimer son répertoire personnel ? (O/N) : " delete_home
                if [[ "$delete_home" =~ ^[Oo]$ ]]; then
                    sudo userdel -r "$username"
                else
                    sudo userdel "$username"
                fi
                echo "Utilisateur '$username' supprimé."
            else
                echo "Erreur : L'utilisateur '$username' n'existe pas."
            fi
            ;;
        
        4)
            echo "Sortie du programme."
            exit 0
            ;;
        
        *)
            echo "Option invalide, veuillez choisir entre 1 et 4."
            ;;
    esac
done
