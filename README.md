# ☠️ NETREAPER

```
 ███╗   ██╗███████╗████████╗██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗
 ████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
 ██╔██╗ ██║█████╗     ██║   ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝
 ██║╚██╗██║██╔══╝     ██║   ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
 ██║ ╚████║███████╗   ██║   ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║
 ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
```

**v6.0.0 — Phantom Protocol**

[![Version](https://img.shields.io/badge/v6.0.0-ff0040?style=flat-square)](https://github.com/Nerds489/NETREAPER/releases)
[![License](https://img.shields.io/badge/Apache_2.0-00d4ff?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/Linux-ffaa00?style=flat-square)](https://github.com/Nerds489/NETREAPER)
[![Tools](https://img.shields.io/badge/70+_tools-8B5CF6?style=flat-square)](https://github.com/Nerds489/NETREAPER)
[![Sponsor](https://img.shields.io/badge/Sponsor-♥-ff69b4?style=flat-square)](https://github.com/sponsors/Nerds489)

---

70+ security tools. One CLI. Stop juggling terminals.

---

## Install

```bash
git clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo ./netreaper-install
```

**Options:**

```bash
sudo netreaper-install essentials  # Core tools (~500MB)
sudo netreaper-install all         # Everything (~3-5GB)
sudo netreaper-install wireless    # WiFi arsenal
sudo netreaper-install scanning    # Port/service scanners
sudo netreaper-install exploit     # Exploitation tools
sudo netreaper-install creds       # Password crackers
sudo netreaper-install osint       # Reconnaissance
sudo netreaper-install status      # What's installed
```

**Works on:** Kali, Parrot, Ubuntu, Debian, Fedora, RHEL, Arch, Manjaro, openSUSE, Alpine

---

## Usage

```bash
sudo netreaper                      # Interactive menu
sudo netreaper scan 192.168.1.0/24  # Scan subnet
sudo netreaper wifi --monitor wlan0 # Monitor mode
sudo netreaper wizard scan          # Guided wizard
sudo netreaper status               # Tool status
```

---

## What's In It

| Category | Tools |
|----------|-------|
| **Recon** | nmap, masscan, rustscan, netdiscover, dnsenum, sslscan |
| **Wireless** | aircrack-ng, wifite, bettercap, reaver, hcxdumptool |
| **Exploit** | metasploit, sqlmap, nikto, gobuster, nuclei, wpscan |
| **Creds** | hashcat, john, hydra, medusa, crackmapexec |
| **Traffic** | tcpdump, wireshark, hping3, iperf3 |
| **OSINT** | theharvester, recon-ng, shodan, amass |

Plus 40+ more. Run `netreaper status` for the full list.

---

## v6.0 Architecture

```
NETREAPER/
├── netreaper              # Main dispatcher
├── netreaper-install      # Arsenal installer
├── lib/                   # Core libraries
│   ├── core.sh            # Logging, colors, paths
│   ├── ui.sh              # Menus and prompts
│   ├── safety.sh          # Authorization & validation
│   ├── detection.sh       # System detection
│   └── utils.sh           # Helpers
├── modules/               # Feature modules
│   ├── recon.sh
│   ├── wireless.sh
│   ├── scanning.sh
│   ├── exploit.sh
│   ├── credentials.sh
│   ├── traffic.sh
│   └── osint.sh
└── tests/                 # Bats test suite
```

---

## What It Does

- **Wraps tools** — Unified interface, consistent output
- **Organizes output** — Everything goes to `~/.netreaper/`
- **Validates targets** — Blocks dangerous operations by default
- **Logs everything** — Timestamped audit trail
- **Works everywhere** — Detects distro, uses correct package manager

## What It Doesn't Do

- Replace knowing the underlying tools
- Give you permission to test things you don't own
- Make unauthorized access legal

---

## Legal

**Authorized testing only.**

You need written permission. You're responsible for your actions. Unauthorized access is a crime.

See [LICENSE](LICENSE) and [NOTICE](NOTICE) for full terms.

---

## Support

If NETREAPER saves you time, consider sponsoring:

[![Sponsor Nerds489](https://img.shields.io/badge/Sponsor_on_GitHub-♥-ff69b4?style=for-the-badge&logo=github-sponsors)](https://github.com/sponsors/Nerds489)

---

## Links

- [Releases](https://github.com/Nerds489/NETREAPER/releases)
- [Issues](https://github.com/Nerds489/NETREAPER/issues)
- [Discussions](https://github.com/Nerds489/NETREAPER/discussions)

---

**© 2025 OFFTRACKMEDIA Studios** — Apache 2.0
