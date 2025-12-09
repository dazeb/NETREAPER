☠️ NETREAPER
Offensive security toolkit. Because 47 terminal windows is stupid.
 ███╗   ██╗███████╗████████╗██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗ 
 ████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
 ██╔██╗ ██║█████╗     ██║   ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝
 ██║╚██╗██║██╔══╝     ██║   ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
 ██║ ╚████║███████╗   ██║   ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║
 ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
v5.3.2 — Phantom Protocol
Show Image
Show Image
Show Image
Show Image
Show Image
70+ security tools. One CLI. Stop juggling terminals.

The Story
I got tired of running the same 15 commands across 8 terminals every time I tested a device. So I made a wrapper. Then the wrapper needed more tools. Then it needed menus. Then logging. Then multi-distro support.
Now it's this.

Make the work faster. Make the work cleaner. Make the work repeatable.


Why NETREAPER?
ProblemSolutionManaging dozens of terminal windowsSingle unified interfaceRemembering syntax for 70+ toolsGuided menusScattered logs and output filesCentralized at ~/.netreaper/Different commands per distroAuto-detects package managerTime lost context-switchingCategory-based navigation

Install
bashgit clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo bash ./netreaper-install
Options:
bashsudo netreaper-install essentials  # Just the basics (~500MB)
sudo netreaper-install all         # Everything (~3-5GB)
sudo netreaper-install wireless    # WiFi stuff
sudo netreaper-install uninstall   # Remove it
Works on: Kali, Parrot, Ubuntu, Debian, Fedora, RHEL, Arch, Manjaro, openSUSE, Alpine

What's In It
Recon — nmap · masscan · rustscan · netdiscover · dnsenum · sslscan · enum4linux
Wireless — aircrack-ng · airodump-ng · aireplay-ng · wifite · bettercap · reaver · hcxdumptool
Exploit — metasploit · sqlmap · nikto · gobuster · wpscan · searchsploit · nuclei
Creds — hashcat · john · hydra · medusa · crackmapexec · impacket
Traffic — tcpdump · wireshark · tshark · hping3 · iperf3
OSINT — theharvester · recon-ng · shodan · amass
Plus more. Check netreaper status for the full list.

Usage
bashsudo netreaper                      # Menu
sudo netreaper scan 192.168.1.0/24  # Scan
sudo netreaper wifi --monitor wlan0 # WiFi mode
sudo netreaper status               # What's installed
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

What It Actually Does

Wraps tools — You still need to know what you're doing
Organizes output — Everything goes to ~/.netreaper/
Validates interfaces — Won't run WiFi attacks on ethernet
Logs everything — Timestamped, for when you need to prove what happened
Works across distros — Detects your package manager, installs the right stuff


What It Doesn't Do

Replace knowing the underlying tools
Make you a hacker
Give you permission to test things you don't own


File Structure
~/.netreaper/
├── config/      # Settings
├── logs/        # Operation logs
├── output/      # Scan results
├── sessions/    # Saved states
└── captures/    # Captured data

Authorization
Before you run anything:

 Written permission from the owner
 Scope defined and documented
 Legal compliance confirmed
 Audit logging enabled

Unauthorized access is a crime. You're responsible for your actions.

Docs
DocumentWhat It IsQUICKREF.mdCommandsTOOL_REFERENCE.mdTool detailsTROUBLESHOOTING.mdFixesHOWTO.mdGuidesCONTRIBUTING.mdHow to helpCHANGELOG.mdWhat changed

Roadmap
VersionStatusWhat5.3✅Interface validation, installer fixes5.5🔄Profiles, favorites6.0📋Modular architecture, plugins

License
Apache 2.0 — © 2025 OFFTRACKMEDIA Studios (ABN: 84 290 819 896)

Report Bug · Request Feature · Discussions
