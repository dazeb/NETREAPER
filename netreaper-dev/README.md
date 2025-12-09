# NETREAPER Development Kit

Everything you need to maintain, release, and evolve NETREAPER.

---

## 📁 What's In This Folder

| File | Purpose | When to Use |
|------|---------|-------------|
| `LICENSE` | Apache 2.0 license | Copy to repo root |
| `NOTICE` | Third-party attributions | Copy to repo root |
| `SCRIPT_HEADER.txt` | SPDX header for scripts | Paste at top of .sh files |
| `ADD_HEADERS_PROMPT.md` | Prompt to add headers | Run in Claude Code CLI |
| `RELEASE_CHECKLIST.md` | Release process | Every version bump |
| `NETREAPER_Roadmap_and_Refactor_Guide.md` | High-level plan | Planning sessions |
| `NETREAPER_v6_Implementation_Prompts.md` | Step-by-step refactor | v6.0 development |

---

## 🚀 Quick Actions

### First Time Setup

```bash
# Copy license files to repo
cp LICENSE ~/NETREAPER/
cp NOTICE ~/NETREAPER/

# Add SPDX headers to scripts (use the prompt)
# Run ADD_HEADERS_PROMPT.md in Claude Code CLI
```

### Every Release

Follow `RELEASE_CHECKLIST.md`:

1. Update VERSION file
2. Update VERSION in netreaper and netreaper-install
3. Update CHANGELOG.md
4. Generate checksums
5. Syntax check
6. Commit with version message
7. Tag the release
8. Push to GitHub
9. Create GitHub Release with notes

### Quick Version Bump

```bash
cd ~/NETREAPER
VERSION="5.3.3"

echo "$VERSION" > VERSION
sed -i "s/VERSION=\"[^\"]*\"/VERSION=\"$VERSION\"/" netreaper
sha256sum netreaper netreaper-install > checksums.sha256
bash -n netreaper && bash -n netreaper-install && echo "✓ OK"

git add . && git commit -m "v$VERSION: Description"
git tag "v$VERSION"
git push origin main && git push origin "v$VERSION"
```

---

## 🔧 v6.0 Refactor

When ready to modularize:

1. Read `NETREAPER_Roadmap_and_Refactor_Guide.md` for context
2. Follow `NETREAPER_v6_Implementation_Prompts.md` phase by phase
3. Run one phase per session
4. Verify after each phase with `bash -n`

**Estimated time:** 8-10 hours total

---

## 📋 File Checklist for Repo

Ensure these exist in NETREAPER repo root:

```
NETREAPER/
├── LICENSE              ← From this kit
├── NOTICE               ← From this kit
├── README.md            ← Already exists
├── CHANGELOG.md         ← Create if missing
├── VERSION              ← Create: echo "5.3.2" > VERSION
├── checksums.sha256     ← Generate each release
├── netreaper            ← Has SPDX header
├── netreaper-install    ← Has SPDX header
└── docs/
    ├── QUICKREF.md
    ├── TOOL_REFERENCE.md
    ├── TROUBLESHOOTING.md
    ├── HOWTO.md
    └── CONTRIBUTING.md
```

---

## 🏷️ Version Format

```
NETREAPER:  5.MINOR.PATCH  (e.g., 5.3.2)
Installer:  2.MINOR.PATCH  (e.g., 2.3.2)

Patch = bug fixes
Minor = new features
Major = breaking changes / architecture
```

---

## 📞 Reference

- **Repo:** https://github.com/Nerds489/NETREAPER
- **Issues:** https://github.com/Nerds489/NETREAPER/issues
- **Copyright:** OFFTRACKMEDIA Studios (ABN: 84 290 819 896)
- **License:** Apache 2.0
