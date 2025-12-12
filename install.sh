#!/usr/bin/env bash
# NETREAPER Installer Wrapper
# Calls bin/netreaper-install with all arguments

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#═══════════════════════════════════════════════════════════════════════════════
# LEGACY CLEANUP (MANDATORY - HARD FAIL IF REMOVAL FAILS)
#═══════════════════════════════════════════════════════════════════════════════
# Hard-delete legacy monolithic netreaper (v5.x) - it is broken and unsupported
# Bug: "sudo: Argument list too long" - causes complete failure
# The legacy monolith MUST be removed before installation can proceed.
_legacy_found=0
_legacy_removal_failed=0
for legacy_bin in /usr/local/bin/netreaper /usr/local/bin/netreaper-install; do
    if [[ -f "$legacy_bin" ]]; then
        if [[ $_legacy_found -eq 0 ]]; then
            echo "[!] Legacy install detected - removing broken v5.x monolith" >&2
            _legacy_found=1
        fi
        if ! rm -f "$legacy_bin" 2>/dev/null; then
            echo "[FATAL] Could not remove legacy file: $legacy_bin" >&2
            echo "        Permission denied or file is read-only." >&2
            echo "        Run this installer with sudo, or manually remove:" >&2
            echo "          sudo rm -f $legacy_bin" >&2
            _legacy_removal_failed=1
        else
            echo "[*] Removed legacy: $legacy_bin" >&2
        fi
    fi
done

# Hard-fail if any legacy removal failed
if [[ $_legacy_removal_failed -eq 1 ]]; then
    echo "" >&2
    echo "[FATAL] Legacy cleanup failed. Cannot proceed with installation." >&2
    echo "        The v5.x monolithic install is broken and must be removed." >&2
    exit 1
fi

[[ $_legacy_found -eq 1 ]] && echo "[*] Modular version (v6.x) will be installed" >&2 || true

#═══════════════════════════════════════════════════════════════════════════════
# INSTALLER
#═══════════════════════════════════════════════════════════════════════════════
if [[ ! -x "$SCRIPT_DIR/bin/netreaper-install" ]]; then
    echo "ERROR: bin/netreaper-install not found or not executable"
    exit 1
fi

# Run the actual installer
"$SCRIPT_DIR/bin/netreaper-install" "$@"
_install_exit=$?

if [[ $_install_exit -ne 0 ]]; then
    echo "[FATAL] Installation failed with exit code $_install_exit" >&2
    exit $_install_exit
fi

#═══════════════════════════════════════════════════════════════════════════════
# POST-INSTALL VERIFICATION
#═══════════════════════════════════════════════════════════════════════════════
# Verify the installed netreaper is the modular wrapper, not a legacy monolith.
# The modular wrapper sources from lib/ and is small; the monolith is 200KB+.

_verify_modular_install() {
    local installed_bin="/usr/local/bin/netreaper"

    # Check if the binary exists
    if [[ ! -f "$installed_bin" ]]; then
        echo "[WARN] Post-install verification skipped: $installed_bin not found" >&2
        echo "       (This is OK if you used a custom PREFIX)" >&2
        return 0
    fi

    # Check file size - modular wrapper should be small (<50KB)
    # Legacy monolith is 200KB+ (6000+ lines embedded)
    local file_size
    file_size=$(stat -c%s "$installed_bin" 2>/dev/null || stat -f%z "$installed_bin" 2>/dev/null || echo "0")

    if [[ "$file_size" -gt 100000 ]]; then
        echo "" >&2
        echo "[FATAL] Post-install verification FAILED!" >&2
        echo "        $installed_bin appears to be a legacy monolith (size: ${file_size} bytes)" >&2
        echo "        The modular wrapper should be <50KB." >&2
        echo "        This indicates the installation did not complete correctly." >&2
        echo "" >&2
        echo "        To fix: run ./reinstall-netreaper.sh or manually remove and reinstall" >&2
        return 1
    fi

    # Check for modular indicators (sources lib/)
    if ! grep -q 'NETREAPER_ROOT' "$installed_bin" 2>/dev/null; then
        echo "" >&2
        echo "[FATAL] Post-install verification FAILED!" >&2
        echo "        $installed_bin does not appear to be the modular wrapper." >&2
        echo "        Missing NETREAPER_ROOT variable - likely a legacy monolith." >&2
        echo "" >&2
        echo "        To fix: run ./reinstall-netreaper.sh or manually remove and reinstall" >&2
        return 1
    fi

    echo "[*] Post-install verification: OK (modular wrapper installed)" >&2
    return 0
}

if ! _verify_modular_install; then
    exit 1
fi

exit 0
