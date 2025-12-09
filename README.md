# ☠️ NETREAPER. Offensive security toolkit. Because 47 terminal windows is stupid.



```
 ███╗   ██╗███████╗████████╗██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗ 
 ████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
 ██╔██╗ ██║█████╗     ██║   ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝
 ██║╚██╗██║██╔══╝     ██║   ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
 ██║ ╚████║███████╗   ██║   ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║
 ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
```

**v5.3.2 — Phantom Protocol**

![Version](https://img.shields.io/badge/v5.3.2-ff0040?style=flat-square)
![License](https://img.shields.io/badge/Apache_2.0-00d4ff?style=flat-square)
![Platform](https://img.shields.io/badge/Linux-ffaa00?style=flat-square)
![Tools](https://img.shields.io/badge/70+_tools-8B5CF6?style=flat-square)

---

70+ security tools. One CLI. Stop juggling terminals.

---

## The Story

I got tired of running the same 15 commands across 8 terminals every time I tested a device. So I made a wrapper. Then the wrapper needed more tools. Then it needed menus. Then logging. Then multi-distro support.

Now it's this.

> Make the work faster. Make the work cleaner. Make the work repeatable.

---

## Install

```bash
git clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo bash ./netreaper-install
```

**Options:**

```bash
sudo netreaper-install essentials  # Just the basics (~500MB)
sudo netreaper-install all         # Everything (~3-5GB)
sudo netreaper-install wireless    # WiFi stuff
sudo netreaper-install uninstall   # Remove it
```

**Works on:** Kali, Parrot, Ubuntu, Debian, Fedora, RHEL, Arch, Manjaro, openSUSE, Alpine

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

Plus 40 more. Check `netreaper status` for the full list.

---

## Usage

```bash
sudo netreaper                      # Menu
sudo netreaper scan 192.168.1.0/24  # Scan
sudo netreaper wifi --monitor wlan0 # WiFi mode
sudo netreaper status               # What's installed
```

---

## What It Actually Does

- **Wraps tools** — You still need to know what you're doing
- **Organizes output** — Everything goes to `~/.netreaper/`
- **Validates interfaces** — Won't run WiFi attacks on ethernet
- **Logs everything** — Timestamped, for when you need to prove what happened
- **Works across distros** — Detects your package manager, installs the right stuff

---

## What It Doesn't Do

- Replace knowing the underlying tools
- Make you a hacker
- Give you permission to test things you don't own

---

## Legal

**Authorized testing only.**

You need written permission. You're responsible for your actions. Unauthorized access is a crime.

---

## Docs

- [QUICKREF.md](QUICKREF.md) — Commands
- [TOOL_REFERENCE.md](TOOL_REFERENCE.md) — Tool details
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) — Fixes
- [CONTRIBUTING.md](CONTRIBUTING.md) — Help out

---

## Roadmap

- [x] 5.3 — Interface validation, installer fixes
- [ ] 5.5 — Profiles, favorites
- [ ] 6.0 — Modular architecture, plugins

---

## License

Apache 2.0 — © 2025 OFFTRACKMEDIA Studios

---

**[Issues](https://github.com/Nerds489/NETREAPER/issues)** · **[Discussions](https://github.com/Nerds489/NETREAPER/discussions)**
