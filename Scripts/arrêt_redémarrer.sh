#!/bin/bash

# Affichage du menu
echo "  Gestion de l'arrêt du système"
echo "1) Arrêter le système"
echo "2) Redémarrer le système"
echo "3) Annuler"
read -r -p "Choisissez une option (1-3) : " choice

case "$choice" in
    1)
        # Arrêt du système, nécessite des privilèges root
        echo "Arrêt du système en cours..."
        sleep 2
        sudo shutdown -h now
    2)
        # Redémarrage du système, nécessite des privilèges root
        echo "Redémarrage du système en cours..."
        sleep 2
        sudo shutdown -r now
    
    3)
        # Annulation
        echo "Annulation, retour au système normal."
        exit 0
    *)
        echo "Option invalide, veuillez choisir entre 1 et 3."
        exit 1
esac
