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
# Core library: version, colors, logging, error handling, directory setup
# ═══════════════════════════════════════════════════════════════════════════════

# Prevent multiple sourcing
[[ -n "${_NETREAPER_CORE_LOADED:-}" ]] && return 0
readonly _NETREAPER_CORE_LOADED=1

#═══════════════════════════════════════════════════════════════════════════════
# ERROR HANDLING
#═══════════════════════════════════════════════════════════════════════════════

set -o pipefail

# Trap handler for errors (can be customized by main script)
_netreaper_error_handler() {
    local exit_code=$?
    local line_no=${1:-unknown}
    echo -e "\033[0;31m[ERROR]\033[0m Script error at line $line_no (exit code: $exit_code)" >&2
    return $exit_code
}

# Trap handler for cleanup on exit
_netreaper_cleanup() {
    # Placeholder for cleanup tasks - override in main script if needed
    :
}

# Set traps (can be overridden by main script)
trap '_netreaper_error_handler $LINENO' ERR
trap '_netreaper_cleanup' EXIT

#═══════════════════════════════════════════════════════════════════════════════
# VERSION INFORMATION
#═══════════════════════════════════════════════════════════════════════════════

# Source shared version helper to prevent drift between CLI output,
# VERSION file, documentation, and release workflow.
# shellcheck source=version.sh
source "$(dirname "${BASH_SOURCE[0]}")/version.sh"
readonly CODENAME="Phantom Protocol"
readonly SCRIPT_NAME="netreaper"

#═══════════════════════════════════════════════════════════════════════════════
# COLOR DEFINITIONS
#═══════════════════════════════════════════════════════════════════════════════

# Check if colors are supported
if [[ -t 1 ]] && [[ "${NO_COLOR:-}" != "1" ]]; then
    # Reset
    C_RESET='\033[0m'

    # Basic colors
    C_BLACK='\033[0;30m'
    C_RED='\033[0;31m'
    C_GREEN='\033[0;32m'
    C_YELLOW='\033[0;33m'
    C_BLUE='\033[0;34m'
    C_PURPLE='\033[0;35m'
    C_CYAN='\033[0;36m'
    C_WHITE='\033[0;37m'

    # Bold colors
    C_BOLD='\033[1m'
    C_BRED='\033[1;31m'
    C_BGREEN='\033[1;32m'
    C_BYELLOW='\033[1;33m'
    C_BCYAN='\033[1;36m'

    # Custom theme colors
    C_FIRE='\033[1;31m'
    C_BLOOD='\033[0;31m'
    C_GHOST='\033[0;90m'
    C_SHADOW='\033[0;90m'
    C_BORDER='\033[0;36m'
    C_PROMPT='\033[0;33m'
    C_ORANGE='\033[0;33m'

    # Semantic aliases
    C_SUCCESS="$C_GREEN"
    C_ERROR="$C_RED"
    C_WARNING="$C_YELLOW"
    C_INFO="$C_CYAN"
else
    # No colors
    C_RESET='' C_BLACK='' C_RED='' C_GREEN='' C_YELLOW=''
    C_BLUE='' C_PURPLE='' C_CYAN='' C_WHITE=''
    C_BOLD='' C_BRED='' C_BGREEN='' C_BYELLOW='' C_BCYAN=''
    C_FIRE='' C_BLOOD='' C_GHOST='' C_SHADOW='' C_BORDER=''
    C_PROMPT='' C_ORANGE='' C_SUCCESS='' C_ERROR='' C_WARNING='' C_INFO=''
fi

# Legacy aliases to preserve existing styling
readonly C_VENOM="${C_GREEN}"
readonly C_SKULL="${C_WHITE}"
readonly C_GOLD="${C_ORANGE}"

# Compatibility for legacy color references
[[ -z "${C_STEEL:-}" ]] && C_STEEL="${C_CYAN}"
[[ -z "${C_DIM:-}" ]] && C_DIM="${C_SHADOW}"

#═══════════════════════════════════════════════════════════════════════════════
# DIRECTORY & FILE SETUP
#═══════════════════════════════════════════════════════════════════════════════

NETREAPER_HOME="${HOME}/.netreaper"
CONFIG_DIR="${NETREAPER_HOME}/config"
CONFIG_FILE="${CONFIG_DIR}/netreaper.conf"
LOG_DIR="${NETREAPER_HOME}/logs"
OUTPUT_DIR="${NETREAPER_HOME}/output"
LOOT_DIR="${NETREAPER_HOME}/loot"
SESSION_DIR="${NETREAPER_HOME}/sessions"
HISTORY_FILE="${NETREAPER_HOME}/target_history"

