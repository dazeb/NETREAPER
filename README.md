<p align="center">
╔══════════════════════════════════════════════════════════════════════════════════════╗
║ ███╗   ██╗███████╗████████╗██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗           ║
║ ████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗          ║
║ ██╔██╗ ██║█████╗     ██║   ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝          ║
║ ██║╚██╗██║██╔══╝     ██║   ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗          ║
║ ██║ ╚████║███████╗   ██║   ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║          ║
║ ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝          ║
╚══════════════════════════════════════════════════════════════════════════════════════╝
</p>

<h1 align="center">NETREAPER</h1>
<p align="center"><strong>Offensive Security Framework</strong></p>
<p align="center">v6.2.5 — Phase 2: Safety & Confirmations</p>

<p align="center">
  <img src="https://img.shields.io/badge/version-6.2.5-red?style=flat-square" alt="Version">
  <img src="https://img.shields.io/badge/license-Apache%202.0-blue?style=flat-square" alt="License">
  <img src="https://img.shields.io/badge/platform-Linux-lightgrey?style=flat-square" alt="Platform">
  <img src="https://img.shields.io/badge/shell-Bash%205.0+-green?style=flat-square" alt="Shell">
</p>

---

> **"Some tools scan. Some tools attack. I do both."**

NETREAPER is a modular Bash-based offensive security toolkit that unifies 70+ security tools behind a single CLI. Built for penetration testers, red teamers, and security researchers who need a fast, scriptable interface with proper safety guardrails.

---

## Quick Start

```bash
# Clone the repository
git clone https://github.com/OFFTRACKMEDIA/NETREAPER.git
cd NETREAPER

# Install (requires root for system-wide installation)
sudo ./install.sh
```

The `install.sh` wrapper delegates to `bin/netreaper-install`, which handles tool installation, system-wide symlinks, and dependency management.

**Running locally (without install):**

```bash
# Root wrappers in project root delegate to bin/
./netreaper --help
./netreaper-install --help
```

---

## Core Features

- **70+ Tools Behind One CLI** — Nmap, Aircrack-ng, Metasploit, Hydra, and more, all accessible via unified commands
- **Dry-Run Mode** — Preview commands without execution (`--dry-run`)
- **Modular Architecture** — Separate bin, lib, and modules directories for clean organization
- **Structured Logging & Audit Trail** — Daily log rotation with separate audit logs for compliance
- **Safety & Authorization Model** — Target validation, protected IP ranges, and authorization prompts
- **Non-Interactive / CI-Safe** — Explicit opt-in flags for automated pipelines

---

## Architecture Overview

```
NETREAPER/
├── netreaper              # Root wrapper → bin/netreaper
├── netreaper-install      # Root wrapper → bin/netreaper-install
├── install.sh             # Installer wrapper → bin/netreaper-install
├── VERSION                # Single source of truth for version
├── bin/
│   ├── netreaper          # Main CLI dispatcher
│   └── netreaper-install  # Tool installer
├── lib/
│   ├── version.sh         # NETREAPER_ROOT + VERSION resolution
│   ├── core.sh            # Logging, paths, directories, error handling, sudo helpers
│   ├── ui.sh              # Banners, menus, prompts, confirmations
│   ├── safety.sh          # Target validation, authorization, unsafe mode
│   ├── detection.sh       # Distro, package manager, tool, interface detection
│   └── utils.sh           # Timestamps, backups, safe file operations, tool execution
├── modules/
│   ├── recon.sh           # Reconnaissance tools
│   ├── scanning.sh        # Port scanning, service enumeration
│   ├── wireless.sh        # WiFi attacks, monitor mode, handshake capture
│   ├── exploit.sh         # Exploitation frameworks
│   ├── credentials.sh     # Password attacks, hash cracking
│   ├── traffic.sh         # Traffic analysis, MITM
│   ├── osint.sh           # Open source intelligence
│   └── stress.sh          # Stress testing, DoS simulation
├── docs/                  # Documentation (HOWTO, QUICKREF, etc.)
└── tests/                 # Test suites (bats, smoke tests)
```

### Library Descriptions

