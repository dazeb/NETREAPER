#!/usr/bin/env bats
# ═══════════════════════════════════════════════════════════════════════════════
# NETREAPER - Test Suite: System Detection
# ═══════════════════════════════════════════════════════════════════════════════
# Tests for distribution and package manager detection
# ═══════════════════════════════════════════════════════════════════════════════

# Get the project root directory
NETREAPER_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"

# Setup - source the detection library
setup() {
    # Source core first (required by detection)
    source "$NETREAPER_ROOT/lib/core.sh"
    source "$NETREAPER_ROOT/lib/detection.sh"
}

#───────────────────────────────────────────────────────────────────────────────
# Distribution detection tests
#───────────────────────────────────────────────────────────────────────────────

@test "detect_distro returns a non-empty value" {
    result=$(detect_distro)
    [ -n "$result" ]
}

@test "detect_distro returns a valid distro name" {
    result=$(detect_distro)

    # List of known valid distro names
    valid_distros="debian ubuntu kali parrot linuxmint pop elementary zorin mx fedora rhel centos rocky alma oracle amazon arch manjaro endeavouros blackarch arcolinux garuda opensuse suse sles alpine gentoo funtoo void unknown"

    # Check if result is in the valid list
    found=0
    for distro in $valid_distros; do
        if [ "$result" = "$distro" ]; then
            found=1
            break
        fi
    done

    [ "$found" -eq 1 ]
}

@test "detect_distro_family returns a non-empty value" {
    distro=$(detect_distro)
    result=$(detect_distro_family "$distro")
    [ -n "$result" ]
}

@test "detect_distro_family returns valid family name" {
    distro=$(detect_distro)
    result=$(detect_distro_family "$distro")

    # Valid family names
    valid_families="debian redhat arch suse alpine gentoo void unknown"

    found=0
    for family in $valid_families; do
        if [ "$result" = "$family" ]; then
            found=1
            break
        fi
    done

    [ "$found" -eq 1 ]
}

#───────────────────────────────────────────────────────────────────────────────
# Package manager detection tests
#───────────────────────────────────────────────────────────────────────────────

@test "detect_package_manager returns a non-empty value" {
    result=$(detect_package_manager)
    [ -n "$result" ]
}

@test "detect_package_manager returns valid package manager" {
    result=$(detect_package_manager)

    # Valid package managers
    valid_pkg_managers="apt dnf yum pacman zypper apk emerge xbps unknown"

    found=0
    for pkg in $valid_pkg_managers; do
        if [ "$result" = "$pkg" ]; then
            found=1
            break
        fi
    done

    [ "$found" -eq 1 ]
}

@test "setup_package_manager sets PKG_MANAGER variable" {
    setup_package_manager
    [ -n "$PKG_MANAGER" ]
}

@test "setup_package_manager sets PKG_INSTALL variable for known managers" {
    setup_package_manager

    # If we have a known package manager, PKG_INSTALL should be set
    if [ "$PKG_MANAGER" != "unknown" ]; then
        [ -n "$PKG_INSTALL" ]
    fi
}

#───────────────────────────────────────────────────────────────────────────────
# Tool detection tests
#───────────────────────────────────────────────────────────────────────────────

@test "check_tool returns 0 for existing command (bash)" {
    run check_tool "bash"
    [ "$status" -eq 0 ]
}

@test "check_tool returns 1 for non-existent command" {
    run check_tool "this_command_definitely_does_not_exist_12345"
    [ "$status" -eq 1 ]
}

@test "check_tool returns 1 for empty argument" {
    run check_tool ""
    [ "$status" -eq 1 ]
}

@test "get_tool_path returns path for existing command" {
    result=$(get_tool_path "bash")
    [ -n "$result" ]
    [ -x "$result" ]
}

@test "get_tool_path returns empty for non-existent command" {
    result=$(get_tool_path "this_command_definitely_does_not_exist_12345")
    [ -z "$result" ]
}

#───────────────────────────────────────────────────────────────────────────────
# Network interface detection tests
#───────────────────────────────────────────────────────────────────────────────

@test "check_interface returns 0 for loopback (lo)" {
    run check_interface "lo"
    [ "$status" -eq 0 ]
}

@test "check_interface returns 1 for non-existent interface" {
    run check_interface "nonexistent_interface_12345"
    [ "$status" -eq 1 ]
}

@test "check_interface returns 1 for empty argument" {
    run check_interface ""
    [ "$status" -eq 1 ]
}

@test "get_default_interface returns a value (may be empty on some systems)" {
    # This test just verifies the function runs without error
    run bash -c "source '$NETREAPER_ROOT/lib/core.sh'; source '$NETREAPER_ROOT/lib/detection.sh'; get_default_interface"
    [ "$status" -eq 0 ]
}

@test "get_interface_state returns valid state for loopback" {
    result=$(get_interface_state "lo")

    # Should return up, down, or unknown
    [[ "$result" == "up" ]] || [[ "$result" == "down" ]] || [[ "$result" == "unknown" ]]
}

@test "get_interface_mac returns MAC address format for loopback" {
    result=$(get_interface_mac "lo")

    # Loopback typically has 00:00:00:00:00:00
    # Just check it's either empty or matches MAC format
    if [ -n "$result" ]; then
        [[ "$result" =~ ^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$ ]]
    fi
}

#───────────────────────────────────────────────────────────────────────────────
# System detection integration test
#───────────────────────────────────────────────────────────────────────────────

@test "detect_system sets all required variables" {
    detect_system

    # All these should be set after detect_system
    [ -n "$DISTRO" ]
    [ -n "$DISTRO_FAMILY" ]
    [ -n "$PKG_MANAGER" ]
}

@test "detect_system is idempotent (can be called multiple times)" {
    detect_system
    first_distro="$DISTRO"

    detect_system
    second_distro="$DISTRO"

    [ "$first_distro" = "$second_distro" ]
}