# Log files
LOG_FILE="${LOG_DIR}/netreaper_$(date +%Y%m%d).log"
AUDIT_LOG="${LOG_DIR}/audit.log"

# Runtime flags
VERBOSE="${VERBOSE:-false}"
DEBUG="${DEBUG:-false}"
QUIET="${QUIET:-false}"

# Compatibility/legacy paths
BASE_LOG_DIR="$LOG_DIR"
BASE_OUTPUT_DIR="$OUTPUT_DIR"
BASE_LOOT_DIR="$LOOT_DIR"
SESSIONS_DIR="$SESSION_DIR"
SESSION_FILE="${SESSION_DIR}/.current_session"
LEGAL_FILE="${CONFIG_DIR}/.legal_accepted"
FAVORITES_FILE="${CONFIG_DIR}/favorites"
ALIASES_FILE="${CONFIG_DIR}/aliases"
PROFILES_DIR="${CONFIG_DIR}/profiles"
TMP_DIR="/tmp/netreaper"
CURRENT_SESSION=""
SESSION_NAME=""

DEFAULT_INTERFACE=""
DEFAULT_WORDLIST="/usr/share/wordlists/rockyou.txt"
DEFAULT_THEME="default"

#═══════════════════════════════════════════════════════════════════════════════
# DIRECTORY INITIALIZATION
#═══════════════════════════════════════════════════════════════════════════════

ensure_directories() {
    # Handle legacy config file path (previously a file at $CONFIG_DIR)
    if [[ -e "$CONFIG_DIR" && ! -d "$CONFIG_DIR" ]]; then
        local legacy_backup="${CONFIG_DIR}.bak.$(date +%Y%m%d%H%M%S)"
        mv "$CONFIG_DIR" "$legacy_backup" 2>/dev/null || cp "$CONFIG_DIR" "$legacy_backup" 2>/dev/null
        mkdir -p "$CONFIG_DIR"
        mv "$legacy_backup" "$CONFIG_FILE" 2>/dev/null || cp "$legacy_backup" "$CONFIG_FILE" 2>/dev/null
    fi

    # Create all directories
    mkdir -p "$CONFIG_DIR" "$LOG_DIR" "$OUTPUT_DIR" "$LOOT_DIR" "$SESSION_DIR" "$PROFILES_DIR" "$TMP_DIR" 2>/dev/null
    chmod 700 "$NETREAPER_HOME" 2>/dev/null
    touch "$LOG_FILE" "$AUDIT_LOG" 2>/dev/null
    chmod 600 "$LOG_FILE" "$AUDIT_LOG" 2>/dev/null || true

    # Migrate legacy flat-file locations into new structure
    for legacy_file in "$NETREAPER_HOME/favorites" "$NETREAPER_HOME/aliases"; do
        local dest_path="$CONFIG_DIR/$(basename "$legacy_file")"
        if [[ -f "$legacy_file" && ! -f "$dest_path" ]]; then
            mv "$legacy_file" "$dest_path" 2>/dev/null || cp "$legacy_file" "$dest_path" 2>/dev/null
        fi
    done

    if [[ -f "$NETREAPER_HOME/history" && ! -f "$HISTORY_FILE" ]]; then
        mv "$NETREAPER_HOME/history" "$HISTORY_FILE" 2>/dev/null || cp "$NETREAPER_HOME/history" "$HISTORY_FILE" 2>/dev/null
    fi
}

#═══════════════════════════════════════════════════════════════════════════════
# LOGGING FUNCTIONS
#═══════════════════════════════════════════════════════════════════════════════

log_to_file() {
    local message="$1"
    local timestamp
    # Only log if LOG_FILE is set and the log directory exists (avoid failures in test/CI environments)
    [[ -z "${LOG_FILE:-}" ]] && return 0
    [[ ! -d "${LOG_FILE%/*}" ]] && return 0
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> "$LOG_FILE" 2>/dev/null || true
}

log_debug() {
    if [[ "$DEBUG" == "true" ]]; then
        echo -e "    ${C_SHADOW}[~]${C_RESET} $*"
    fi
    log_to_file "[DEBUG] $*"
}

log_verbose() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "    ${C_SHADOW}[*]${C_RESET} $*"
    fi
    log_to_file "[VERBOSE] $*"
}

