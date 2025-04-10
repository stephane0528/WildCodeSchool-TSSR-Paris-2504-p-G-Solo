#!/bin/bash

# Vérifier si l'utilisateur 'wilder' existe, sinon le créer
if ! id "wilder" &>/dev/null; then
    sudo useradd -m -s /bin/bash "wilder"
    echo "wilder:Azerty1*" | sudo chpasswd
    echo "Utilisateur 'wilder' créé."
else
    echo "L'utilisateur 'wilder' existe déjà."
fi

# Menu de gestion
while true; do
    echo -e "\n=== Gestion des utilisateurs ==="
    echo "1) Modifier le mot de passe de wilder"
    echo "2) Supprimer wilder"
    echo "3) Quitter"

    read -p "Choisissez une option (1-3) : " choix

    case "$choix" in
        1) sudo passwd "wilder" ;;
        2) 
            read -p "Supprimer son dossier personnel ? (O/N) : " rep
            if [[ "$rep" =~ ^[Oo]$ ]]; then
                sudo userdel -r "wilder"
            else
                sudo userdel "wilder"
            fi
            echo "Utilisateur 'wilder' supprimé."
            ;;
        3) echo "Au revoir !"; exit 0 ;;
        *) echo "Choix invalide, essayez encore." ;;
    esac
done

          