| File | Purpose |
|------|---------|
| `version.sh` | Resolves `NETREAPER_ROOT` and reads `VERSION` file; prevents version drift |
| `core.sh` | Logging system, color definitions, directory setup, exit codes, privilege handling, dry-run wrappers, error framework (`die`, `try`, `require_tool`) |
| `ui.sh` | Banner display, input sanitization, prompts (`confirm`, `confirm_dangerous`, `select_option`), progress indicators |
| `safety.sh` | IP validation, CIDR matching, protected ranges, `validate_target()`, authorization checks, unsafe mode |
| `detection.sh` | Distro detection, package manager setup, tool checks, wireless interface detection |
| `utils.sh` | Timestamps, file backups, cleanup handlers, safe file operations (`safe_rm`, `safe_copy`, `safe_move`), tool execution wrappers |

---

## Logging System

NETREAPER provides structured logging with six severity levels:

| Level | Function | Symbol | Use Case |
|-------|----------|--------|----------|
| DEBUG | `log_debug()` | `~` | Detailed diagnostic information |
| INFO | `log_info()` | `*` | General operational messages |
| SUCCESS | `log_success()` | `✓` | Successful operations |
| WARNING | `log_warning()` | `!` | Potential issues, cautions |
| ERROR | `log_error()` | `✗` | Errors that don't halt execution |
| FATAL | `log_fatal()` | `☠` | Critical errors that exit immediately |

### Log File Locations

```
~/.netreaper/logs/netreaper_YYYYMMDD.log   # Operation logs (daily rotation)
~/.netreaper/logs/audit_YYYYMMDD.log       # Audit trail (actions, targets, results)
```

### Logging Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `NETREAPER_LOG_LEVEL` | `1` (INFO) | Minimum level to log (0=DEBUG, 1=INFO, 2=SUCCESS, 3=WARNING, 4=ERROR, 5=FATAL) |
| `NETREAPER_FILE_LOGGING` | `1` | Enable file logging (`0` to disable) |

### Audit Logging

All significant actions are recorded via `log_audit()`:

```
[2025-01-15 14:30:22] USER=root ACTION=SCAN TARGET="192.168.1.1" RESULT="success" PID=12345
```

---

## Privilege & Sudo Handling

NETREAPER provides several functions for managing root privileges:

| Function | Description |
|----------|-------------|
| `is_root()` | Returns 0 if running as root (EUID=0) |
| `require_root()` | Logs error and returns 1 if not root; provides hint to re-run with sudo |
| `run_with_sudo()` | Executes command with `sudo` if not already root |
| `elevate_if_needed()` | Prompts user to elevate privileges; re-execs script as root if approved |
| `can_get_root()` | Checks if root access is possible (already root, passwordless sudo, or TTY available) |

**Operations requiring root** (defined in `ROOT_OPS` array):
- `wifi`, `scan`, `stress`, `exploit`, `traffic`, `sniff`, `mitm`, `capture`, `inject`

**Non-interactive behavior:**
- `elevate_if_needed()` returns error if `NR_NON_INTERACTIVE=1` or no TTY
- Use `sudo` explicitly in CI pipelines

---

## Safety & Target Validation

### validate_target()

The `validate_target()` function is the primary safety gate for all operations:

1. **Accepts:** IP address, CIDR notation, or hostname
2. **Resolves hostnames** to IP addresses (via `dig`, `host`, or `getent`)
3. **Checks protected ranges** — Blocks loopback, link-local, multicast, broadcast, reserved
4. **Detects private vs public IPs** — Warns and requires confirmation for public targets

### Protected Ranges

The `DEFAULT_PROTECTED_RANGES` array blocks these CIDR ranges:

| Range | Description |
|-------|-------------|
| `127.0.0.0/8` | Loopback |
| `169.254.0.0/16` | Link-local |
| `224.0.0.0/4` | Multicast |
| `240.0.0.0/4` | Reserved |
| `255.255.255.255/32` | Broadcast |
| `0.0.0.0/8` | Current network |

### Validation Functions

