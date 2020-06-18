$mapsData = Get-Content "./data/custom.geo.json" | ConvertFrom-Json
$snfData = Import-Csv "./data/Internationality.csv" -Delimiter "|"

foreach($row in $snfData){
    if($row.Year -ne 2019) { continue }
    $found = $null
    $found = $mapsData.features | ? {$_.properties.iso_a2 -eq $row.CountryIsoCode}
    
    if($found -ne $null){
        $rowNumber = [int]$row.Number
        if($row.Type -eq "Collaboration") { 
            $found.properties | Add-Member -Name "SnfCollaboration" -Value $rowNumber -MemberType NoteProperty
        }else{
            $found.properties | Add-Member -Name "SnfFellowship" -Value $rowNumber -MemberType NoteProperty
        }
    }
}
$mapsData | ConvertTo-Json -Depth 32 | Set-Content "./data/snf-internationality-2019.json" -Force