log_info() {
    [[ "$QUIET" != "true" && "$QUIET" != "1" ]] && echo -e "    ${C_CYAN}[*]${C_RESET} $*"
    log_to_file "[INFO] $*"
}

log_success() {
    [[ "$QUIET" != "true" && "$QUIET" != "1" ]] && echo -e "    ${C_GREEN}[✓]${C_RESET} $*"
    log_to_file "[SUCCESS] $*"
}

log_warning() {
    echo -e "    ${C_YELLOW}[!]${C_RESET} $*"
    log_to_file "[WARNING] $*"
}

log_error() {
    echo -e "    ${C_RED}[✗]${C_RESET} $*" >&2
    log_to_file "[ERROR] $*"
}

log_fatal() {
    echo -e "    ${C_BRED}[☠]${C_RESET} $*" >&2
    log_to_file "[FATAL] $*"
    exit 1
}

log_audit() {
    local action="${1:-ACTION}"
    local target="${2:-}"
    local result="${3:-}"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "[$timestamp] [AUDIT] action=\"$action\" target=\"$target\" result=\"$result\" user=\"$(whoami)\" pid=\"$$\"" >> "$AUDIT_LOG" 2>/dev/null
}

log_command_preview() {
    local cmd="${1:-}"

    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "    ${C_SHADOW}\$ ${cmd}${C_RESET}"
    fi

    log_to_file "[EXEC] $cmd"
    log_audit "EXECUTE" "${cmd:0:200}" "started"
}

# Semantic logging aliases
log_attack()  { log_warning "$@"; }
log_target()  { log_info "$@"; }
log_loot()    { log_success "$@"; }

init_logging() {
    mkdir -p "$LOG_DIR"
    touch "$LOG_FILE" "$AUDIT_LOG"
    chmod 600 "$LOG_FILE" "$AUDIT_LOG" 2>/dev/null || true
    log_debug "NETREAPER v${VERSION} (${CODENAME}) started at $(date '+%Y-%m-%d %H:%M:%S')"
}

#═══════════════════════════════════════════════════════════════════════════════
# DRY-RUN EXECUTION WRAPPERS
#═══════════════════════════════════════════════════════════════════════════════

# Safe command execution wrapper
# Respects NR_DRY_RUN flag - prints command instead of executing
nr_run() {
    if [[ "${NR_DRY_RUN:-0}" -eq 1 ]]; then
        echo -e "${C_YELLOW}[DRY-RUN]${C_RESET} $*" >&2
        return 0
    fi
    "$@"
}

# For commands that need shell evaluation
nr_run_eval() {
    if [[ "${NR_DRY_RUN:-0}" -eq 1 ]]; then
        echo -e "${C_YELLOW}[DRY-RUN]${C_RESET} $*" >&2
        return 0
    fi
    eval "$@"
}

#═══════════════════════════════════════════════════════════════════════════════
# EXPORT FUNCTIONS
#═══════════════════════════════════════════════════════════════════════════════

export -f log_info log_error log_success log_warning
export -f log_debug log_verbose log_fatal log_audit log_to_file log_command_preview
export -f log_attack log_target log_loot init_logging
export -f nr_run nr_run_eval
export -f ensure_directories
export -f _netreaper_error_handler _netreaper_cleanup

# Export variables
export VERSION CODENAME SCRIPT_NAME
export NETREAPER_ROOT NETREAPER_HOME CONFIG_DIR CONFIG_FILE LOG_DIR OUTPUT_DIR LOOT_DIR SESSION_DIR
export LOG_FILE AUDIT_LOG HISTORY_FILE
export BASE_LOG_DIR BASE_OUTPUT_DIR BASE_LOOT_DIR SESSIONS_DIR SESSION_FILE
export LEGAL_FILE FAVORITES_FILE ALIASES_FILE PROFILES_DIR TMP_DIR
export CURRENT_SESSION SESSION_NAME
export DEFAULT_INTERFACE DEFAULT_WORDLIST DEFAULT_THEME
export VERBOSE DEBUG QUIET
export C_RESET C_BLACK C_RED C_GREEN C_YELLOW C_BLUE C_PURPLE C_CYAN C_WHITE
export C_BOLD C_BRED C_BGREEN C_BYELLOW C_BCYAN
export C_FIRE C_BLOOD C_GHOST C_SHADOW C_BORDER C_PROMPT C_ORANGE
export C_SUCCESS C_ERROR C_WARNING C_INFO
export C_VENOM C_SKULL C_GOLD C_STEEL C_DIM
