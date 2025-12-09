<p align="center">
  <pre>
 ███╗   ██╗███████╗████████╗██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗
 ████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
 ██╔██╗ ██║█████╗     ██║   ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝
 ██║╚██╗██║██╔══╝     ██║   ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
 ██║ ╚████║███████╗   ██║   ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║
 ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
  </pre>
</p>

<h3 align="center">v6.2.1 — Phantom Protocol</h3>

<p align="center">
  <a href="https://github.com/Nerds489/NETREAPER/releases"><img src="https://img.shields.io/github/v/tag/Nerds489/NETREAPER?label=version&style=flat-square&color=ff0040" alt="Version"></a>
  <a href="https://github.com/Nerds489/NETREAPER/actions"><img src="https://img.shields.io/github/actions/workflow/status/Nerds489/NETREAPER/ci.yml?style=flat-square&label=CI" alt="CI"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-Apache_2.0-00d4ff?style=flat-square" alt="License"></a>
  <a href="https://github.com/Nerds489/NETREAPER"><img src="https://img.shields.io/badge/platform-Linux-ffaa00?style=flat-square" alt="Platform"></a>
  <a href="https://github.com/Nerds489/NETREAPER"><img src="https://img.shields.io/badge/tools-70+-8B5CF6?style=flat-square" alt="Tools"></a>
  <a href="https://github.com/sponsors/Nerds489"><img src="https://img.shields.io/badge/sponsor-♥-ff69b4?style=flat-square" alt="Sponsor"></a>
</p>

<p align="center"><strong>70+ security tools. One CLI. Stop juggling terminals.</strong><br/>
<strong>v6.2.1</strong> brings the bin/ restructure, CI-safe non-interactive mode, Apache 2.0-only licensing, and official shell completions.</p>

---

## v6.2.1 Highlights
- Executables now live in `bin/` and are fronted by root-level wrappers (`netreaper`, `netreaper-install`) so CI, first-run tests, and legacy scripts that call `./netreaper` keep working.
- `install.sh` simply dispatches to `bin/netreaper-install`, keeping the repository root clean while exposing wrappers for local runs.
- Non-interactive mode detects `NR_NON_INTERACTIVE=1` **or** the absence of a TTY, skips the wizard, auto-accepts legal text, and keeps CI from hanging.
- Documentation, quickstart, and helper docs were rewritten to match the new layout; everything now lives under `docs/`.
- Official Bash, Zsh, and Fish completions ship in `completions/`; copy them into your shell’s completion directory to enable them.
- Smoke tests under `tests/smoke/` validate the wrapper binaries plus `--version`/`--help`, mirroring how CI executes the toolkit.
- Apache 2.0 is the only license—there is no separate EULA or interactive legal prompt for automated environments.

---

## Installation
```bash
git clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo ./install.sh
```

> `install.sh` now delegates straight to `bin/netreaper-install`. The repository root stays tidy while still exposing wrapper scripts (`./netreaper`, `./netreaper-install`) that mirror the system-wide binaries.

**Install options:**
```bash
sudo ./netreaper-install essentials  # Core tools (~500MB) from the repo wrapper
sudo ./netreaper-install all         # Everything (~3-5GB)
sudo ./netreaper-install wireless    # WiFi arsenal
sudo ./netreaper-install scanning    # Port scanners
sudo ./netreaper-install exploit     # Exploitation tools
sudo ./netreaper-install creds       # Password crackers
sudo ./netreaper-install osint       # Reconnaissance
```

> After installation these wrappers land in `/usr/local/bin/`, so `sudo netreaper-install ...` works everywhere without the leading `./`.

**Works on:** Kali, Parrot, Ubuntu, Debian, Fedora, RHEL, Arch, Manjaro, openSUSE, Alpine

---

## First 60 Seconds
> Running directly from the clone? Use `./netreaper` (wrapper) instead of `netreaper`. Both forward to the same `bin/` executable once installed.
```bash
# 1. See what's installed and ready
netreaper status

# 2. Run a quick network scan
sudo netreaper scan 192.168.1.0/24

# 3. Check your logs
ls ~/.netreaper/logs/

# 4. Get help
netreaper --help
```

---

## Non-Interactive & CI Mode
- NETREAPER now treats `NR_NON_INTERACTIVE=1` **or** the absence of a TTY as a full non-interactive session.
- `is_non_interactive()` skips the first-run wizard entirely, marks `FIRST_RUN_COMPLETE=true`, and auto-generates the legal acceptance file.
- Wrapper scripts in the repo root (`./netreaper`, `./netreaper-install`) mirror the installed binaries so CI can keep invoking the historical `./netreaper ...` paths.
- Prompts that would normally block are auto-accepted, so tests never hang waiting for STDIN.

```bash
# Example: force non-interactive behavior locally
NR_NON_INTERACTIVE=1 ./netreaper status
NR_NON_INTERACTIVE=1 ./netreaper-install --help
```

---

## Why NETREAPER?

