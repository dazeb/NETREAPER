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
# Safety library: authorization checks, target validation, privilege verification
# ═══════════════════════════════════════════════════════════════════════════════

# Prevent multiple sourcing
[[ -n "${_NETREAPER_SAFETY_LOADED:-}" ]] && return 0
readonly _NETREAPER_SAFETY_LOADED=1

# Source core library
source "${BASH_SOURCE%/*}/core.sh"

#═══════════════════════════════════════════════════════════════════════════════
# PRIVILEGE CHECKS
#═══════════════════════════════════════════════════════════════════════════════

# Check if running as root
# Returns: 0 if root, 1 if not
check_root() {
    if [[ $EUID -ne 0 ]]; then
        log_error "This operation requires root privileges"
        log_info "Please run with sudo or as root"
        return 1
    fi
    return 0
}

# Alias for compatibility
is_root() {
    [[ $EUID -eq 0 ]]
}

# Require root or exit
require_root() {
    if ! check_root; then
        log_fatal "Root privileges required. Exiting."
    fi
}

#═══════════════════════════════════════════════════════════════════════════════
# AUTHORIZATION CHECK
#═══════════════════════════════════════════════════════════════════════════════

# Authorization file location
readonly AUTHORIZATION_FILE="${NETREAPER_HOME}/.authorized"

# Check if user has acknowledged authorization requirement
# Returns: 0 if authorized, 1 if not (and prompts for confirmation)
check_authorization() {
    # Already authorized
    if [[ -f "$AUTHORIZATION_FILE" ]]; then
        return 0
    fi

    # Ensure directory exists
    mkdir -p "$NETREAPER_HOME" 2>/dev/null

    echo
    echo -e "    ${C_RED}╔══════════════════════════════════════════════════════════════════════╗${C_RESET}"
    echo -e "    ${C_RED}║${C_RESET}                   ${C_YELLOW}⚠  AUTHORIZATION REQUIRED  ⚠${C_RESET}                     ${C_RED}║${C_RESET}"
    echo -e "    ${C_RED}╠══════════════════════════════════════════════════════════════════════╣${C_RESET}"
    echo -e "    ${C_RED}║${C_RESET}                                                                      ${C_RED}║${C_RESET}"
    echo -e "    ${C_RED}║${C_RESET}  ${C_WHITE}NETREAPER is an offensive security toolkit.${C_RESET}                        ${C_RED}║${C_RESET}"
    echo -e "    ${C_RED}║${C_RESET}  ${C_WHITE}Unauthorized use against systems you don't own or${C_RESET}                  ${C_RED}║${C_RESET}"
    echo -e "    ${C_RED}║${C_RESET}  ${C_WHITE}have explicit written permission to test is ILLEGAL.${C_RESET}               ${C_RED}║${C_RESET}"
    echo -e "    ${C_RED}║${C_RESET}                                                                      ${C_RED}║${C_RESET}"
    echo -e "    ${C_RED}║${C_RESET}  ${C_SHADOW}By proceeding, you confirm:${C_RESET}                                       ${C_RED}║${C_RESET}"
    echo -e "    ${C_RED}║${C_RESET}  ${C_SHADOW}• You have WRITTEN authorization to test target systems${C_RESET}           ${C_RED}║${C_RESET}"
    echo -e "    ${C_RED}║${C_RESET}  ${C_SHADOW}• You accept FULL legal responsibility for your actions${C_RESET}           ${C_RED}║${C_RESET}"
    echo -e "    ${C_RED}║${C_RESET}  ${C_SHADOW}• You understand unauthorized access is a FEDERAL CRIME${C_RESET}           ${C_RED}║${C_RESET}"
    echo -e "    ${C_RED}║${C_RESET}                                                                      ${C_RED}║${C_RESET}"
    echo -e "    ${C_RED}╚══════════════════════════════════════════════════════════════════════╝${C_RESET}"
    echo

    echo -ne "    ${C_YELLOW}Type '${C_GREEN}I AM AUTHORIZED${C_YELLOW}' to confirm you have permission: ${C_RESET}"
    read -r response

    if [[ "$response" == "I AM AUTHORIZED" ]]; then
        # Record authorization
        echo "$(date -Iseconds) | $(whoami)@$(hostname) | Authorized" > "$AUTHORIZATION_FILE"
        chmod 600 "$AUTHORIZATION_FILE" 2>/dev/null
        log_success "Authorization confirmed"
        log_audit "AUTHORIZATION" "User accepted terms" "success"
        return 0
    else
        log_error "Authorization not confirmed"
        log_audit "AUTHORIZATION" "User declined terms" "failed"
        return 1
    fi
}

# Reset authorization (for testing or re-confirmation)
reset_authorization() {
    if [[ -f "$AUTHORIZATION_FILE" ]]; then
        rm -f "$AUTHORIZATION_FILE"
        log_info "Authorization reset. You will be prompted again on next run."
    else
        log_info "No authorization file found."
    fi
}

#═══════════════════════════════════════════════════════════════════════════════
# IP ADDRESS VALIDATION
#═══════════════════════════════════════════════════════════════════════════════

