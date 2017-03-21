
$RootCertificate = New-SelfSignedCertificate `
-Type Custom `
-KeySpec Signature `
-KeyExportPolicy Exportable `
-HashAlgorithm sha1 `
-KeyLength 2048 `
-Subject "CN=MyRootCertificate" `
-CertStoreLocation "Cert:\CurrentUser\My" -KeyUsage None -KeyUsageProperty All


$JacksClientCertificate = New-SelfSignedCertificate `
-Type Custom `
-KeySpec KeyExchange `
-KeyExportPolicy Exportable `
-HashAlgorithm sha1 `
-KeyLength 2048 `
-Subject "CN=P2S VPN Certificate for Istvan via N-SSC" `
-CertStoreLocation "Cert:\CurrentUser\My" `
-Signer $RootCertificate