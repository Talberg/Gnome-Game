# Regenerate BACKLOG_README.md from backlog_tickets.json
# Usage: powershell -ExecutionPolicy Bypass -File .\generate_backlog_readme.ps1

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$jsonPath = Join-Path $root 'backlog_tickets.json'
$readmePath = Join-Path $root 'BACKLOG_README.md'

if (-Not (Test-Path $jsonPath)) {
    Write-Error "backlog_tickets.json not found at $jsonPath"
    exit 1
}

$data = Get-Content $jsonPath -Raw | ConvertFrom-Json
$now = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$md = @()
$md += ('# ' + $data.project + ' - Backlog Summary')
$md += ''
$md += 'This file is generated from `backlog_tickets.json`. Run `generate_backlog_readme.ps1` to refresh.'
$md += ''
$md += ('Generated: ' + $now)
$md += 'Source: `backlog_tickets.json`'
$md += ''
$md += '---'
$md += ''
$md += '## Overview'
$md += 'The backlog contains the tickets stored in the JSON file. Each entry includes ID, title, status, priority, description, and subtasks (if any).'
$md += ''
$md += '---'
$md += ''
$md += '## Tickets'

foreach ($ticket in $data.tickets) {
    $md += ''
    $md += ('### ID ' + [string]$ticket.id + ' - ' + $ticket.title)
    $md += ('- Status: ' + $ticket.status)
    if ($ticket.priority) { $md += ('- Priority: ' + $ticket.priority) }
    if ($ticket.created) { $md += ('- Created: ' + $ticket.created) }
    if ($ticket.description) {
        $md += ('- Description: ' + $ticket.description)
    }
    $md += ''
    if ($ticket.subtasks) {
        $md += 'Subtasks:'
        foreach ($st in $ticket.subtasks) {
            $sid = [string]$st.sub_id
            $md += ('- ' + $sid + ' - ' + $st.title + ' [' + $st.status + ']')
        }
        $md += ''
    }
    $md += '---'
}

$md += ''
$md += '## How to update'
$md += 'Edit `backlog_tickets.json` and run the script to regenerate this README:'
$md += '```powershell'
$md += ('cd "' + $root + '"')
$md += 'powershell -ExecutionPolicy Bypass -File .\generate_backlog_readme.ps1'
$md += '```'

$md -join "`n" | Out-File -FilePath $readmePath -Encoding UTF8
Write-Output ('Wrote ' + $readmePath)