# Check if IP is RFC1918 private address
# Args: $1 = IP address
# Returns: 0 if private, 1 if public
is_private_ip() {
    local ip="$1"

    # Validate IP format first
    if [[ ! "$ip" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        return 1
    fi

    # Extract octets
    local IFS='.'
    read -ra octets <<< "$ip"
    local o1="${octets[0]}"
    local o2="${octets[1]}"

    # RFC1918 ranges:
    # 10.0.0.0/8       (10.0.0.0 - 10.255.255.255)
    # 172.16.0.0/12    (172.16.0.0 - 172.31.255.255)
    # 192.168.0.0/16   (192.168.0.0 - 192.168.255.255)

    # 10.0.0.0/8
    if [[ "$o1" -eq 10 ]]; then
        return 0
    fi

    # 172.16.0.0/12
    if [[ "$o1" -eq 172 ]] && [[ "$o2" -ge 16 ]] && [[ "$o2" -le 31 ]]; then
        return 0
    fi

    # 192.168.0.0/16
    if [[ "$o1" -eq 192 ]] && [[ "$o2" -eq 168 ]]; then
        return 0
    fi

    # Loopback 127.0.0.0/8
    if [[ "$o1" -eq 127 ]]; then
        return 0
    fi

    # Link-local 169.254.0.0/16
    if [[ "$o1" -eq 169 ]] && [[ "$o2" -eq 254 ]]; then
        return 0
    fi

    # Not a private IP
    return 1
}

# Check if target is a CIDR range that covers everything
# Args: $1 = target
# Returns: 0 if dangerous, 1 if OK
is_dangerous_range() {
    local target="$1"

    # Block 0.0.0.0/0 (entire internet)
    if [[ "$target" == "0.0.0.0/0" ]]; then
        return 0
    fi

    # Block ::/0 (entire IPv6 internet)
    if [[ "$target" == "::/0" ]]; then
        return 0
    fi

    # Block very broad ranges
    if [[ "$target" =~ ^0\.0\.0\.0/[0-7]$ ]]; then
        return 0
    fi

    return 1
}

#═══════════════════════════════════════════════════════════════════════════════
# TARGET VALIDATION
#═══════════════════════════════════════════════════════════════════════════════

# Validate a target before scanning/attacking
# Args: $1 = target (IP, hostname, CIDR)
# Returns: 0 if OK, 1 if blocked
validate_target() {
    local target="$1"

    # Empty target
    if [[ -z "$target" ]]; then
        log_error "No target specified"
        return 1
    fi

    # Check for dangerous ranges
    if is_dangerous_range "$target"; then
        log_error "Target '$target' is blocked - cannot target entire internet"
        log_audit "TARGET_BLOCKED" "$target" "dangerous_range"
        return 1
    fi

    # If it looks like an IP, check if it's public
    if [[ "$target" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}(/[0-9]{1,2})?$ ]]; then
        # Extract IP (strip CIDR if present)
        local ip="${target%/*}"

        if ! is_private_ip "$ip"; then
            log_warning "Target '$target' appears to be a PUBLIC IP address"
            log_warning "Ensure you have WRITTEN AUTHORIZATION to test this target"

            # In unsafe mode, allow without prompt
            if [[ "${NR_UNSAFE_MODE:-}" == "true" ]]; then
                log_warning "NR_UNSAFE_MODE enabled - proceeding without confirmation"
                log_audit "PUBLIC_TARGET" "$target" "allowed_unsafe_mode"
                return 0
            fi

            # Prompt for confirmation
            echo -ne "    ${C_YELLOW}Continue with public IP? [y/N]: ${C_RESET}"
            read -r confirm
            if [[ "${confirm,,}" != "y" ]]; then
                log_info "Operation cancelled"
                log_audit "PUBLIC_TARGET" "$target" "user_cancelled"
                return 1
            fi
            log_audit "PUBLIC_TARGET" "$target" "user_confirmed"
        fi
    fi

    # Target passed validation
    log_debug "Target validated: $target"
    return 0
}

#═══════════════════════════════════════════════════════════════════════════════
# UNSAFE MODE
#═══════════════════════════════════════════════════════════════════════════════

# Check if unsafe mode is enabled for dangerous operations
# Returns: 0 if unsafe mode enabled, 1 if not
require_unsafe_mode() {
    local operation="${1:-dangerous operation}"

    if [[ "${NR_UNSAFE_MODE:-}" != "true" ]]; then
        log_error "This $operation requires NR_UNSAFE_MODE=true"
        log_info "Set environment variable: export NR_UNSAFE_MODE=true"
        log_warning "This bypasses safety checks - use with extreme caution"
        return 1
    fi

    log_warning "NR_UNSAFE_MODE is enabled - safety checks bypassed"
    log_audit "UNSAFE_MODE" "$operation" "allowed"
    return 0
}

# Check if unsafe mode is active (without requiring it)
is_unsafe_mode() {
    [[ "${NR_UNSAFE_MODE:-}" == "true" ]]
}

#═══════════════════════════════════════════════════════════════════════════════
# EXPORT FUNCTIONS
#═══════════════════════════════════════════════════════════════════════════════

# Privilege checks
export -f check_root is_root require_root

# Authorization
export -f check_authorization reset_authorization

# IP validation
export -f is_private_ip is_dangerous_range

# Target validation
export -f validate_target

# Unsafe mode
export -f require_unsafe_mode is_unsafe_mode

# Export variables
export AUTHORIZATION_FILE