| Function | Description |
|----------|-------------|
| `is_valid_ip()` | Validates IPv4 address format (each octet 0-255) |
| `is_valid_cidr()` | Validates CIDR notation (IP + prefix 0-32) |
| `is_private_ip()` | Checks if IP is RFC1918 private (10.x, 172.16-31.x, 192.168.x) |
| `is_protected_ip()` | Checks if IP falls within any `DEFAULT_PROTECTED_RANGES` |
| `is_dangerous_range()` | Blocks broad ranges like `0.0.0.0/0` or `/0` prefixes |

### Public IP Behavior

- **Normal mode:** Warns user and requires `confirm_dangerous()` confirmation
- **Unsafe mode:** Allows with logging; no confirmation required

---

## Dangerous Operations & Confirmations

### Confirmation Functions

| Function | Description |
|----------|-------------|
| `confirm()` | Simple yes/no confirmation with default; returns 0 (yes) or 1 (no) |
| `confirm_dangerous()` | Requires typing exact phrase (e.g., "YES") to proceed; displays warning banner |
| `prompt_input()` | Collects input with optional validator and secret mode (hidden input) |
| `select_option()` | Displays numbered menu; returns selected option |

### Interactive Mode Behavior

```bash
# confirm() example
confirm "Continue with scan?" "n"  # Default: no

# confirm_dangerous() example — requires typing exact phrase
confirm_dangerous "Delete all logs?" "DELETE"
```

### Non-Interactive Mode Behavior

| Function | Default Behavior | Override |
|----------|------------------|----------|
| `confirm()` | Uses default value | N/A |
| `confirm_dangerous()` | **Blocked** (returns 1) | `NR_UNSAFE_MODE=1` or `NR_FORCE_DANGEROUS=1` |
| `select_option()` | **Fails** (returns 1) | Set `NR_NON_INTERACTIVE_DEFAULT_INDEX=N` |
| `prompt_input()` | Returns default value | N/A |

---

## Non-Interactive & CI Mode

NETREAPER detects non-interactive mode when:
- `NR_NON_INTERACTIVE=1` is set, OR
- No TTY is attached (`[[ ! -t 0 ]]`)

### Behavior Matrix

| Function | Interactive | Non-Interactive (default) | Non-Interactive + Unsafe Mode |
|----------|-------------|---------------------------|-------------------------------|
| `check_authorization()` | Prompts for "I AM AUTHORIZED" | **Blocked** | Allowed with `NR_AUTO_AUTHORIZE_NON_INTERACTIVE=1` |
| `confirm_dangerous()` | Prompts for exact phrase | **Blocked** | Auto-accepts |
| `select_option()` | Shows menu, waits for input | **Fails** | Uses `NR_NON_INTERACTIVE_DEFAULT_INDEX` |
| `confirm()` | Prompts y/n | Uses default | Uses default |
| `elevate_if_needed()` | Prompts for elevation | **Fails** | **Fails** (use explicit sudo) |

### Enabling Dangerous Operations in CI

```bash
# Full unsafe mode — bypasses all safety checks
export NR_UNSAFE_MODE=1
export NR_NON_INTERACTIVE=1
export NR_AUTO_AUTHORIZE_NON_INTERACTIVE=1
netreaper scan 192.168.1.1

# Allow only dangerous confirmations (without full unsafe mode)
export NR_NON_INTERACTIVE=1
export NR_FORCE_DANGEROUS=1
netreaper scan 192.168.1.1

# Menu selection in non-interactive mode
export NR_NON_INTERACTIVE=1
export NR_NON_INTERACTIVE_DEFAULT_INDEX=0  # Select first option (0-based)
netreaper wizard scan
```

