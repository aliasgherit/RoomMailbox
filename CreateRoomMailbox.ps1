$AppId = "24560a07-db76-4d8d-ba93-21ebbefaffea"
$Tenant = "isb0.onmicrosoft.com"
$CertThumbprint = "B74D418442756942591C0BD2455406EA72A3F295"
Connect-ExchangeOnline -AppId $AppId -Organization $Tenant -CertificateThumbprint $CertThumbprint

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
