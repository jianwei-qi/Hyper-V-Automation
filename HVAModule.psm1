Get-ChildItem -Path $PSScriptRoot -Filter '*.ps1' | ForEach-Object {
    $ScriptFile = $_.FullName
    $FunctionName = [System.IO.Path]::GetFileNameWithoutExtension($ScriptFile)

    $FunctionBody = "$ScriptFile @Args"

    $scriptBlock = [scriptblock]::Create($FunctionBody)
    Set-Item -Path "function:$FunctionName" -Value $scriptBlock
}

