Get-ChildItem -Path $PSScriptRoot -Filter '*.ps1' | ForEach-Object {
    $ScriptFile = $_.FullName
    $FunctionName = [System.IO.Path]::GetFileNameWithoutExtension($ScriptFile)

    $FunctionBody = @"
`$CurrentPath = Get-Location
Set-Location -Path $PSScriptRoot
$ScriptFile @Args
Set-Location -Path `$CurrentPath
"@

    $scriptBlock = [scriptblock]::Create($FunctionBody)
    Set-Item -Path "function:$FunctionName" -Value $scriptBlock
}

