#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════════
# NETREAPER - Offensive Security Framework
# ═══════════════════════════════════════════════════════════════════════════════
# Copyright (c) 2025 OFFTRACKMEDIA Studios (ABN: 84 290 819 896)
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# See LICENSE and NOTICE files in the project root for full details.
# ═══════════════════════════════════════════════════════════════════════════════
#
# Detection library: system, distro, package manager, tools, network interfaces
# ═══════════════════════════════════════════════════════════════════════════════

# Prevent multiple sourcing
[[ -n "${_NETREAPER_DETECTION_LOADED:-}" ]] && return 0
readonly _NETREAPER_DETECTION_LOADED=1

# Source core library
source "${BASH_SOURCE%/*}/core.sh"

#═══════════════════════════════════════════════════════════════════════════════
# GLOBAL VARIABLES (set by detect_system)
#═══════════════════════════════════════════════════════════════════════════════

declare -g DISTRO=""
declare -g DISTRO_FAMILY=""
declare -g PKG_MANAGER=""
declare -g PKG_INSTALL=""
declare -g PKG_UPDATE=""
declare -g PKG_SEARCH=""
declare -g PKG_REMOVE=""

#═══════════════════════════════════════════════════════════════════════════════
# DISTRIBUTION DETECTION
#═══════════════════════════════════════════════════════════════════════════════

# Detect Linux distribution
# NOTE: We parse instead of source to avoid VERSION variable conflicts with /etc/os-release
# Returns: distro name (debian, fedora, arch, etc.) or "unknown"
detect_distro() {
    local distro=""

    if [[ -f /etc/os-release ]]; then
        # Parse instead of source to avoid variable conflicts (VERSION, etc.)
        distro=$(grep -oP '^ID=\K.*' /etc/os-release | tr -d '"')
    elif [[ -f /etc/lsb-release ]]; then
        distro=$(grep -oP '^DISTRIB_ID=\K.*' /etc/lsb-release | tr -d '"' | tr '[:upper:]' '[:lower:]')
    elif [[ -f /etc/debian_version ]]; then
        distro="debian"
    elif [[ -f /etc/fedora-release ]]; then
        distro="fedora"
    elif [[ -f /etc/centos-release ]]; then
        distro="centos"
    elif [[ -f /etc/arch-release ]]; then
        distro="arch"
    elif [[ -f /etc/gentoo-release ]]; then
        distro="gentoo"
    elif [[ -f /etc/alpine-release ]]; then
        distro="alpine"
    fi

    echo "${distro:-unknown}"
}

# Detect distro family
# Args: $1 = distro name
# Returns: family name (debian, redhat, arch, etc.)
detect_distro_family() {
    local distro="${1:-$(detect_distro)}"

    case "$distro" in
        debian|ubuntu|kali|parrot|linuxmint|pop|elementary|zorin|mx)
            echo "debian"
            ;;
        fedora|rhel|centos|rocky|alma|oracle|amazon)
            echo "redhat"
            ;;
        arch|manjaro|endeavouros|blackarch|arcolinux|garuda)
            echo "arch"
            ;;
        opensuse*|suse|sles)
            echo "suse"
            ;;
        alpine)
            echo "alpine"
            ;;
        gentoo|funtoo)
            echo "gentoo"
            ;;
        void)
            echo "void"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

#═══════════════════════════════════════════════════════════════════════════════
# PACKAGE MANAGER DETECTION
#═══════════════════════════════════════════════════════════════════════════════

# Detect and return package manager name
# Returns: apt, dnf, pacman, etc. or "unknown"
detect_package_manager() {
    if command -v apt-get &>/dev/null; then
        echo "apt"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v yum &>/dev/null; then
        echo "yum"
    elif command -v pacman &>/dev/null; then
        echo "pacman"
    elif command -v zypper &>/dev/null; then
        echo "zypper"
    elif command -v apk &>/dev/null; then
        echo "apk"
    elif command -v emerge &>/dev/null; then
        echo "emerge"
    elif command -v xbps-install &>/dev/null; then
        echo "xbps"
    else
        echo "unknown"
    fi
}

# Setup package manager variables based on detected manager
# Sets: PKG_MANAGER, PKG_INSTALL, PKG_UPDATE, PKG_SEARCH, PKG_REMOVE
setup_package_manager() {
    PKG_MANAGER=$(detect_package_manager)

    case "$PKG_MANAGER" in
        apt)
            PKG_INSTALL="apt-get install -y"
            PKG_UPDATE="apt-get update"
            PKG_SEARCH="apt-cache search"
            PKG_REMOVE="apt-get remove -y"
            ;;
        dnf)
            PKG_INSTALL="dnf install -y"
            PKG_UPDATE="dnf check-update"
            PKG_SEARCH="dnf search"
            PKG_REMOVE="dnf remove -y"
            ;;
        yum)
            PKG_INSTALL="yum install -y"
            PKG_UPDATE="yum check-update"
            PKG_SEARCH="yum search"
            PKG_REMOVE="yum remove -y"
            ;;
        pacman)
            PKG_INSTALL="pacman -S --noconfirm"
            PKG_UPDATE="pacman -Sy"
            PKG_SEARCH="pacman -Ss"
            PKG_REMOVE="pacman -R --noconfirm"
            ;;
        zypper)
            PKG_INSTALL="zypper install -y"
            PKG_UPDATE="zypper refresh"
            PKG_SEARCH="zypper search"
            PKG_REMOVE="zypper remove -y"
            ;;
        apk)
            PKG_INSTALL="apk add"
            PKG_UPDATE="apk update"
            PKG_SEARCH="apk search"
            PKG_REMOVE="apk del"
            ;;
        emerge)
            PKG_INSTALL="emerge"
            PKG_UPDATE="emerge --sync"
            PKG_SEARCH="emerge --search"
            PKG_REMOVE="emerge --unmerge"
            ;;
        xbps)
            PKG_INSTALL="xbps-install -y"
            PKG_UPDATE="xbps-install -S"
            PKG_SEARCH="xbps-query -Rs"
            PKG_REMOVE="xbps-remove -y"
            ;;
        *)
            PKG_INSTALL=""
            PKG_UPDATE=""
            PKG_SEARCH=""
            PKG_REMOVE=""
            return 1
            ;;
    esac

    return 0
}

