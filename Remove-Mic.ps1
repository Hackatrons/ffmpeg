<#
    .SYNOPSIS
    Removes the microphone audio track from a video file using ffmpeg.

    .DESCRIPTION
    The output file will reside in the same folder with "_compressed" in the filename.

    .PARAMETER File
    The input file path.
#>
param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$File
)

$item = Get-ChildItem $File
$output = Join-Path -Path $item.Directory -ChildPath ($item.BaseName + "_micremoved" + $item.Extension)

ffmpeg `
    -i $File `
    -map 0:1 `
    -map 0:v:0 `
    -acodec copy `
    -vcodec copy `
    $output `
