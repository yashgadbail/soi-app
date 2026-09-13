# Prints the signing certificate(s) of an AAB or APK and fails unless one of
# them is the upload key, identified by its SHA-256 fingerprint.
#
#   pwsh tools/verify-aab-signer.ps1 build/app/outputs/bundle/release/app-release.aab
#
# The fingerprint below is the upload certificate registered with Google
# Play for org.swagofindia.soi. A bundle signed by a debug key, or by any
# other key, is rejected by Play; this check runs before every upload
# (docs/RELEASE.md). Pass -ExpectedSha256 to check against another key.
param(
  [Parameter(Mandatory = $true)][string]$Path,
  [string]$ExpectedSha256 = 'B8173D9C496E9DE988E233AA2B28BB5B88D6FBF49A42FB6E612FA4F873EBE86C'
)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.Security

$expected = ($ExpectedSha256 -replace '[^0-9A-Fa-f]', '').ToUpperInvariant()
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
      if ($sha -eq $expected) { $ok = $true }
    }
  }
} finally { $zip.Dispose() }

if (-not $ok) {
  Write-Error "Signer fingerprint does not match the upload key ($expected). Do NOT upload this file."
  exit 1
}
Write-Host "OK: signed by the upload key ($($expected.Substring(0, 8))...)"
