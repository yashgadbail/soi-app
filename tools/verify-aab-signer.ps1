# Prints the signing certificate(s) of an AAB or APK and fails unless the
# subject matches the expected upload key.
#
#   pwsh tools/verify-aab-signer.ps1 build/app/outputs/bundle/release/app-release.aab
#
# Expected: CN=Yash Gadbail. A bundle signed CN=Android Debug is rejected by
# Google Play; this check runs before every upload (docs/RELEASE.md).
param(
  [Parameter(Mandatory = $true)][string]$Path,
  [string]$ExpectedSubject = 'CN=Yash Gadbail'
)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.Security

$zip = [IO.Compression.ZipFile]::OpenRead((Resolve-Path $Path))
try {
  $entries = $zip.Entries | Where-Object { $_.FullName -like 'META-INF/*.RSA' -or $_.FullName -like 'META-INF/*.DSA' -or $_.FullName -like 'META-INF/*.EC' }
  if (-not $entries) { throw "No signature block found in $Path" }
  $ok = $false
  foreach ($e in $entries) {
    $ms = New-Object IO.MemoryStream
    $e.Open().CopyTo($ms)
    $cms = New-Object Security.Cryptography.Pkcs.SignedCms
    $cms.Decode($ms.ToArray())
    foreach ($cert in $cms.Certificates) {
      $sha = ($cert.GetCertHash([Security.Cryptography.HashAlgorithmName]::SHA256) | ForEach-Object { $_.ToString('X2') }) -join ''
      Write-Host ("{0}`n  subject: {1}`n  SHA-256: {2}" -f $e.FullName, $cert.Subject, $sha)
      if ($cert.Subject -like "*$ExpectedSubject*") { $ok = $true }
    }
  }
} finally { $zip.Dispose() }

if (-not $ok) {
  Write-Error "Signer does not match '$ExpectedSubject'. Do NOT upload this file."
  exit 1
}
Write-Host "OK: signed by $ExpectedSubject"
