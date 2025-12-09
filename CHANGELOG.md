# Changelog

All notable changes to NETREAPER will be documented in this file.

## [5.3.1] - PHANTOM PROTOCOL - 2025-12-09

### Fixed
- **Distro detection bug on Fedora/RHEL** caused by VERSION variable conflict with /etc/os-release
- Changed from sourcing /etc/os-release to parsing it with grep to avoid readonly variable collision
- Tools now correctly install on non-Debian systems (Fedora, CentOS, Rocky, Alma, etc.)

### Changed
- **netreaper** version bumped to 5.3.1
- **netreaper-install** version bumped to 2.3.1

## [5.3.0] - PHANTOM PROTOCOL - 2025-12-09

### Added
- **Wireless interface validation** - Complete validation before WiFi operations
- New functions: is_wireless_interface(), get_wireless_interfaces(), check_monitor_mode()
- Monitor mode management: enable_monitor_mode(), disable_monitor_mode(), validate_wireless_interface()
- MONITOR_IFACE global variable for tracking current monitor mode interface
- **Installer uninstall system** - Full removal capabilities for tools
- Uninstall functions: uninstall_tool(), uninstall_category(), uninstall_all(), uninstall_specific()
- [U] Uninstall menu option in installer
- **Wordlist management** - check_wordlists() and ensure_rockyou() functions
- Private IP detection: is_private_ip() for WHOIS safety
- stress_prescan() for target discovery before stress tests
- create_manual_fix_guide() for post-install troubleshooting
- verify_tool_installed() for accurate installation verification
- New tools in installer: hcxdumptool, hcxtools, iperf3, empire

### Changed
- **netreaper-install** version bumped to 2.3.0
- All WiFi functions now validate interfaces before operations
- cmd_monitor_mode() uses new enable/disable_monitor_mode() functions
- cmd_wifi_scan(), cmd_deauth(), cmd_wps_attack(), cmd_handshake_capture() use validate_wireless_interface()
- cmd_channel_hop(), cmd_client_scan(), cli_wifi() use wireless validation
- Wizard scan validates wireless interface before WiFi operations
- cmd_hping3() rewritten with rate limiting, interface selection, multiple attack types
- cmd_netem() rewritten with module loading, jitter support, connection testing
- run_whois() now warns on private IP addresses
- cmd_hydra_bruteforce() and cmd_medusa_bruteforce() use ensure_rockyou() for wordlists
- Installer CATEGORIES updated with stress and post categories

### Fixed
- Monitor mode operations now properly track interface state
- WiFi scans no longer fail silently on non-wireless interfaces
- WHOIS no longer attempts lookups on private/internal IPs
- Stress testing tools have proper error handling
- Credential attacks verify wordlist availability before starting

### Technical Details
- 6 new wireless validation functions
- 6 new installer uninstall functions
- 3 new wordlist/IP utility functions
- 4 new installer tools added
- Enhanced stress testing with proper rate limiting

## [5.2.0] - PHANTOM PROTOCOL - 2025-12-09

### Added
- **Multi-distro support** - Works on Debian, Red Hat, Arch, SUSE, Alpine, and more
- System detection functions: detect_distro(), detect_distro_family(), detect_package_manager()
- Universal package manager abstraction supporting 8 package managers (apt, dnf, yum, pacman, zypper, apk, emerge, xbps)
- Package name mapping system for cross-distro tool name translation
- 4-tier installation fallback: package manager → pip → go install → GitHub releases
- Distro-specific setup: Auto-install EPEL for RHEL-based systems
- Repository suggestions (BlackArch for Arch users)
- Comprehensive system information display with show_system_info()
- install_base_deps() for universal base dependency installation
- install_from_github() for binary releases with architecture detection
- Supported Distributions section in README.md

### Changed
- **netreaper-install** version bumped to 2.2.0
- Replaced all apt-specific install functions with universal ones
- Removed ~400 lines of deprecated apt-only code
- Updated README.md platform badge to MULTI-DISTRO
- Enhanced preflight_checks() to use new universal system
- Integrated init_system() into main startup flow
- Updated package manager commands to work across all distros

### Fixed
- Package name mapping for netcat (distro-specific variants)
- Duplicate check_tool_installed() function removed
- Installation now works on non-Debian systems
- Resolves Issue #2: "Only works on apt based systems"

### Technical Details
- 8 package managers supported: apt, dnf, yum, pacman, zypper, apk, emerge, xbps
- 15+ distro families detected automatically
- Architecture detection for x86_64, aarch64, armv7l
- System detection via /etc/os-release and fallback methods
- Global variables: DISTRO, DISTRO_FAMILY, PKG_MANAGER

