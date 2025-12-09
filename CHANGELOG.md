# Changelog

All notable changes to NETREAPER.

## [6.0.0] - 2024-12-09

### Added
- Modular architecture with `lib/` and `modules/` directories
- Authorization flow on first run
- Target validation (blocks dangerous operations by default)
- `NR_UNSAFE_MODE` environment variable for advanced users
- Bats test suite (49 tests)
- GitHub Actions CI with ShellCheck
- `--dry-run` flag for installer

### Changed
- Main script refactored to thin dispatcher
- Installer refactored with clear functions
- Installer version bumped to 3.0.0

### Structure
```
lib/core.sh        - Logging, colors, paths
lib/ui.sh          - Menus, prompts, banners
lib/safety.sh      - Authorization, validation
lib/detection.sh   - Distro/tool detection
lib/utils.sh       - Helper functions

modules/recon.sh       - Network reconnaissance
modules/wireless.sh    - WiFi operations
modules/scanning.sh    - Port scanning
modules/exploit.sh     - Exploitation
modules/credentials.sh - Password cracking
modules/traffic.sh     - Packet analysis
modules/osint.sh       - OSINT gathering
```

## [5.3.1] - 2024-12-08

### Fixed
- Interface validation improvements
- Installer compatibility fixes

## [5.3.0] - 2024-12-07

### Added
- Multi-distro support (Fedora, RHEL, Arch, openSUSE, Alpine)
- Improved wizard mode
- JSON output for status

---

[6.0.0]: https://github.com/Nerds489/NETREAPER/releases/tag/v6.0.0
[5.3.1]: https://github.com/Nerds489/NETREAPER/releases/tag/v5.3.1
[5.3.0]: https://github.com/Nerds489/NETREAPER/releases/tag/v5.3.0
