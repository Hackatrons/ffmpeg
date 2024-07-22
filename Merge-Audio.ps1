<#
    .SYNOPSIS
    Merges two audio tracks in a video file to one.

    .DESCRIPTION
    Used for merging separate microphone and system audio tracks into a single track.
    The output file will reside in the same folder with "_merged" in the filename.

    .PARAMETER File
    The input file path.
#>
param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$File
)

$item = Get-ChildItem $File
$output = Join-Path -Path $item.Directory -ChildPath ($item.BaseName + "_merged" + $item.Extension)

ffmpeg `
    -i $File `
    -filter_complex "[0:a:0] volume=1.0 [system] ; [0:a:1] volume=1.0 [mic] ; [system][mic] amix=inputs=2 [merged]" `
    -map "0:v:0" `
    -map "[merged]" `
    -c:v copy `
    -c:a aac $output `
