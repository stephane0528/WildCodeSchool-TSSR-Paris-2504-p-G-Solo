#!/bin/bash

# Vérifie si l'utilisateur 'wilder' existe déjà
if ! id "wilder" &>/dev/null; then
    sudo useradd -m -s /bin/bash "wilder"
    echo "wilder:Azerty1*" | sudo chpasswd
    echo "Utilisateur 'wilder' créé avec le mot de passe par défaut."
else
    echo "L'utilisateur 'wilder' existe déjà."
fi

# Boucle pour afficher le menu et attendre une entrée utilisateur
while true; do
    echo "  Gestion des utilisateurs Linux"
    echo "1) Changer le mot de passe de wilder"
    echo "2) Supprimer wilder"
    echo "3) Quitter"
    
    read -r -p "Choisissez une option (1-3) : " choice
    
    case "$choice" in
        1)
            # Changer le mot de passe de 'wilder'
            sudo passwd "wilder"
            ;;
        
        2)
            # Supprimer 'wilder'
            read -r -p "Voulez-vous aussi supprimer son répertoire personnel ? (O/N) : " delete_home
            if [[ "$delete_home" =~ ^[Oo]$ ]]; then
                sudo userdel -r "wilder"
            else
                sudo userdel "wilder"
            fi
            echo "Utilisateur 'wilder' supprimé."
            ;;
        
        3)
            echo "Sortie du programme."
            exit 0
            ;;
        
        *)
            echo "Option invalide, veuillez choisir entre 1 et 3."
            ;;
    esac
done
