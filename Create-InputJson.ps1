$mapsData = Get-Content .\custom.geo.json | ConvertFrom-Json
$found =$mapsData.features | ? {$_.properties.iso_a2 -eq "AL"}
$found.properties | Add-Member -Name "SnfNumber" -Value 100 -MemberType NoteProperty
$mapsData | ConvertTo-Json -Depth 32 | Set-Content ./modified.json