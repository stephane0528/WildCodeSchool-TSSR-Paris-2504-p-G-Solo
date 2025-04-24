# Vérifie si le module nécessaire est disponible
if (-not (Get-Command Invoke-Command -ErrorAction SilentlyContinue)) {
    Write-Error "Erreur : Invoke-Command n'est pas disponible."
    exit 1
}

$remoteHost = Read-Host "Entrez le nom d'hôte ou l'adresse IP du serveur distant"
$remoteUser = Read-Host "Entrez le nom d'utilisateur distant"
$securePassword = Read-Host "Entrez le mot de passe de l'utilisateur distant" -AsSecureString
$cred = New-Object System.Management.Automation.PSCredential ($remoteUser, $securePassword)

while ($true) {
    Clear-Host
    Write-Host "--------------------------------------"
    Write-Host "  Gestion des groupes Windows (à distance)"
    Write-Host "--------------------------------------"
    Write-Host "1) Ajouter un utilisateur à un groupe"
    Write-Host "2) Retirer un utilisateur d'un groupe"
    Write-Host "3) Quitter"
    $choice = Read-Host "Choisissez une option (1-3)"

    switch ($choice) {
        '1' {
            $username = Read-Host "Entrez le nom de l'utilisateur à ajouter"
            $groupname = Read-Host "Entrez le nom du groupe"

            Invoke-Command -ComputerName $remoteHost -Credential $cred -ScriptBlock {
                param($username, $groupname)
                if (-not (Get-LocalUser -Name $username -ErrorAction SilentlyContinue)) {
                    Write-Output "Erreur : L'utilisateur '$username' n'existe pas."
                    return
                }
                if (-not (Get-LocalGroup -Name $groupname -ErrorAction SilentlyContinue)) {
                    Write-Output "Erreur : Le groupe '$groupname' n'existe pas."
                    return
                }
                Add-LocalGroupMember -Group $groupname -Member $username
                Write-Output "L'utilisateur '$username' a été ajouté au groupe '$groupname'."
            } -ArgumentList $username, $groupname
        }
        '2' {
            $username = Read-Host "Entrez le nom de l'utilisateur à retirer"
            $groupname = Read-Host "Entrez le nom du groupe"

            Invoke-Command -ComputerName $remoteHost -Credential $cred -ScriptBlock {
                param($username, $groupname)
                if (-not (Get-LocalUser -Name $username -ErrorAction SilentlyContinue)) {
                    Write-Output "Erreur : L'utilisateur '$username' n'existe pas."
                    return
                }
                if (-not (Get-LocalGroup -Name $groupname -ErrorAction SilentlyContinue)) {
                    Write-Output "Erreur : Le groupe '$groupname' n'existe pas."
                    return
                }
                Remove-LocalGroupMember -Group $groupname -Member $username
                Write-Output "L'utilisateur '$username' a été retiré du groupe '$groupname'."
            } -ArgumentList $username, $groupname
        }
        '3' {
            Write-Host "Sortie du programme."
            break
        }
        Default {
            Write-Host "Option invalide, veuillez choisir entre 1 et 3."
        }
    }

    Write-Host
    Read-Host "Appuyez sur Entrée pour revenir au menu..."
}
