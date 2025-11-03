# Gmome Attack - Backlog Summary

This file is generated from `backlog_tickets.json`. Run `generate_backlog_readme.ps1` to refresh.

Generated: 2025-11-03 11:47:02
Source: `backlog_tickets.json`

---

## Overview
The backlog contains the tickets stored in the JSON file. Each entry includes ID, title, status, priority, description, and subtasks (if any).

---

## Tickets

### ID 9 - Add loadout save/load system
- Status: not-started
- Priority: medium
- Created: 2025-11-03
- Description: Save and load custom tower loadouts between games. Persist selected towers, quantities, and unlocked towers to disk or player profile.

---

### ID 10 - Tower unlock progression
- Status: not-started
- Priority: medium
- Created: 2025-11-03
- Description: Unlock more tower types as player progresses through waves. Design unlock criteria, UI indicators, and progression persistence.

---

### ID 12 - Menu visibility & debugging backlog
- Status: not-started
- Priority: high
- Created: 2025-11-03
- Description: Improvements to make the tower menu impossible to miss and easier to debug. Subtasks included below.

Subtasks:
- 12.1 - Draw a temporary bright/red panel for testing visibility [not-started]
- 12.2 - Add selection glow or highlight on the clicked tower when menu opens [not-started]
- 12.3 - Add more verbose tracing (mouse coords, tower coords, menu create/destroy traces) [not-started]
- 12.4 - Optionally add a 'force front fixed depth' toggle [not-started]

---

## How to update
Edit `backlog_tickets.json` and run the script to regenerate this README:
```powershell
cd "D:\GameMakerFiles\Gmome Attack"
powershell -ExecutionPolicy Bypass -File .\generate_backlog_readme.ps1
```
