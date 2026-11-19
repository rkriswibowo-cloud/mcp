$ErrorActionPreference = 'Stop'
$packageRoot = (Get-Item -LiteralPath $PSScriptRoot).Parent.Parent.FullName
$checksumFile = Join-Path $packageRoot 'SHA256SUMS.txt'
$entries = @(Get-Content -LiteralPath $checksumFile)
if ($entries.Count -eq 0) { throw 'Manifest checksum kosong.' }
foreach ($entry in $entries) {
    $expected, $path = $entry -split '  ', 2
    $actual = (Get-FileHash -LiteralPath (Join-Path $packageRoot $path) -Algorithm SHA256).Hash
    if ($actual -ne $expected) { throw ('Checksum tidak cocok: ' + $path) }
}
Write-Output ('Checksum cocok: ' + $entries.Count + ' file')

$trials = @(Import-Csv -LiteralPath (Join-Path $packageRoot 'datasets/raw/raw_trials_v4.csv'))
$summaries = @(Import-Csv -LiteralPath (Join-Path $packageRoot 'datasets/processed/summary_trials_v4.csv'))
$protocol = Get-Content -Raw -LiteralPath (Join-Path $packageRoot 'experiments/runtime_tests/protocol_metadata_v4.json') | ConvertFrom-Json
$architectures = @('Traditional', 'Non-MCP gateway', 'Official MCP SDK')
$callsPerTrial = $protocol.n_logical_client_identifiers * $protocol.n_deterministic_local_mock_tools
if ($trials.Count -ne ($architectures.Count * $protocol.n_trials_per_arm) -or $summaries.Count -ne $architectures.Count) {
    throw 'Jumlah baris tidak sesuai desain.'
}
foreach ($architecture in $architectures) {
    $armTrials = @($trials | Where-Object architecture -EQ $architecture)
    $armSummary = @($summaries | Where-Object architecture -EQ $architecture)
    if ($armTrials.Count -ne $protocol.n_trials_per_arm -or $armSummary.Count -ne 1) {
        throw ('Jumlah pengulangan atau ringkasan tidak sesuai: ' + $architecture)
    }
    foreach ($trialNumber in 1..$protocol.n_trials_per_arm) {
        $matched = @($armTrials | Where-Object trial -EQ $trialNumber)
        if ($matched.Count -ne 1 -or [int]$matched[0].successful_calls -ne $callsPerTrial) {
            throw ('Hasil pengulangan tidak sesuai: ' + $architecture + ', ' + $trialNumber)
        }
    }
    $total = ($armTrials | Measure-Object successful_calls -Sum).Sum
    if ([int]$armSummary[0].n -ne $armTrials.Count -or [int]$armSummary[0].calls_success -ne $total) {
        throw ('Ringkasan tidak cocok dengan data mentah: ' + $architecture)
    }
    Write-Output ('OK: ' + $architecture + ' - ' + $total + ' panggilan sukses tercatat')
}
