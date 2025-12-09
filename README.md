# NETREAPER

```
 ███╗   ██╗███████╗████████╗██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗
 ████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
 ██╔██╗ ██║█████╗     ██║   ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝
 ██║╚██╗██║██╔══╝     ██║   ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
 ██║ ╚████║███████╗   ██║   ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║
 ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
```

**v6.2.0 — Phantom Protocol**

[![Version](https://img.shields.io/github/v/tag/Nerds489/NETREAPER?label=version&style=flat-square&color=ff0040)](https://github.com/Nerds489/NETREAPER/releases)
[![CI](https://img.shields.io/github/actions/workflow/status/Nerds489/NETREAPER/ci.yml?style=flat-square&label=CI)](https://github.com/Nerds489/NETREAPER/actions)
[![License](https://img.shields.io/badge/Apache_2.0-00d4ff?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/Linux-ffaa00?style=flat-square)](https://github.com/Nerds489/NETREAPER)
[![Tools](https://img.shields.io/badge/70+_tools-8B5CF6?style=flat-square)](https://github.com/Nerds489/NETREAPER)
[![Sponsor](https://img.shields.io/badge/Sponsor-♥-ff69b4?style=flat-square)](https://github.com/sponsors/Nerds489)

70+ security tools. One CLI. Stop juggling terminals.

---

## Installation

```bash
git clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo ./install.sh
```

---

## First 60 Seconds

```bash
# See what's installed
netreaper status

# Quick network scan
sudo netreaper scan 192.168.1.0/24

# Check logs
ls ~/.netreaper/logs/

# Get help
netreaper --help
```

---

## Why NETREAPER?

| Problem | NETREAPER Solution |
|---------|-------------------|
| 47 terminals, 20 tools, zero consistency | One CLI, unified logging |
| Reinstalling stack on every machine | Single installer for fleets |
| Scattered output files | Organized in ~/.netreaper/ |

---

## Dry-Run Mode

```bash
netreaper --dry-run scan 192.168.1.0/24
```

Preview commands without executing.

---

## Usage

```bash
# Core commands
netreaper scan <target>           # Network scanning
netreaper wifi                    # Wireless attacks
netreaper crack <hash>            # Password cracking
netreaper exploit <target>        # Exploitation framework
netreaper osint <domain>          # OSINT gathering
netreaper web <url>               # Web application testing

# Tool installer
sudo netreaper-install essentials # Core tools (~500MB)
sudo netreaper-install all        # Everything (~3-5GB)
sudo netreaper-install wireless   # WiFi arsenal
sudo netreaper-install scanning   # Port scanners
sudo netreaper-install exploit    # Exploitation tools
sudo netreaper-install creds      # Password crackers
sudo netreaper-install osint      # Reconnaissance

# Utilities
netreaper status                  # Check installed tools
netreaper --version               # Show version
netreaper --help                  # Full help
```

---

## What's In It

| Category | Tools |
|----------|-------|
| Scanning | nmap, masscan, rustscan, unicornscan |
| Wireless | aircrack-ng, wifite, bettercap, kismet |
| Exploitation | metasploit, sqlmap, searchsploit |
| Credentials | hashcat, john, hydra, medusa |
| Web | burpsuite, nikto, whatweb, gobuster, ffuf |
| OSINT | recon-ng, theHarvester, sherlock, maltego |
| Sniffing | wireshark, tcpdump, ettercap |
| Password | crunch, cewl, cupp |

**70+ tools total** — see `netreaper status` for full list.

---

## Architecture

```
NETREAPER/
├── bin/
│   ├── netreaper
│   └── netreaper-install
├── lib/
├── modules/
├── tests/
├── docs/
└── completions/
```

---

## What It Does

- Unified CLI for 70+ security tools
- Auto-detects Linux distro and installs correct packages
- Session-based logging in `~/.netreaper/`
- Consistent interface across all tools
- Dry-run mode for safe previews
- Shell completions for bash/zsh/fish

## What It Doesn't Do

- No GUI — terminal only
- No Windows/macOS — Linux only
- No magic — you still need to know the tools
- No warranty — use at your own risk

---

## Project History

NETREAPER has been in active development since early 2025 as an internal penetration testing toolkit.

The public GitHub repository was created December 9, 2025. Prior commit history exists only in local backups.

Expect rapid iteration until the v6.x architecture stabilizes.

---

## Legal

**Apache License 2.0** — See [LICENSE](LICENSE)

Use only on systems you own or have explicit written permission to test. Unauthorized access is illegal.

---

## Support

- [Issues](https://github.com/Nerds489/NETREAPER/issues)
- [Releases](https://github.com/Nerds489/NETREAPER/releases)
- [Sponsor](https://github.com/sponsors/Nerds489)

---

**© 2025 OFFTRACKMEDIA Studios**
