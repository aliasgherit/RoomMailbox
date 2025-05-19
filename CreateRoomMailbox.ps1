# Connect to Exchange Online (modern auth)
Connect-ExchangeOnline -ManagedIdentity

# Import CSV
$mailboxes = Import-Csv -Path "./mailboxes.csv"

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
