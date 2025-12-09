# NETREAPER

```
 ███╗   ██╗███████╗████████╗██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗ 
 ████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
 ██╔██╗ ██║█████╗     ██║   ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝
 ██║╚██╗██║██╔══╝     ██║   ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
 ██║ ╚████║███████╗   ██║   ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║
 ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
```

### Version 5.3.2 — Phantom Protocol

![Version](https://img.shields.io/badge/Version-5.3.2-blueviolet?style=for-the-badge)
![License](https://img.shields.io/badge/License-Apache_2.0-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-red?style=for-the-badge)
![Framework](https://img.shields.io/badge/Type-Offensive_Security-black?style=for-the-badge)

---

NETREAPER is an offensive-security framework built from necessity.  
It consolidates reconnaissance, wireless operations, scanning, exploitation, credential attacks, and post-exploitation utilities into a single, structured, menu-driven CLI.

---

## 🔥 Origin

NETREAPER began as a small wrapper to streamline repetitive device-testing workflows.  
Managing multiple tools, terminals, and commands quickly became inefficient, so the wrapper expanded — one tool at a time — until it evolved into a complete offensive-security framework.

The philosophy has always stayed the same:

> **Make the work faster.**  
> **Make the work cleaner.**  
> **Make the work easier.**

---

## ⚡ Features

- 70+ integrated security tools  
- Organized categories: Recon, Wireless, Scanning, Exploitation, Credentials, Post-Exploitation  
- Centralized logs, configs, and sessions at `~/.netreaper/`  
- Install everything or only the categories you need  
- Fast, lightweight, predictable CLI  
- Multi-distro support (Debian, RHEL, Arch, SUSE, Alpine)
- Interface validation — blocks WiFi operations on non-wireless interfaces
- Monitor mode management with verification
- Post-install guide for failed tools
- Designed for **authorized** network & Wi-Fi assessments  

---

## 🚀 Installation

```bash
git clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo bash ./netreaper-install
netreaper
```

**Install specific categories:**

```bash
sudo netreaper-install essentials  # Core tools (~500MB)
sudo netreaper-install all         # Full arsenal (~3-5GB)
sudo netreaper-install wireless    # WiFi tools only
sudo netreaper-install scanning    # Recon tools only
sudo netreaper-install uninstall   # Remove tools
```

**Supported Distros:**

| Family | Distributions | Package Manager |
|--------|---------------|-----------------|
| Debian | Kali, Parrot, Ubuntu, Debian, Mint, Pop!_OS | `apt` |
| Red Hat | Fedora, RHEL, Rocky, Alma, CentOS | `dnf`/`yum` |
| Arch | Arch, Manjaro, BlackArch, EndeavourOS | `pacman` |
| SUSE | openSUSE Tumbleweed/Leap, SLES | `zypper` |
| Alpine | Alpine Linux | `apk` |

---

## 📟 Menu Structure

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

---

## 🧰 Arsenal Overview

| Category | Description |
|----------|-------------|
| **Recon** | Subdomain enumeration, OSINT, host discovery, service fingerprinting |
| **Wireless** | Monitor mode, WPA handshake capture, deauth operations, cracking tools |
| **Scanning** | Port scans, vulnerability scans, network mapping |
| **Exploitation** | Payload runners, exploit helpers, vulnerability modules |
| **Credentials** | Brute-forcing, dictionary attacks, credential utilities |
| **Post-Exploit** | Cleanup, persistence helpers, reporting utilities |
| **Stress** | Packet flooding, bandwidth testing, network impairment |
| **OSINT** | Email harvesting, recon frameworks, attack surface mapping |

**Tools include:** nmap, masscan, rustscan, aircrack-ng, wifite, bettercap, metasploit, sqlmap, nikto, gobuster, nuclei, hashcat, john, hydra, crackmapexec, tcpdump, wireshark, hping3, theharvester, recon-ng, and 50+ more.

---

## 📁 File Structure

```
~/.netreaper/
├── config/      # User configuration
├── logs/        # Timestamped operation logs
├── output/      # Scan results, exports
├── sessions/    # Saved assessment states
└── loot/        # Captured data
```

---

## ⚠️ Legal Use Only

NETREAPER is intended solely for **authorized penetration testing** and device assessment.

- Do NOT use this on networks or systems without explicit permission
- No warranty is provided
- You assume full responsibility for your actions
- Unauthorized use may violate local, state, federal, or international laws

---

## 🛠 Troubleshooting

- View logs at: `~/.netreaper/logs/`
- Help commands: `netreaper --help` and `netreaper-install --help`
- Ensure required tools are in PATH
- Confirm your distribution supports dependencies
- Submit issues or requests on GitHub

---

## 📅 Roadmap

| Version | Status | Focus |
|---------|--------|-------|
| 5.0 | ✅ | UX overhaul, logging, wizards |
| 5.1 | ✅ | Bug fixes, input sanitization |
| 5.2 | ✅ | Multi-distro support |
| 5.3 | ✅ | Interface validation, installer improvements |
| 5.5 | 🔄 | User profiles, favorites, alias support |
| 6.0 | 📋 | Plugin & module architecture for extensions |

*(Roadmap subject to change.)*

---

## 📖 Documentation

| Document | Purpose |
|----------|---------|
| [QUICKREF.md](QUICKREF.md) | Command cheat sheet |
| [TOOL_REFERENCE.md](TOOL_REFERENCE.md) | Per-tool documentation |
| [TROUBLESHOOTING.md](TROUBLESHOOTING.md) | Common issues, fixes |
| [HOWTO.md](HOWTO.md) | Detailed guides |
| [CONTRIBUTING.md](CONTRIBUTING.md) | How to contribute |
| [SECURITY.md](SECURITY.md) | Vulnerability reporting |

---

## 🤝 Contributing

Contributions are welcome:

- Keep code modular, readable, and maintainable
- Document new modules and commands
- Maintain consistency with existing patterns
- Open an issue before large feature additions

Pull requests are reviewed on a rolling basis.

---

## 📜 License & Attribution

NETREAPER is licensed under the **Apache License 2.0**.

**Copyright © 2025 OFFTRACKMEDIA Studios**  
ABN: 84 290 819 896

- Full license: See the [LICENSE](LICENSE) file
- Project notices & third-party attributions: See the [NOTICE](NOTICE) file

Use of this project constitutes acceptance of the Apache 2.0 license and all applicable laws.

---

**[Report Bug](https://github.com/Nerds489/NETREAPER/issues)** · **[Request Feature](https://github.com/Nerds489/NETREAPER/issues)** · **[Discussions](https://github.com/Nerds489/NETREAPER/discussions)**