| Problem | NETREAPER Solution |
|---------|-------------------|
| 47 terminal windows, 20 tools, zero consistency | One entrypoint, unified logging, shared config |
| Reinstalling your stack on every new machine | Single installer, reproducible setup for fleets |
| Forgetting which flags work with which tool | Consistent interface, built-in presets |
| Scattered output files everywhere | Organized session-based output in `~/.netreaper/` |

---

## Dry-Run Mode

Preview what commands would run without executing:
```bash
netreaper --dry-run scan 192.168.1.0/24
sudo netreaper --dry-run wifi monitor wlan0
```

All commands print with `[DRY-RUN]` prefix instead of executing. Safe to test.

---

## Shell Completions
NETREAPER ships shell completions in `completions/`—copy them into your shell’s completion path and reload.

**Bash**
```bash
sudo cp completions/netreaper.bash /etc/bash_completion.d/netreaper
source /etc/bash_completion
```

**Zsh**
```bash
mkdir -p ~/.zsh/completions
cp completions/netreaper.zsh ~/.zsh/completions/_netreaper
echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc
autoload -U compinit && compinit
```

**Fish**
```bash
mkdir -p ~/.config/fish/completions
cp completions/netreaper.fish ~/.config/fish/completions/netreaper.fish
```

---

## Usage
```bash
sudo netreaper                      # Interactive menu
sudo netreaper scan 192.168.1.0/24  # Scan subnet
sudo netreaper wifi monitor wlan0   # Enable monitor mode
sudo netreaper wizard scan          # Guided wizard
sudo netreaper status               # Show tool status
netreaper --help                    # Full help
```

---

## What's In It

| Category | Tools |
|----------|-------|
| **Recon** | nmap, masscan, rustscan, netdiscover, dnsenum, sslscan |
| **Wireless** | aircrack-ng, wifite, bettercap, reaver, hcxdumptool, mdk4 |
| **Exploit** | metasploit, sqlmap, nikto, gobuster, nuclei, wpscan |
| **Creds** | hashcat, john, hydra, medusa, crackmapexec |
| **Traffic** | tcpdump, wireshark, tshark, hping3, iperf3 |
| **OSINT** | theharvester, recon-ng, shodan, amass, subfinder |

Plus 40+ more. Run `netreaper status` for the full list.

---

## Testing & QA
- `tests/smoke/test_help.sh` and `tests/smoke/test_version.sh` exercise the wrapper binaries exactly how CI calls them.
- Set `NR_NON_INTERACTIVE=1` (or rely on the default TTY detection) so the wizard and legal prompts are skipped automatically.
- Full Bats coverage still lives under `tests/*.bats` for module-level validation.

```bash
chmod +x tests/smoke/*.sh
NR_NON_INTERACTIVE=1 tests/smoke/test_help.sh
NR_NON_INTERACTIVE=1 tests/smoke/test_version.sh
bats tests/*.bats
```

---

## Architecture
````
NETREAPER/
├── netreaper              # Root wrapper that forwards to bin/netreaper
├── netreaper-install      # Root wrapper for the installer
├── bin/
│   ├── netreaper              # Main CLI
│   └── netreaper-install      # Arsenal installer
├── lib/
│   ├── core.sh                # Logging, colors, paths
│   ├── ui.sh                  # Menus and prompts
│   ├── safety.sh              # Authorization & validation
│   ├── detection.sh           # Distro detection
│   └── utils.sh               # Helpers
├── modules/
│   ├── recon.sh
│   ├── wireless.sh
│   ├── scanning.sh
│   ├── exploit.sh
│   ├── credentials.sh
│   ├── traffic.sh
│   └── osint.sh
├── tests/
│   ├── smoke/                 # Quick validation tests
│   └── *.bats                 # Full test suite
├── docs/                      # Documentation set
├── completions/               # Shell completions (bash, fish, zsh)
├── VERSION                    # Single source of truth for version bumps
└── install.sh                 # Wrapper installer (delegates to bin/)
````

### What It Does
- Wraps dozens of tools with unified logging/output.
- Organizes everything under `~/.netreaper/` per session.
- Validates targets and blocks obviously dangerous operations by default.
- Logs each command in timestamped audit trails.
- Detects your distro and runs the appropriate package manager.

### What It Doesn't Do
- Replace your knowledge of the underlying tools.
- Give you permission to test things you don’t own.
- Make unauthorized access legal.

### Project History
NETREAPER has been in active development and private use since early 2025 as an internal penetration testing toolkit. The public GitHub repository was created on December 9, 2025 after an OS reflash; prior commit history exists only in local backups. Expect rapid iteration until the v6.x module-based architecture fully stabilizes.

### Legal
Apache License 2.0 — see `LICENSE`. Authorized testing only; you need written permission for any system you test. You are responsible for your actions. No EULA. No additional terms.

### Support
If NETREAPER saves you time, consider sponsoring or opening a discussion/issue for feedback.

<p align="center">© 2025 OFFTRACKMEDIA Studios — Apache 2.0</p>
