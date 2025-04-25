
# Sujet Choisi : The scripting project (projet solo)


# . Présentation 
Ce projet a pour objectif de concevoir un script permettant aux utilisateurs d’exécuter différentes actions ou de collecter des informations sur le système.

Dans un premier temps, deux versions du script seront développées : l’une en PowerShell pour les systèmes Windows, l’autre en Bash pour les environnements Ubuntu. Chacune de ces versions intégrera l’ensemble des fonctionnalités demandées.

Ensuite, nous mettrons en place deux scénarios de travail :

    Le premier mettra en relation un serveur Windows Server avec un client Windows 11.

    Le second se basera sur une communication entre un serveur Ubuntu et un client Ubuntu.

Enfin, les scripts seront transmis depuis les machines serveurs vers les machines clientes, afin de tester leur bon fonctionnement dans chaque contexte
 
 
# . Objectifs finaux

 
**2. Matériel utiliser**   
Debian12_Server,Ubuntu24-client,Windows 22-Server,windows 11-Client     
Il faut être en root pour Debian/Ubuntu et en administrateursur windows server/windows 11 et installé sudo avec les commandes suivantes:   
 
# 1.Passer en root :  
 su     
# 2.nstaller sudo avec la commande suivante :    

*apt update && apt install sudo -y*     
Ajouter un utilisateur au groupe sudo pour lui permettre d'utiliser *sudo*:    
*sudo usermod -aG sudo nom_utilisateur # Remplacez `nom_utilisateur` par le nom de l'utilisateur.*      
**CONFIGURATION RESEAUX**  
# 1. Configuration du réseau interne entre Debian Server et Ubuntu Client    
# - Etape 1 : Installation des carte réseaux    
Sur Debian Server, ajouter deux cartes réseaux :    

-Une pour le réseau interne avec le client    
-Une pour la connexion à Internet    
Sur Ubuntu Client, ajouter une carte réseaux :    

Une pour le réseau interne avec le server    
# - Etape 2 : Configuration des cartes réseaux sur Debian Server    
a. Ouvrir un terminal    

b. Chercher les noms des cartes réseaux, ils serviront pour la configuration dans les étapes suivantes:     
*ip a*      
c. Créer un fichier de configuration réseau dans /etc/systemd/network    
*sudo nano /etc/systemd/network/interface.network*       
d. Données de configuration de la première carte réseau pour le réseaux interne   
*[MATCH]*  
*Name=id  # Remplacer "id" par le nom de la première carte (type ens18)*    
*[Network]*    
*Address=X.X.X.X/24  # Remplacer "x.x.x.x"avec l'adresse IP du réseau local*    

# Données de configuration de la deuxième carte réseau pour internet  
*[MATCH]*  
*Name=id  # Remplacer "id" par le nom de la première carte (type ens19)*   
*[Network]*  
*Address=192.168.1.X  # Remplacer X par les deux derniers chiffres de la machine virtuelle*   
Gateway=192.168.1.254  # Passerelle par défaut. Ajouter les paramètres suivants dans le fichier :      
d. Enregistrer les modifications et quittez avec Ctrl + X, puis Y pour sauvegarder.   
e. Redémarrer le service réseau :     
*sudo systemctl restart systemd-networkd*     

**- Étape 3 : Configuration de la carte réseau sur Ubuntu Client**  
a. Ouvrir un terminal  

b. Chercher le nom de la carte réseaux  

*ip a*    
c. Créer un fichier de configuration réseau dans /etc/systemd/network  

*sudo nano /etc/systemd/network/interface.network*  
d. Ajouter les paramètres suivants dans le fichier :  

# Données de configuration de la carte réseau pour le réseaux interne   
*[MATCH]*    
*Name=id  # Remplacer "id" par le nom de la première carte (type ens18)*   
*[Network]*    
Address=X.X.X.X/24  # Remplacer "x.x.x.x"avec l'adresse IP du réseau local  
c. Enregistrer les modifications et quittez avec Ctrl + X, puis Y pour sauvegarder.  

d. Redémarrer le service réseau :  

*sudo systemctl restart systemd-network*     
# Configuration du réseau sur Windows Server et Windows 11 Client  
**- Étape 1 : Modifier les paramètres réseau sur Windows**  
Aller dans les Paramètres Ethernet :  
-Clique-droit sur l'icône réseau dans la barre des tâches (1).  
-Sélectionner Paramètres réseau et Internet (2).  
-Cliquer sur Ethernet (3)  
-Puis Modifier l'attribution d'adresse IP (4).    
2 .Désactivez le DHCP et entrer l'adresse IP manuellement :  
Modifier Automatique en Manuel (5).  
Activer IPv4 (6).  
Entrer l'IP, le masque et éventuellement le DSN manuellement dans les champs appropriés (7).    
3. Après avoir configuré les adresses IP et résolu le problème de connexion Internet, la machine Windows est capable d'accéder au réseau.    
# 3. Vérification des connexions  
Selon le cas, entrer les lignes de commandes dans un terminal. S'il y a une réponse, alors la connexion est établie. Sinon, reprendre l'installation et vérifier les configurations  

**Ping entre Debian Server et Ubuntu Client**    
*ping (adresse IP Ubuntu Client)*     
**Ping entre Ubuntu Client et Debian Server**  
*ping (adresse IP Debian Server)*    
**Ping entre Debian Server et Google**  
*ping google.com*   
**Ping entre Windows Server et Windows 11**  
*ping (adresse IP Windows 11)*     
**Ping entre Windows 11 et Windows Server**  
*ping (adresse IP Windows Server)*     
**Ping entre Windows Server et Google**  
*ping google.com*    
Une fois ces configurations terminées, vous avez un réseau configuré entre Debian Server/Ubuntu Client et Windows Server/Windows 11 Client. Ce projet peut être dupliqué en suivant les étapes ci-dessus et en ajustant les paramètres IP selon votre environnement.  

Si vous rencontrez des problèmes de connexion, vérifiez la configuration IP sur chaque machine et assurez-vous que les interfaces réseaux sont correctement configurées.  

# INSTALLATION WIN-RM (sur windows)  
-Sur Windows Server et Windows 11  

-Activer le service WinRM Ouvrir une invite PowerShell en administrateur :  

Enable-PSRemoting -Force  
-Vérifier que le service est démarré   
*Get-Service WinRM*   
-S’il n’est pas en cours d’exécution, démarre-le avec :  
*Start-Service WinRM*   
-Optionnel : Configurer la liste des hôtes approuvés Si les machines ne sont pas dans un domaine Active Directory, il faut ajouter manuellement les hôtes de confiance :  
*Set-Item WSMan:\localhost\Client\TrustedHosts "NomOuIP"*   
Ou autoriser tous les hôtes :  

*Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" -Force*   
