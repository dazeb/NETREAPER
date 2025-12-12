#!/usr/bin/env bash
# NETREAPER Installer Wrapper
# Installs netreaper command system-wide, then optionally runs tool installer

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#═══════════════════════════════════════════════════════════════════════════════
# HELPER FUNCTIONS
#═══════════════════════════════════════════════════════════════════════════════

# Check if a directory is in PATH
_dir_in_path() {
    local dir="$1"
    [[ ":$PATH:" == *":$dir:"* ]]
}

# Determine the best install directory that's on PATH
# Returns: the chosen install dir via stdout
_select_install_dir() {
    # Preference order: /usr/local/bin (standard), /usr/bin (fallback)
    if _dir_in_path "/usr/local/bin"; then
        echo "/usr/local/bin"
        return 0
    fi
    if _dir_in_path "/usr/bin"; then
        echo "/usr/bin"
        return 0
    fi
    # Neither is on PATH - we'll use /usr/local/bin and fix PATH
    echo "/usr/local/bin"
    return 1
}

# Create profile.d drop-in to add /usr/local/bin to PATH
_create_path_dropin() {
    local dropin="/etc/profile.d/netreaper.sh"
    echo "[*] Creating PATH drop-in: $dropin" >&2
    cat > "$dropin" << 'DROPIN'
# Added by NETREAPER installer to ensure /usr/local/bin is in PATH
if [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
    export PATH="/usr/local/bin:$PATH"
fi
DROPIN
    chmod 644 "$dropin"
    echo "[*] Drop-in created. /usr/local/bin will be added to PATH on next login." >&2
    # Source it now for current shell
    export PATH="/usr/local/bin:$PATH"
}

#═══════════════════════════════════════════════════════════════════════════════
# LEGACY CLEANUP (MANDATORY - HARD FAIL IF REMOVAL FAILS)
#═══════════════════════════════════════════════════════════════════════════════
# Hard-delete legacy monolithic netreaper (v5.x) - it is broken and unsupported
# Bug: "sudo: Argument list too long" - causes complete failure
# The legacy monolith MUST be removed before installation can proceed.
_legacy_found=0
_legacy_removal_failed=0
for legacy_bin in /usr/local/bin/netreaper /usr/local/bin/netreaper-install /usr/bin/netreaper /usr/bin/netreaper-install; do
    if [[ -f "$legacy_bin" ]]; then
        # Check if it's a legacy monolith (>100KB) or existing modular install
        _file_size=0
        _file_size=$(stat -c%s "$legacy_bin" 2>/dev/null || stat -f%z "$legacy_bin" 2>/dev/null || echo "0")
        if [[ "$_file_size" -gt 100000 ]]; then
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
                echo "[*] Removed legacy monolith: $legacy_bin" >&2
            fi
        else
            # Small file - remove it to reinstall fresh
            rm -f "$legacy_bin" 2>/dev/null || true
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
# INSTALL NETREAPER COMMAND (CALLABLE COMMAND GUARANTEE)
#═══════════════════════════════════════════════════════════════════════════════

echo "[*] Installing netreaper command..." >&2

# Determine install directory
INSTALL_DIR=""
_path_needs_fix=0
if INSTALL_DIR=$(_select_install_dir); then
    : # Directory is on PATH
else
    _path_needs_fix=1
fi

# Ensure install directory exists
mkdir -p "$INSTALL_DIR" 2>/dev/null || true

# Install netreaper wrapper
if [[ -f "$SCRIPT_DIR/bin/netreaper" ]]; then
    # Create a wrapper that points to our repo location
    cat > "$INSTALL_DIR/netreaper" << WRAPPER
#!/usr/bin/env bash
# NETREAPER modular wrapper - installed by install.sh
# Points to: $SCRIPT_DIR
exec "$SCRIPT_DIR/bin/netreaper" "\$@"
WRAPPER
    chmod 755 "$INSTALL_DIR/netreaper"
    echo "[*] Installed: $INSTALL_DIR/netreaper" >&2
else
    echo "[FATAL] bin/netreaper not found in $SCRIPT_DIR" >&2
    exit 1
fi

# Install netreaper-install wrapper
if [[ -f "$SCRIPT_DIR/bin/netreaper-install" ]]; then
    cat > "$INSTALL_DIR/netreaper-install" << WRAPPER
#!/usr/bin/env bash
# NETREAPER installer wrapper - installed by install.sh
# Points to: $SCRIPT_DIR
exec "$SCRIPT_DIR/bin/netreaper-install" "\$@"
WRAPPER
    chmod 755 "$INSTALL_DIR/netreaper-install"
    echo "[*] Installed: $INSTALL_DIR/netreaper-install" >&2
fi

# Fix PATH if needed
if [[ $_path_needs_fix -eq 1 ]]; then
    _create_path_dropin
fi

#═══════════════════════════════════════════════════════════════════════════════
# VERIFY CALLABLE COMMAND
#═══════════════════════════════════════════════════════════════════════════════

echo "[*] Verifying installation..." >&2

# Refresh PATH to include our changes
export PATH="$INSTALL_DIR:$PATH"

if ! command -v netreaper &>/dev/null; then
    echo "" >&2
    echo "[FATAL] Installation verification FAILED!" >&2
    echo "        'netreaper' command is not callable." >&2
    echo "" >&2
    echo "        Install location: $INSTALL_DIR/netreaper" >&2
    echo "        Current PATH: $PATH" >&2
    echo "" >&2
    if [[ $_path_needs_fix -eq 1 ]]; then
        echo "        A PATH drop-in was created at /etc/profile.d/netreaper.sh" >&2
        echo "        Please start a new shell or run: source /etc/profile.d/netreaper.sh" >&2
    else
        echo "        Ensure $INSTALL_DIR is in your PATH." >&2
    fi
    exit 1
fi

echo "[✓] netreaper command is callable: $(command -v netreaper)" >&2

#═══════════════════════════════════════════════════════════════════════════════
# RUN TOOL INSTALLER (OPTIONAL - only if args provided)
#═══════════════════════════════════════════════════════════════════════════════
if [[ $# -gt 0 ]]; then
    if [[ ! -x "$SCRIPT_DIR/bin/netreaper-install" ]]; then
        echo "ERROR: bin/netreaper-install not found or not executable" >&2
        exit 1
    fi

    echo "[*] Running tool installer with args: $*" >&2
    "$SCRIPT_DIR/bin/netreaper-install" "$@"
    _install_exit=$?

    if [[ $_install_exit -ne 0 ]]; then
        echo "[FATAL] Tool installation failed with exit code $_install_exit" >&2
        exit $_install_exit
    fi
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
