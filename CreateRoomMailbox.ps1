

Connect-ExchangeOnline -AppId $env:EXO_APP_ID -Organization $env:EXO_TENANT_ID -CertificateThumbprint $env:EXO_CERT_THUMBPRINT


# Import CSV
$mailboxes = Import-Csv -Path "./UsersToMigrate.csv"

foreach ($mbx in $mailboxes) {
    # Create room mailbox
    New-Mailbox -Room `
        -Name $mbx.Name `
        -DisplayName $mbx.DisplayName `
        -Alias $mbx.Alias `
        -PrimarySmtpAddress $mbx.PrimarySmtpAddress `
        -SamAccountName $mbx.SamAccountName

    Write-Host "Created Room Mailbox: $($mbx.PrimarySmtpAddress)"
}

# Disconnect
Disconnect-ExchangeOnline

      env:
        EXO_APP_ID: ${{ secrets.EXO_APP_ID }}
        EXO_TENANT_ID: ${{ secrets.EXO_TENANT_ID }}
        EXO_CERT_THUMBPRINT: ${{ secrets.EXO_CERT_THUMBPRINT }}
