<![CDATA[<div align="center">

# NETREAPER

```
 ███╗   ██╗███████╗████████╗██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗ 
 ████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
 ██╔██╗ ██║█████╗     ██║   ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝
 ██║╚██╗██║██╔══╝     ██║   ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
 ██║ ╚████║███████╗   ██║   ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║
 ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
```

### Unified Offensive Security Framework

**v5.3.2 · Phantom Protocol**

<br>

[![Version](https://img.shields.io/badge/version-5.3.2-ff0040?style=for-the-badge&logo=ghost&logoColor=white)](https://github.com/Nerds489/NETREAPER/releases)
[![License](https://img.shields.io/badge/license-Apache_2.0-00d4ff?style=for-the-badge&logo=apache&logoColor=white)](LICENSE)
[![Platform](https://img.shields.io/badge/linux-Multi--Distro-ffaa00?style=for-the-badge&logo=linux&logoColor=white)](https://github.com/Nerds489/NETREAPER)
[![Bash](https://img.shields.io/badge/bash-5.0+-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Tools](https://img.shields.io/badge/tools-70+-8B5CF6?style=for-the-badge&logo=hackthebox&logoColor=white)](https://github.com/Nerds489/NETREAPER)

<br>

[Installation](#-installation) · [Features](#-features) · [Arsenal](#-arsenal) · [Usage](#-usage) · [Docs](#-documentation) · [Legal](#%EF%B8%8F-legal)

---

</div>

## Origin

NETREAPER started as a small wrapper to speed up repetitive device-testing workflows. Managing multiple tools, terminals, and commands got inefficient fast—so the wrapper grew. One tool at a time, it evolved into a complete offensive security framework.

The philosophy never changed:

> **Make the work faster. Make the work cleaner. Make the work repeatable.**

This isn't a replacement for learning the underlying tools. It's a force multiplier for people who already know them.

---

## ⚡ Installation

```bash
git clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo bash ./netreaper-install
```

**Selective install:**

```bash
sudo netreaper-install essentials  # Core tools (~500MB, 5 min)
sudo netreaper-install all         # Full arsenal (~3-5GB, 15-30 min)
sudo netreaper-install wireless    # WiFi tools only
sudo netreaper-install scanning    # Recon tools only
sudo netreaper-install uninstall   # Remove tools
```

**Supported distros:**

| Family | Distributions | Manager |
|--------|---------------|---------|
| **Debian** | Kali, Parrot, Ubuntu, Debian, Mint, Pop!_OS | `apt` |
| **Red Hat** | Fedora, RHEL, Rocky, Alma, CentOS | `dnf`/`yum` |
| **Arch** | Arch, Manjaro, BlackArch, EndeavourOS | `pacman` |
| **SUSE** | openSUSE Tumbleweed/Leap, SLES | `zypper` |
| **Alpine** | Alpine Linux | `apk` |

---

## 🎯 Features

| Feature | Description |
|---------|-------------|
| **70+ tools unified** | Recon, wireless, exploit, credentials, stress testing, OSINT |
| **Multi-distro** | Auto-detects package manager, maps tool names per distro |
| **Interface validation** | Blocks WiFi operations on ethernet/loopback |
| **Monitor mode management** | Enable/disable with actual verification |
| **Target validation** | Warns on private IPs, confirms dangerous operations |
| **Session management** | Save and resume assessment states |
| **Centralized logging** | All output to `~/.netreaper/logs/` with timestamps |
| **Post-install guide** | Failed tools get a manual fix guide with distro-specific commands |
| **Arsenal status** | Startup scan shows installed/missing per category |

---

## 🔧 Arsenal

<details>
<summary><strong>Reconnaissance</strong></summary>

| Tool | Purpose |
|------|---------|
| nmap | Port scanning, service detection, NSE scripts |
| masscan | High-speed port scanning |
| rustscan | Fast port discovery → nmap integration |
| dnsenum | DNS enumeration, zone transfers |
| sslscan | SSL/TLS configuration analysis |
| enum4linux | SMB/NetBIOS enumeration |

</details>

<details>
<summary><strong>Wireless</strong></summary>

| Tool | Purpose |
|------|---------|
| aircrack-ng | WPA/WPA2 cracking |
| airodump-ng | Packet capture, network discovery |
| aireplay-ng | Deauth, injection attacks |
| bettercap | MITM, sniffing, spoofing |
| wifite | Automated wireless auditing |
| reaver | WPS exploitation |
| hcxdumptool | PMKID capture |
| hcxtools | Hash conversion for hashcat |

</details>

<details>
<summary><strong>Exploitation</strong></summary>

| Tool | Purpose |
|------|---------|
| metasploit | Exploitation framework |
| sqlmap | SQL injection automation |
| nikto | Web server vulnerability scanning |
| gobuster | Directory/DNS brute-forcing |
| nuclei | Template-based vulnerability scanning |
| searchsploit | Exploit-DB CLI search |
| wpscan | WordPress security scanning |

</details>

<details>
<summary><strong>Credentials</strong></summary>

| Tool | Purpose |
|------|---------|
| hashcat | GPU-accelerated hash cracking |
| john | CPU hash cracking |
| hydra | Online brute-force |
| medusa | Parallel login attacks |
| crackmapexec | SMB/WinRM credential attacks |
| impacket | Windows protocol tools |

</details>

<details>
<summary><strong>Traffic & Stress</strong></summary>

| Tool | Purpose |
|------|---------|
| tcpdump | Packet capture |
| wireshark | Traffic analysis |
| tshark | CLI packet analysis |
| hping3 | Packet crafting, flooding |
| iperf3 | Bandwidth testing |
| tc/netem | Network impairment simulation |

</details>

<details>
<summary><strong>OSINT</strong></summary>

| Tool | Purpose |
|------|---------|
| theharvester | Email, subdomain, host OSINT |
| recon-ng | Modular recon framework |
| shodan | Internet-wide scanning data |
| amass | Attack surface mapping |

</details>

---

## 💻 Usage

**Interactive:**
```bash
sudo netreaper
```

**Direct:**
```bash
sudo netreaper scan 192.168.1.0/24 --quick
sudo netreaper scan 10.0.0.1 --full --vuln
sudo netreaper wifi --monitor wlan0
sudo netreaper status
```

**Menu:**
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

## 📁 Structure

```
~/.netreaper/
├── config/      # User configuration
├── logs/        # Timestamped operation logs
├── output/      # Scan results, exports
├── sessions/    # Saved assessment states
└── loot/        # Captured data
```

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

## 🗺️ Roadmap

| Version | Status | Focus |
|---------|--------|-------|
| 5.0 | ✅ | UX overhaul, logging, wizards |
| 5.1 | ✅ | Bug fixes, input sanitization |
| 5.2 | ✅ | Multi-distro support |
| 5.3 | ✅ | Interface validation, installer improvements |
| 5.5 | 🔄 | Profiles, favorites, aliases |
| 6.0 | 📋 | Modular architecture, plugin system |

---

## ⚠️ Legal

**For authorized security testing only.**

- You must have **written authorization** to test target systems
- You accept **full legal responsibility** for your actions
- Unauthorized access violates laws including the CFAA

The developers provide no warranty and accept no liability for misuse.

---

## 📜 License

**Apache License 2.0** — see [LICENSE](LICENSE)

© 2025 **OFFTRACKMEDIA Studios**  
ABN: 84 290 819 896

---

<div align="center">

**[Report Issue](https://github.com/Nerds489/NETREAPER/issues)** · **[Request Feature](https://github.com/Nerds489/NETREAPER/issues)** · **[Discussions](https://github.com/Nerds489/NETREAPER/discussions)**

<br>

*Built for practitioners, not spectators.*

</div>
]]>
