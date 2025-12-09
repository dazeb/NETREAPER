# NETREAPER

```
 ███╗   ██╗███████╗████████╗██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗ 
 ████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
 ██╔██╗ ██║█████╗     ██║   ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝
 ██║╚██╗██║██╔══╝     ██║   ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
 ██║ ╚████║███████╗   ██║   ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║
 ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
```

<p align="center">
  <strong>Network Security & WiFi Assessment Framework</strong><br>
  <em>70+ tools. One unified CLI. Built for professionals.</em>
</p>

<p align="center">
  <a href="https://github.com/Nerds489/NETREAPER/releases"><img src="https://img.shields.io/github/v/release/Nerds489/NETREAPER?style=flat-square&label=Version&color=blue" alt="Version"></a>
  <a href="https://github.com/Nerds489/NETREAPER/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-Apache%202.0-green?style=flat-square" alt="License"></a>
  <a href="https://github.com/Nerds489/NETREAPER/stargazers"><img src="https://img.shields.io/github/stars/Nerds489/NETREAPER?style=flat-square" alt="Stars"></a>
  <a href="https://github.com/Nerds489/NETREAPER/network/members"><img src="https://img.shields.io/github/forks/Nerds489/NETREAPER?style=flat-square" alt="Forks"></a>
  <a href="https://github.com/Nerds489/NETREAPER/graphs/contributors"><img src="https://img.shields.io/github/contributors/Nerds489/NETREAPER?style=flat-square" alt="Contributors"></a>
  <a href="https://github.com/Nerds489/NETREAPER/issues"><img src="https://img.shields.io/github/issues/Nerds489/NETREAPER?style=flat-square" alt="Issues"></a>
</p>

<p align="center">
  <a href="#installation">Installation</a> •
  <a href="#features">Features</a> •
  <a href="#usage">Usage</a> •
  <a href="#documentation">Docs</a> •
  <a href="#authorization-requirements">Authorization</a>
</p>

---

## Overview

NETREAPER is an offensive-security framework that consolidates reconnaissance, wireless assessment, scanning, exploitation, credential testing, and post-exploitation utilities into a single, structured CLI.

Built from necessity. Maintained with purpose.

### Why NETREAPER?

| Challenge | Solution |
|-----------|----------|
| Managing dozens of terminal windows | Single unified interface |
| Remembering syntax for 70+ tools | Guided menus and wizards |
| Scattered logs and output files | Centralized at `~/.netreaper/` |
| Inconsistent workflows across distros | Multi-distribution support |
| Time lost context-switching | Streamlined category-based navigation |

---

## Features

- **70+ integrated security tools** — Reconnaissance, wireless, exploitation, credentials, and more
- **Multi-distribution support** — Debian, RHEL, Arch, SUSE, Alpine
- **Centralized workspace** — Configs, logs, sessions, and findings in one location
- **Modular installation** — Install everything or only what you need
- **Interface validation** — Automatic wireless interface detection and verification
- **Monitor mode management** — Built-in mode switching with state verification
- **Session management** — Save and resume assessment states
- **Compliance-ready logging** — Timestamped audit trails for all operations

---

## Installation

```bash
git clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo bash ./netreaper-install
netreaper
```

### Installation Options

```bash
# Core tools only (~500MB, ~5 min)
sudo netreaper-install essentials

# Full framework (~3-5GB, ~15-30 min)
sudo netreaper-install all

# Category-specific installation
sudo netreaper-install wireless    # WiFi assessment tools
sudo netreaper-install scanning    # Reconnaissance tools
sudo netreaper-install exploit     # Exploitation tools
sudo netreaper-install creds       # Credential testing tools

# Remove installed tools
sudo netreaper-install uninstall
```

### Supported Distributions

| Family | Distributions | Package Manager |
|--------|---------------|-----------------|
| Debian | Kali, Parrot, Ubuntu, Debian, Mint, Pop!_OS | apt |
| Red Hat | Fedora, RHEL, Rocky, Alma, CentOS | dnf/yum |
| Arch | Arch, Manjaro, BlackArch, EndeavourOS | pacman |
| SUSE | openSUSE Tumbleweed/Leap, SLES | zypper |
| Alpine | Alpine Linux | apk |

---

## Usage

### Interactive Mode

```bash
netreaper
```

```
┌─────────────────────────────────────────────────────────────┐
│                        NETREAPER                            │
├─────────────────────────────────────────────────────────────┤
│  [1] Recon          [2] Wireless       [3] Exploit         │
│  [4] Stress         [5] Tools          [6] OSINT           │
│  [7] Credentials    [8] Post-Exploit                       │
│                                                             │
│  [S] Sessions       [C] Config         [H] Help            │
│                         [Q] Quit                            │
└─────────────────────────────────────────────────────────────┘
```

### Direct Commands