---

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `NETREAPER_LOG_LEVEL` | `1` | Log level: 0=DEBUG, 1=INFO, 2=SUCCESS, 3=WARNING, 4=ERROR, 5=FATAL |
| `NETREAPER_FILE_LOGGING` | `1` | Enable file logging (`0` to disable) |
| `NR_NON_INTERACTIVE` | `0` | Force non-interactive mode (`1` to enable) |
| `NR_UNSAFE_MODE` | `0` | Bypass safety checks; accepts `1`, `true`, `yes`, `y` |
| `NR_FORCE_DANGEROUS` | `0` | Allow `confirm_dangerous()` in non-interactive mode without full unsafe mode |
| `NR_AUTO_AUTHORIZE_NON_INTERACTIVE` | `0` | Auto-authorize in non-interactive mode (requires `NR_UNSAFE_MODE=1`) |
| `NR_NON_INTERACTIVE_DEFAULT_INDEX` | (unset) | 0-based index for `select_option()` in non-interactive mode |
| `NR_DRY_RUN` | `0` | Print commands instead of executing (`1` to enable) |
| `NO_COLOR` | `0` | Disable colored output (`1` to enable) |
| `DEBUG` | `false` | Enable debug output (`true` to enable) |
| `VERBOSE` | `false` | Enable verbose output (`true` to enable) |
| `QUIET` | `false` | Suppress non-error console output (`true` to enable) |

---

## CLI Usage Examples

```bash
# Show help
netreaper --help
netreaper help

# Show version (reads from VERSION file)
netreaper --version

# Check tool status
netreaper status
netreaper status --compact

# Dry-run mode — preview commands without execution
netreaper --dry-run scan 192.168.1.1

# Quick scan
netreaper scan 192.168.1.1

# Full scan (requires root)
sudo netreaper scan 192.168.1.1 --full

# WiFi menu (requires root)
sudo netreaper wifi

# Interactive wizard
netreaper wizard scan

# Configuration
netreaper config path
netreaper config edit

# Non-interactive CI example
NR_NON_INTERACTIVE=1 netreaper status

# Unsafe mode for automated testing
NR_NON_INTERACTIVE=1 NR_UNSAFE_MODE=1 NR_AUTO_AUTHORIZE_NON_INTERACTIVE=1 \
  sudo netreaper scan 192.168.1.0/24

# Force dangerous confirmation in CI (without full unsafe mode)
NR_NON_INTERACTIVE=1 NR_FORCE_DANGEROUS=1 \
  sudo netreaper stress 192.168.1.1

# Menu selection in CI
NR_NON_INTERACTIVE=1 NR_NON_INTERACTIVE_DEFAULT_INDEX=0 \
  netreaper wizard scan
```

---

## Testing & QA

### Running Tests

```bash
# BATS tests (requires bats-core)
NR_NON_INTERACTIVE=1 bats tests/*.bats

# Smoke tests
./tests/smoke/test_help.sh
./tests/smoke/test_version.sh
```

### Test Coverage

| Test File | Coverage |
|-----------|----------|
| `tests/cli.bats` | CLI flags, commands, exit codes |
| `tests/help.bats` | Help output validation |
| `tests/syntax.bats` | Shell syntax checking |
| `tests/detection.bats` | System/distro detection |
| `tests/smoke/*.sh` | Quick smoke tests for CI |

---

## Legal & License

```
Copyright (c) 2025 OFFTRACKMEDIA Studios (ABN: 84 290 819 896)
SPDX-License-Identifier: Apache-2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

### Authorized Testing Only

**NETREAPER is designed for authorized security testing only.**

By using this software, you acknowledge that:

- You have **written authorization** to test target systems
- You accept **full legal responsibility** for your actions
- Unauthorized access to computer systems is a **federal crime**

The authors and contributors are not responsible for misuse of this software.

---

## Project History

NETREAPER began as a personal toolkit for streamlining penetration testing workflows. What started as a collection of wrapper scripts evolved into a full-featured framework with:

- **Phase 1:** Core refactoring — Modular lib/bin/modules architecture, centralized version handling
- **Phase 2:** Safety & confirmations — Target validation, authorization model, non-interactive CI support

The project follows a "batteries included" philosophy: one CLI to rule all your security tools, with safety guardrails that don't get in your way.

---

## Support

- **Issues:** [GitHub Issues](https://github.com/OFFTRACKMEDIA/NETREAPER/issues)
- **Discussions:** [GitHub Discussions](https://github.com/OFFTRACKMEDIA/NETREAPER/discussions)
- **Documentation:** See `docs/` directory for HOWTO, QUICKREF, and TROUBLESHOOTING guides

---

<p align="center">
  <strong>NETREAPER</strong> — "Some tools scan. Some tools attack. I do both."
</p>
<p align="center">
  © 2025 OFFTRACKMEDIA Studios
</p>
