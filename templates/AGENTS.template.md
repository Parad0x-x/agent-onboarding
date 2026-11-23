<!--
Project rules template. Adapted from Aaron Sulbaran's muse-friends AGENTS.template.md.
To use: copy to <repo>/AGENTS.md, fill every placeholder, delete sections that don't apply.
Claude Code and Gemini CLI don't read AGENTS.md by default, so also create <repo>/CLAUDE.md and
<repo>/GEMINI.md, each containing one line: @AGENTS.md
Codex, Grok and Cursor read AGENTS.md directly.
The global rules in ~/.agents/RULES.md still apply; this file only adds project specifics.
Delete this comment when done.
-->

# PROJECT NAME

One paragraph: what it is, who it's for, what makes it distinctive.

## Live URLs

- Production: URL
- Preview: URL
- Owner: name
- Deadline: date or "none"

## Source-of-truth docs

- `path`: what it is authoritative for (PRD, tech spec, ADRs)

This file wins on repo-wide conventions. Sibling docs (specs, NEXT_STEPS) win only on current-increment scope.

# Layer 1: Conventions (I curate this)

Agents read this layer and never edit it unless I ask.

## Stack

| Layer | Choice |
|---|---|
| Framework | |
| Language | |
| UI | |
| AI | SDK, provider, model ids |
| Storage | |
| Hosting | |
| Package manager | pick one and stick to it |

## Locked conventions

- **Code:** style, type strictness, validation library
- **Repo hygiene:** what may never be committed
- **Do not build without asking:** e.g. payments, auth changes, admin dashboards, email

## Ownership (only if several agents or people share this repo)

| Path | Owner | Notes |
|---|---|---|
| | agent or person | |

Write only inside your own area. To change someone else's, ask them first (`ask <agent>` or me).

## Tools

- Which MCP servers or skills to use for what, e.g. Context7 for library docs, chrome-devtools for UI checks.

## Common tasks

| Task | Command |
|---|---|
| Install | |
| Dev | |
| Test | |
| Build | |
| Deploy | |

# Layer 2: Build state (agents maintain this)

Update at the end of a session that shipped work: show me the diff, apply after I confirm.
Use ✅ shipped, 🔄 in flight, ⚠️ known issue or not done. Keep this file under 40,000 characters;
move old entries verbatim to AGENTS_ARCHIVE.md under `## Archived YYYY-MM-DD` instead of deleting.

## Architecture

Short file tree of the directories that matter; mark planned files with (planned).

## Current build state (YYYY-MM-DD)

- ✅
- 🔄
- ⚠️

## Environment

Env var names only, never values, each marked set / unset.

## What's next, ranked

1.
