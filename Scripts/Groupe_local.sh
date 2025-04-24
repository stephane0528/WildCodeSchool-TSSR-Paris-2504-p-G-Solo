# Vérifie si Invoke-Command est disponible
if (-not (Get-Command Invoke-Command -ErrorAction SilentlyContinue)) {
    Write-Error "Erreur : Invoke-Command n'est pas disponible sur ce système."
    exit 1
}

$remoteHost = Read-Host "Entrez le nom d'hôte ou l'adresse IP du serveur distant"
$remoteUser = Read-Host "Entrez le nom d'utilisateur distant"
$securePassword = Read-Host "Entrez le mot de passe de l'utilisateur distant" -AsSecureString
$cred = New-Object System.Management.Automation.PSCredential ($remoteUser, $securePassword)

while ($true) {
    Clear-Host
    Write-Host ""
    Write-Host "===== MENU PRINCIPAL ====="
    Write-Host "1. Arrêt / Redémarrage"
    Write-Host "2. Date de la dernière connexion"
    Write-Host "3. Gestion des utilisateurs"
    Write-Host "4. Groupes locaux"
    Write-Host "5. Disques et partitions"
    Write-Host "6. Version de l'OS"
    Write-Host "0. Quitter"
    Write-Host "=========================="
    $choix = Read-Host "Choix"

    switch ($choix) {
        '1' {
            Invoke-Command -ComputerName $remoteHost -Credential $cred -ScriptBlock { & "C:\Scripts\arret_redemarrer.ps1" }
        }
        '2' {
            Invoke-Command -ComputerName $remoteHost -Credential $cred -ScriptBlock { & "C:\Scripts\date_derniere_connexion.ps1" }
        }
        '3' {
            Invoke-Command -ComputerName $remoteHost -Credential $cred -ScriptBlock { & "C:\Scripts\gestion_utilisateur.ps1" }
        }
        '4' {
            Invoke-Command -ComputerName $remoteHost -Credential $cred -ScriptBlock { & "C:\Scripts\groupe_local.ps1" }
        }
        '5' {
            Invoke-Command -ComputerName $remoteHost -Credential $cred -ScriptBlock { & "C:\Scripts\nombre_disques_partitions.ps1" }
        }
        '6' {
            Invoke-Command -ComputerName $remoteHost -Credential $cred -ScriptBlock { & "C:\Scripts\version_os.ps1" }
        }
        '0' {
            Write-Host "Fermeture du menu..."
            break
        }
        Default {
            Write-Host "Option invalide. Réessaie."
        }
    }

    Write-Host
    Read-Host "Appuyez sur Entrée pour revenir au menu..."
}