## [5.1.0] - 2025-12-06

### Fixed
- Added all missing core functions (operation_header, operation_summary, start_timer_ms, end_timer_ms, log_command_preview, log_audit)
- Fixed critical input handling bug - prompts no longer captured in variable values
- Fixed color/ANSI codes appearing in filenames
- Fixed target validation for different tool types (MAC vs IP vs CIDR)
- Fixed netdiscover rejecting MAC addresses with proper error message
- Fixed hping3 input capture and validation
- Fixed impacket secretsdump input handling and output paths
- Added missing log_verbose() function
- Ensured all directories created on startup
- Fixed script structure order for proper function availability

### Added
- Safe input functions: get_target_input(), get_input(), get_password_input()
- Confirmation functions: confirm_action(), confirm_dangerous()
- Input sanitization: strip_ansi(), sanitize_filename(), sanitize_target()
- Target validation: is_valid_ip(), is_valid_cidr(), is_valid_mac(), is_valid_domain()
- Target type detection: get_target_type(), validate_target_for_tool()
- Audit logging with log_audit()
- Verbose logging with log_verbose()

### Changed
- Reorganized script structure for proper function loading order
- Improved error messages for invalid target types
- Enhanced logging to include file output

## [5.0.0] - Phantom Protocol - 2024-12-05

### Added
- Comprehensive logging system (DEBUG/INFO/WARN/ERROR/FATAL)
- Audit trail logging for compliance
- Progress spinners and bars
- Interactive confirmation prompts and dangerous-operation confirmation
- Smart sudo/privilege handling
- First-run setup wizard
- Scan wizard with guided workflow
- WiFi attack wizard
- Enhanced tool detection and auto-install scaffolding
- Configuration system with interactive editor
- QUICKREF.md quick reference card
- Session management, target history and favorites

### Changed
- UI/UX refresh across menus and status output
- Restructured CLI parser with wizard/config/log-level flags
- Help and documentation updates for v5

### Fixed
- Safer external target confirmation and history handling

## [4.3.0] - Phantom - 2024-12-05

### Added
- Apache 2.0 licensing and NOTICE file
- Governance docs: Code of Conduct, Contributing, Security, Support
- OFFTRACKMEDIA EULA and GitHub issue/PR templates

### Changed
- Consolidated branding solely under OFFTRACKMEDIA Studios
- Updated README legal section and badges to 4.3.0
- Author attribution in scripts now reflects OFFTRACKMEDIA Studios

### Fixed
- Removed remaining legacy references across docs and scripts

## [4.1.0] - Phantom - 2024-12-05

### Changed
- Complete README.md overhaul with funky styling
- Updated badges and visual elements
- Improved documentation structure
- Added roadmap section
- Enhanced screenshots section

### Fixed
- Version badge now correctly shows 4.1.0
- Links updated to correct repository

## [4.0.0] - Phantom - 2024-12-05

### Added
- **New menu structure** - 8 clean categories with submenus
- **Separate installer** - `netreaper-install` standalone tool
- **Auto sudo handling** - Prompts for elevation when needed
- **20 submenus** - Organized tool access by category
- New color scheme (blue/red team aesthetic)

### Changed
- Complete UI overhaul for cleaner navigation
- Menu collapsed from 30+ options to 8 categories
- Improved root privilege handling throughout

### Fixed
- Unbound variable bug (`$1` without defaults)
- Tools failing silently without root

## [3.4.0] - Ascension - 2024-12-04

### Added
- Auto-update checker
- Config file support
- Target history and favorites
- Output format exports (JSON, CSV, HTML, MD)
- Profiles/presets system
- Scheduled scans
- Scan diff/comparison
- Command aliases

## [3.3.4] - Retribution - 2024-12-04

### Added
- `--quiet` flag for scripting
- `--json` output mode
- Improved install.sh with `--dry-run`
- Streamlined bash completion

### Fixed
- Various shellcheck warnings
- Formatting issues

## [3.1.0] - Retribution - 2024-12-04

### Added
- WiFi cracking suite (aircrack-ng, hashcat GPU, john, cowpatty)
- Evil twin attacks (hostapd, captive portal, karma)
- Session management (start/resume/export)
- Credential attacks (hydra, medusa, crackmapexec)
- Post-exploitation tools (impacket, mimikatz)
- Expanded to 80+ integrated tools

## [3.0.0] - Vengeance - 2024-12-04

### Added
- Initial unified release
- Merged Python WiFi diagnostics with Bash security tools
- 60+ security capabilities
- Interactive menu and CLI interface
- Menacing hacker aesthetic