#═══════════════════════════════════════════════════════════════════════════════
# TOOL DETECTION
#═══════════════════════════════════════════════════════════════════════════════

# Check if a tool/command is installed
# Args: $1 = tool name (command to check)
# Returns: 0 if installed, 1 if not
check_tool() {
    local tool="$1"
    [[ -z "$tool" ]] && return 1
    command -v "$tool" &>/dev/null
}

# Check if tool is installed with optional binary name
# Args: $1 = tool name, $2 = binary name (optional, defaults to tool name)
# Returns: 0 if installed, 1 if not
check_tool_installed() {
    local tool="$1"
    local binary="${2:-$tool}"
    command -v "$binary" &>/dev/null
}

# Get path to a tool
# Args: $1 = tool name
# Returns: path to tool or empty string
get_tool_path() {
    local tool="$1"
    command -v "$tool" 2>/dev/null || echo ""
}

#═══════════════════════════════════════════════════════════════════════════════
# NETWORK INTERFACE DETECTION
#═══════════════════════════════════════════════════════════════════════════════

# Check if network interface exists
# Args: $1 = interface name
# Returns: 0 if exists, 1 if not
check_interface() {
    local iface="$1"
    [[ -z "$iface" ]] && return 1
    [[ -d "/sys/class/net/$iface" ]]
}

# Check if interface is wireless (supports monitor mode)
# Args: $1 = interface name
# Returns: 0 if wireless, 1 if not
is_wireless_interface() {
    local iface="$1"
    [[ -z "$iface" ]] && return 1

    # Check for wireless directory in sysfs
    if [[ -d "/sys/class/net/$iface/wireless" ]]; then
        return 0
    fi

    # Fallback: try iw command
    if command -v iw &>/dev/null; then
        iw dev "$iface" info &>/dev/null && return 0
    fi

    return 1
}

# List all wireless interfaces
# Returns: space-separated list of wireless interface names
list_wireless_interfaces() {
    local interfaces=()

    for iface in /sys/class/net/*; do
        iface=$(basename "$iface")
        if [[ -d "/sys/class/net/$iface/wireless" ]]; then
            interfaces+=("$iface")
        fi
    done

    echo "${interfaces[*]}"
}

# Alias for compatibility
get_wireless_interfaces() {
    list_wireless_interfaces
}

# Get the default/primary network interface
# Returns: interface name or empty string
get_default_interface() {
    local iface=""

    # Method 1: Parse default route
    if command -v ip &>/dev/null; then
        iface=$(ip route show default 2>/dev/null | awk '/default/ {print $5}' | head -n1)
    fi

    # Method 2: Fallback to route command
    if [[ -z "$iface" ]] && command -v route &>/dev/null; then
        iface=$(route -n 2>/dev/null | awk '/^0.0.0.0/ {print $8}' | head -n1)
    fi

    # Method 3: Find first active interface
    if [[ -z "$iface" ]]; then
        for i in /sys/class/net/*; do
            local name=$(basename "$i")
            [[ "$name" == "lo" ]] && continue
            if [[ "$(cat "/sys/class/net/$name/operstate" 2>/dev/null)" == "up" ]]; then
                iface="$name"
                break
            fi
        done
    fi

    echo "$iface"
}

# Get interface state (up/down/unknown)
# Args: $1 = interface name
# Returns: up, down, or unknown
get_interface_state() {
    local iface="$1"
    [[ -z "$iface" ]] && echo "unknown" && return

    if [[ -f "/sys/class/net/$iface/operstate" ]]; then
        cat "/sys/class/net/$iface/operstate" 2>/dev/null || echo "unknown"
    else
        echo "unknown"
    fi
}

# Get interface MAC address
# Args: $1 = interface name
# Returns: MAC address or empty string
get_interface_mac() {
    local iface="$1"
    [[ -z "$iface" ]] && return

    if [[ -f "/sys/class/net/$iface/address" ]]; then
        cat "/sys/class/net/$iface/address" 2>/dev/null
    fi
}

#═══════════════════════════════════════════════════════════════════════════════
# SYSTEM DETECTION (MAIN FUNCTION)
#═══════════════════════════════════════════════════════════════════════════════

# Detect system and setup all variables
# Call this on startup to initialize detection
detect_system() {
    DISTRO=$(detect_distro)
    DISTRO_FAMILY=$(detect_distro_family "$DISTRO")
    setup_package_manager

    log_debug "System detected: $DISTRO ($DISTRO_FAMILY) with $PKG_MANAGER"
}

#═══════════════════════════════════════════════════════════════════════════════
# EXPORT FUNCTIONS
#═══════════════════════════════════════════════════════════════════════════════

# Distribution detection
export -f detect_distro detect_distro_family

# Package manager
export -f detect_package_manager setup_package_manager

# Tool detection
export -f check_tool check_tool_installed get_tool_path

# Network interfaces
export -f check_interface is_wireless_interface
export -f list_wireless_interfaces get_wireless_interfaces
export -f get_default_interface get_interface_state get_interface_mac

# System detection
export -f detect_system

# Export variables
export DISTRO DISTRO_FAMILY
export PKG_MANAGER PKG_INSTALL PKG_UPDATE PKG_SEARCH PKG_REMOVE
