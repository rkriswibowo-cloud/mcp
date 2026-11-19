$ErrorActionPreference = 'Stop'
$root = (Get-Item -LiteralPath $PSScriptRoot).Parent.Parent.FullName
$protocol = Get-Content -Raw -LiteralPath (Join-Path $root 'experiments/runtime_tests/protocol_metadata_v4.json') | ConvertFrom-Json
$trials = Import-Csv -LiteralPath (Join-Path $root 'datasets/raw/raw_trials_v4.csv')
$clientCount = $protocol.n_logical_client_identifiers
$toolCount = $protocol.n_deterministic_local_mock_tools
if ($clientCount -le 0 -or $toolCount -le 0) { throw 'Invalid experiment design.' }
$rows = foreach ($trial in $trials) {
    if ([int]$trial.successful_calls -ne ($clientCount * $toolCount)) {
        throw 'Cannot infer individual outcomes from a partial success count.'
    }
    foreach ($clientSlot in 1..$clientCount) {
        foreach ($toolSlot in 1..$toolCount) {
            [pscustomobject]@{
                architecture = $trial.architecture
                trial = [int]$trial.trial
                client_slot = $clientSlot
                tool_slot = $toolSlot
                status = 'success'
                data_origin = 'synthetic_from_trial_aggregate'
            }
        }
    }
}
$rows | Export-Csv -LiteralPath (Join-Path $root 'datasets/synthetic/call_slots_v4.csv') -NoTypeInformation -Encoding Ascii
