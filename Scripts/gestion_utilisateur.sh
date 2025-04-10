#!/bin/bash

# Demander un nom d'utilisateur
read -p "Entrez le nom de l'utilisateur : " user
# Vérifier si l'utilisateur existe, sinon le créer
if ! id "$user" &>/dev/null; then
    sudo useradd -m -s /bin/bash "$user"
    echo "Utilisateur '$user' créé."
else
    echo "L'utilisateur '$user' existe déjà."
fi
# Menu de gestion
while true; do
    echo -e "\n=== Gestion des utilisateurs ==="
    echo "1) Modifier le mot de passe de $user"
    echo "2) Supprimer $user"
    echo "3) Quitter"

    read -p "Choisissez une option (1-3) : " choix
    case "$choix" in
        1) sudo passwd "$user" ;;
        2) 
            read -p "Supprimer son dossier personnel ? (O/N) : " rep
            if [[ "$rep" =~ ^[Oo]$ ]]; then
                sudo userdel -r "$user"
            else
                sudo userdel "$user"
            fi
            echo "Utilisateur '$user' supprimé."
            ;;
        3) echo "Au revoir !"; exit 0 ;;
        *) echo "Choix invalide, essayez encore." ;;
    esac
done


          
