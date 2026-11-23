# agent-onboarding

One rules file for every AI agent you use. Claude Code, Codex, Gemini CLI, Grok, Cursor, ChatGPT and friends
all read the same `~/.agents/RULES.md`, so you edit your rules once and every tool picks them up.

## What's inside

| File | What it does |
|---|---|
| `SKILL.md` | The onboarding checklist, as a Claude Code / agent skill (`onboard-agent`) |
| `scripts/onboard.sh` | Wires a tool's global instructions file to `RULES.md` (symlink or `@import`), backing up anything it replaces |
| `scripts/ask` | `ask <agent> "<prompt>"`: lets one agent call another CLI agent, with a guard against loops |
| `templates/RULES.md` | Starter global rules: entry protocol, scope, approval list, how to work, reporting |
| `templates/AGENTS.template.md` | Per-project rules template with a curated conventions layer and an agent-maintained build-state layer |

## Install

```sh
git clone https://github.com/Parad0x-x/agent-onboarding.git
cd agent-onboarding
sh install.sh                  # copies into ~/.agents and ~/.claude/skills/onboard-agent, never overwrites
$EDITOR ~/.agents/RULES.md     # make the rules yours
~/.agents/onboard.sh all       # wire Claude Code, Gemini, Codex and Grok in one go
~/.agents/onboard.sh status
```

Optional: put `ask` on your PATH, e.g. `ln -s ~/.agents/ask ~/.local/bin/ask` (needs Python 3).

Then, in Claude Code, say "onboard ChatGPT" (or any other tool) and the skill walks you through it.

## Credits

`AGENTS.template.md` is adapted from Aaron Sulbaran's muse-friends template.

## License

MIT