```bash
# Quick scan
netreaper scan 192.168.1.0/24 --quick

# Full vulnerability assessment
netreaper scan 10.0.0.1 --full --vuln

# Wireless interface setup
netreaper wifi --monitor wlan0

# Session management
netreaper session start
netreaper session list
netreaper session resume <id>

# Tool status
netreaper status
netreaper --version
netreaper --help
```

---

## Tool Categories

### Reconnaissance
Subdomain enumeration, OSINT gathering, host discovery, service fingerprinting

`nmap` · `masscan` · `rustscan` · `netdiscover` · `dnsenum` · `sslscan` · `enum4linux`

### Wireless Assessment
Monitor mode management, handshake capture, WPS testing, traffic analysis

`aircrack-ng` · `airodump-ng` · `aireplay-ng` · `wifite` · `bettercap` · `reaver` · `hostapd`

### Exploitation
Web application testing, SQL injection, vulnerability scanning, payload delivery

`metasploit` · `sqlmap` · `nikto` · `gobuster` · `wpscan` · `searchsploit` · `nuclei`

### Credential Testing
Hash analysis, dictionary attacks, protocol brute-forcing, credential validation

`hashcat` · `john` · `hydra` · `medusa` · `crackmapexec` · `impacket`

### Traffic Analysis
Packet capture, protocol analysis, network monitoring

`tcpdump` · `wireshark` · `tshark`

### OSINT
Email harvesting, attack surface mapping, intelligence frameworks

`theharvester` · `recon-ng` · `shodan`

---

## File Structure

```
~/.netreaper/
├── config/      # User configuration files
├── logs/        # Timestamped operation logs
├── output/      # Scan results and exports
├── sessions/    # Saved assessment states
└── captures/    # Captured data and findings
```

---

## Documentation

| Document | Purpose |
|----------|---------|
| [QUICKREF.md](QUICKREF.md) | Command cheat sheet |
| [TOOL_REFERENCE.md](TOOL_REFERENCE.md) | Per-tool documentation |
| [HOWTO.md](HOWTO.md) | Detailed usage guides |
| [TROUBLESHOOTING.md](TROUBLESHOOTING.md) | Common issues and fixes |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guidelines |
| [SECURITY.md](SECURITY.md) | Vulnerability reporting |
| [CHANGELOG.md](CHANGELOG.md) | Version history |

---

## Authorization Requirements

> **NETREAPER is designed exclusively for authorized security assessments.**

### Before Use

- [ ] Obtain **written authorization** from the system/network owner
- [ ] Define **scope boundaries** clearly in documentation
- [ ] Ensure **legal compliance** with local, state, and federal laws
- [ ] Maintain **audit logs** for all assessment activities
- [ ] Follow your organization's **rules of engagement**

### Compliance Notes

- All operations are logged to `~/.netreaper/logs/` with timestamps
- Session management provides assessment state documentation
- Output files are organized for report generation

**Unauthorized access to computer systems is a criminal offense.**  
Users assume full responsibility for ensuring proper authorization exists before conducting any assessment.

---

## Roadmap

| Version | Status | Focus |
|---------|--------|-------|
| 5.0 | ✅ Complete | UX overhaul, logging system, guided wizards |
| 5.1 | ✅ Complete | Bug fixes, input sanitization |
| 5.2 | ✅ Complete | Multi-distribution support |
| 5.3 | ✅ Complete | Interface validation, installer improvements |
| 5.5 | 🔄 In Progress | User profiles, favorites, alias support |
| 6.0 | 📋 Planned | Plugin architecture, custom module support |

---

## Contributing

Contributions are welcome. Please review [CONTRIBUTING.md](CONTRIBUTING.md) before submitting.

**Guidelines:**
- Keep code modular and readable
- Document new features and commands
- Maintain consistency with existing patterns
- Open an issue before major feature additions
- Include relevant test cases where applicable

---

## Support

- **Issues:** [GitHub Issues](https://github.com/Nerds489/NETREAPER/issues)
- **Discussions:** [GitHub Discussions](https://github.com/Nerds489/NETREAPER/discussions)
- **Logs:** `~/.netreaper/logs/`
- **Help:** `netreaper --help`

---

## License

Licensed under the **Apache License 2.0** — see [LICENSE](LICENSE) for details.

**© 2025 OFFTRACKMEDIA Studios**  
ABN: 84 290 819 896

Third-party attributions: [NOTICE](NOTICE.txt)

---

<p align="center">
  <a href="https://github.com/Nerds489/NETREAPER/issues/new?template=bug_report.md">Report Bug</a> •
  <a href="https://github.com/Nerds489/NETREAPER/issues/new?template=feature_request.md">Request Feature</a> •
  <a href="https://github.com/Nerds489/NETREAPER/discussions">Discussions</a>
</p>
