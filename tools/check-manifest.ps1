# Fails if the merged Android manifest of a built APK/AAB declares any
# permission beyond the allowlist. The Play Data Safety form for this app
# declares no location, photos/media, audio, files or contacts; a plugin
# update that quietly merges one of those must be caught before upload.
#
#   pwsh tools/check-manifest.ps1 build/app/outputs/flutter-apk/app-release.apk
#   pwsh tools/check-manifest.ps1 build/app/outputs/bundle/release/app-release.aab
param(
  [Parameter(Mandatory = $true)][string]$Path,
  [string]$BuildTools = 'E:\Android\build-tools\36.0.0',
  [string]$Bundletool = ''
)
$ErrorActionPreference = 'Stop'
# ACCESS_NETWORK_STATE is a normal-level permission merged by the networking
# stack; it has no Data Safety implication. The DYNAMIC_RECEIVER permission is
# an app-private signature permission added by AndroidX.
$allow = @('android.permission.CAMERA', 'android.permission.INTERNET', 'android.permission.ACCESS_NETWORK_STATE', 'org.swagofindia.soi.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION')

if ($Path -like '*.aab') {
  if (-not $Bundletool) { throw 'Pass -Bundletool <path to bundletool.jar> for an AAB' }
  $xml = & java -jar $Bundletool dump manifest --bundle $Path
  $perms = [regex]::Matches($xml, 'uses-permission[^>]*android:name="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
} else {
  $out = & "$BuildTools\aapt.exe" dump permissions $Path
  $perms = $out | Where-Object { $_ -like 'uses-permission:*' } | ForEach-Object { ($_ -replace "uses-permission: name='", '') -replace "'.*$", '' }
}

$perms = $perms | Sort-Object -Unique
Write-Host "Permissions in ${Path}:`n  $($perms -join "`n  ")"
$extra = $perms | Where-Object { $allow -notcontains $_ }
if ($extra) {
  Write-Error "Unexpected permissions: $($extra -join ', '). Fix the manifest (tools:node=remove) before uploading."
  exit 1
}
Write-Host 'OK: only CAMERA and INTERNET are declared.'
