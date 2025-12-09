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

<h3 align="center">v6.2.0 — Phantom Protocol</h3>

<p align="center">
  <a href="https://github.com/Nerds489/NETREAPER/releases"><img src="https://img.shields.io/github/v/tag/Nerds489/NETREAPER?label=version&style=flat-square&color=ff0040" alt="Version"></a>
  <a href="https://github.com/Nerds489/NETREAPER/actions"><img src="https://img.shields.io/github/actions/workflow/status/Nerds489/NETREAPER/ci.yml?style=flat-square&label=CI" alt="CI"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-Apache_2.0-00d4ff?style=flat-square" alt="License"></a>
  <a href="https://github.com/Nerds489/NETREAPER"><img src="https://img.shields.io/badge/platform-Linux-ffaa00?style=flat-square" alt="Platform"></a>
  <a href="https://github.com/Nerds489/NETREAPER"><img src="https://img.shields.io/badge/tools-70+-8B5CF6?style=flat-square" alt="Tools"></a>
  <a href="https://github.com/sponsors/Nerds489"><img src="https://img.shields.io/badge/sponsor-♥-ff69b4?style=flat-square" alt="Sponsor"></a>
</p>

<p align="center"><strong>70+ security tools. One CLI. Stop juggling terminals.</strong></p>

---

## Installation
```bash
git clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo ./install.sh
```

**Install options:**
```bash
sudo ./bin/netreaper-install essentials  # Core tools (~500MB)
sudo ./bin/netreaper-install all         # Everything (~3-5GB)
sudo ./bin/netreaper-install wireless    # WiFi arsenal
sudo ./bin/netreaper-install scanning    # Port scanners
sudo ./bin/netreaper-install exploit     # Exploitation tools
sudo ./bin/netreaper-install creds       # Password crackers
sudo ./bin/netreaper-install osint       # Reconnaissance
```

**Works on:** Kali, Parrot, Ubuntu, Debian, Fedora, RHEL, Arch, Manjaro, openSUSE, Alpine

---

## First 60 Seconds
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

## Architecture
````
NETREAPER/
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
├── docs/                      # Documentation
├── completions/               # Shell completions (bash, fish, zsh)
└── install.sh                 # Wrapper installer
What It Does
Wraps tools — Unified interface, consistent output format
Organizes output — Everything goes to ~/.netreaper/
Validates targets — Blocks dangerous operations by default
Logs everything — Timestamped audit trail for all operations
Works everywhere — Detects distro, uses correct package manager
What It Doesn't Do
Replace knowing the underlying tools
Give you permission to test things you don't own
Make unauthorized access legal
Project History
NETREAPER has been in active development and private use since early 2025 as an internal penetration testing toolkit.

The public GitHub repository was created on December 9, 2025 after an OS reflash; prior commit history exists only in local backups.

Expect rapid iteration until the v6.x module-based architecture fully stabilizes.

Legal
Apache License 2.0 — See LICENSE

Authorized testing only. You need written permission for any system you test. You are responsible for your actions. Unauthorized access is a crime.

No EULA. No additional terms.

Support
If NETREAPER saves you time, consider sponsoring:

Show Image

Links
Releases
Issues
Discussions
Documentation
<p align="center">© 2025 OFFTRACKMEDIA Studios — Apache 2.0</p> `````
