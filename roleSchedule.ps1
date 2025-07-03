$techCount = 0
$result = "String"
$resultTwo = "String"
$days = @("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
$weeks = 0

$roleList = @()
$techList = @()
$assignments = @()

function Rotate-Array {
    param (
        [array]$array
    )
    $newArray = @()
    for ($count = 1; $count -lt $array.count; $count++) {
        $newArray += $array[$count]
    }

    if ($array -and $array.Count -gt 0) {
        $newArray += $array[0]
    }

    return $newArray
}

while (-not ([int]::TryParse($result, [ref] $techCount) -and [int]::TryParse($resultTwo, [ref] $weeks))) {
    $result = Read-Host "How many service desk techs for calendar: "
    $resultTwo = Read-Host "How many weeks in calendar: "

}

$roleCount = $techCount

for ($count = 0; $count -lt $roleCount; $count++) {
    $roleList += Read-Host "Input role $($count +1)"
}

for ($count = 0; $count -lt $roleCount; $count++) {
    $techList += Read-Host "Input tech $($count +1)"
}

$techList = $techList | Sort-Object { Get-Random }

for ($i = 0; $i -lt $weeks; $i ++) {
    for ($j = 0; $j -lt $days.Count; $j ++) {
        for ($k = 0; $k -lt $roleList.Count; $k++) {
            Write-host "$($roleList[$k]): $($techList[$k])"
            $assignments += [PSCustomObject]@{
                week = $i + 1
                day  = $days[$j]
                role = $roleList[$k]
                tech = $techList[$k]
            }
        }
        $techList = Rotate-Array -array $techList
    }
}


$assignments | Export-Csv -NoTypeInformation "C:/temp/assignment.csv"