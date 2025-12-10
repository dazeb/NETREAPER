# Changelog

All notable changes to NETREAPER.

## [6.2.4] - 2025-12-10

### Added
- Centralized logging system with log levels (DEBUG–FATAL) and file logging.
- Smart sudo and privilege helpers (is_root, require_root, run_with_sudo, elevate_if_needed).
- Audit trail logging for security-relevant operations.
- Log utilities: set_log_level(), show_logs(), rotate_logs().

### Changed
- bin/netreaper refactored into a thin dispatcher using modular libs and modules.
- All scripts now read version and NETREAPER_ROOT from lib/version.sh.

### Fixed
- Inconsistent privilege handling and unclear root requirements for WiFi/scan/etc.
- Lack of audit trail for security-relevant operations.
- ORIGINAL_ARGS unbound variable error with set -u.

## [6.2.2] - 2025-12-10

### Fixed
- Resolved E2BIG "argument list too long" error when invoking sudo with large argument expansion

## [6.2.1] - 2025-12-09

### Added
- Root-level wrapper binaries (`netreaper`, `netreaper-install`) that forward to the executables in `bin/`, preserving historical `./netreaper` workflows.
- Dedicated Bash, Zsh, and Fish completion scripts in `completions/` plus documentation explaining how to enable them.
- Smoke tests under `tests/smoke/` (`test_help.sh`, `test_version.sh`) that mirror the CI entrypoints.

### Changed
- Repository layout and quickstart docs now highlight the `bin/` directory, wrapper scripts, and the clean root-level structure.
- `install.sh` strictly delegates to `bin/netreaper-install`, and the README/HowTo/Quick Reference call out the wrapper usage.
- Non-interactive detection honors `NR_NON_INTERACTIVE=1` **and** TTY absence, skipping the wizard, legal prompts, and auto-marking `FIRST_RUN_COMPLETE`.

### Fixed
- CI runs without blocking prompts—no more wizard/legal interaction required for headless environments.
- Version reporting is consistent across the CLI, installer, and core libraries (single source of truth via `VERSION`).

### Removed
- Remaining EULA language; Apache 2.0 is now the only license mentioned anywhere.

## [6.2.0] - 2024-12-09

### Added
- `bin/` directory for executables (professional structure)
- `tests/smoke/` directory with smoke tests
- `docs/images/` directory for screenshots
- `--dry-run` flag for safe command preview
- `nr_run()` and `nr_run_eval()` wrapper functions in lib/core.sh
- "First 60 Seconds" quickstart section in README
- "Why NETREAPER?" comparison table in README
- "Dry-Run Mode" documentation in README
- "Project History" section in README
- CI badge in README
- Release workflow (.github/workflows/release.yml)

### Changed
- Moved `netreaper` → `bin/netreaper`
- Moved `netreaper-install` → `bin/netreaper-install`
- `install.sh` is now thin wrapper calling `bin/netreaper-install`
- CI workflow updated for `bin/` structure
- README completely overhauled with landing page style
- Installer version synced to main version (6.2.0)

### Fixed
- uninstall.sh now removes both netreaper and netreaper-install

### Structure
```
bin/
  netreaper           # Main toolkit
  netreaper-install   # Tool installer
lib/                  # Core libraries
modules/              # Feature modules
tests/
  smoke/              # Smoke tests
  *.bats              # Bats tests
docs/
  images/             # Screenshots
install.sh            # System installer (wrapper)
uninstall.sh          # Uninstaller
```

## [6.1.0] - 2024-12-09

### Changed
- **License Clarification**: NETREAPER is 100% Apache 2.0 with no additional restrictions
- Removed EULA directory and all associated acceptance language
- Version standardization: single source of truth from VERSION file
- Code cleanup: added shellcheck disable directives for intentionally exported variables

### Fixed
- ShellCheck warnings properly addressed (not hidden with severity config)
- SC2034: Added explicit directives for exported variables (colors, PKG_*, TOOLS_*)
- Syntax error in first_run_wizard() from empty if-then block
- Version inconsistencies across all script files

### Removed
- `EULA/` directory completely removed
- All EULA/terms acceptance language from scripts
- Unused `term_cmd` variable from netreaper-install

## [6.0.1] - 2024-12-09

### Fixed
- CI test fixes for detection.bats
- Prevented log_to_file from failing in CI environments

## [6.0.0] - 2024-12-09

### Added
- Modular architecture with `lib/` and `modules/` directories
- Authorization flow on first run
- Target validation (blocks dangerous operations by default)
- `NR_UNSAFE_MODE` environment variable for advanced users
- Bats test suite (47 tests)
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

[6.2.4]: https://github.com/Nerds489/NETREAPER/compare/v6.2.3...v6.2.4
[6.2.2]: https://github.com/Nerds489/NETREAPER/compare/v6.2.1...v6.2.2
[6.2.1]: https://github.com/Nerds489/NETREAPER/compare/v6.2.0...v6.2.1
[6.2.0]: https://github.com/Nerds489/NETREAPER/releases/tag/v6.2.0
[6.1.0]: https://github.com/Nerds489/NETREAPER/releases/tag/v6.1.0
[6.0.1]: https://github.com/Nerds489/NETREAPER/releases/tag/v6.0.1
[6.0.0]: https://github.com/Nerds489/NETREAPER/releases/tag/v6.0.0
[5.3.1]: https://github.com/Nerds489/NETREAPER/releases/tag/v5.3.1
[5.3.0]: https://github.com/Nerds489/NETREAPER/releases/tag/v5.3.0
