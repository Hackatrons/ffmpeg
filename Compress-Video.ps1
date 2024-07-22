<#
    .SYNOPSIS
    Compresses a video file using ffmpeg.

    .DESCRIPTION
    Compresses a video file to a preset quality level.
    Uses hardware acceleration (graphics card) for better performance.
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
$output = Join-Path -Path $item.Directory -ChildPath ($item.BaseName + "_compressed" + $item.Extension)

ffmpeg `
    -hwaccel auto `
    -i $File `
    -vcodec h264_nvenc `
    -b:v 6M `
    $output `
