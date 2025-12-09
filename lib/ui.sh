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
# UI library: banners, menus, prompts, progress indicators, display functions
# ═══════════════════════════════════════════════════════════════════════════════

# Prevent multiple sourcing
[[ -n "${_NETREAPER_UI_LOADED:-}" ]] && return 0
readonly _NETREAPER_UI_LOADED=1

# Source core library
source "${BASH_SOURCE%/*}/core.sh"

#═══════════════════════════════════════════════════════════════════════════════
# VISUAL EFFECTS
#═══════════════════════════════════════════════════════════════════════════════

typewriter() {
    local text="${1:-}" delay="${2:-0.015}"
    if [[ "$QUIET" == "true" || "$QUIET" == "1" ]]; then
        echo "$text"
        return
    fi
    for ((i=0; i<${#text}; i++)); do
        printf '%s' "${text:$i:1}"
        sleep "$delay"
    done
    echo
}

spinner() {
    local pid="${1:-}" msg="${2:-Processing}"
    [[ -z "$pid" ]] && return 1
    local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local i=0
    tput civis 2>/dev/null || true
    while kill -0 "$pid" 2>/dev/null; do
        printf "\r    ${C_GHOST}%s${C_RESET} %s..." "${frames[$i]}" "$msg"
        i=$(( (i+1) % ${#frames[@]} ))
        sleep 0.08
    done
    printf "\r    ${C_VENOM}✓${C_RESET} %s      \n" "$msg"
    tput cnorm 2>/dev/null || true
}

progress_bar() {
    local current="${1:-0}" total="${2:-1}" width=40 label="${3:-}"
    local pct=$((current * 100 / total))
    local filled=$((current * width / total))
    local empty=$((width - filled))
    printf '\r    %s[%s' "$C_SHADOW" "$C_RESET"
    printf '%s%*s%s' "$C_VENOM" "$filled" "" "$C_RESET" | tr ' ' '█'
    printf '%s%*s%s' "$C_SHADOW" "$empty" "" "$C_RESET" | tr ' ' '░'
    printf '%s]%s %s%3d%%%s' "$C_SHADOW" "$C_RESET" "$C_SKULL" "$pct" "$C_RESET"
    [[ -n "$label" ]] && printf ' %s%s%s' "$C_DIM" "$label" "$C_RESET"
}

draw_line() {
    local char="${1:-─}" width="${2:-70}"
    printf '%*s\n' "$width" '' | tr ' ' "$char"
}

#═══════════════════════════════════════════════════════════════════════════════
# SCREEN CONTROL
#═══════════════════════════════════════════════════════════════════════════════

clear_screen() {
    clear
}

pause() {
    echo
    echo -ne "    ${C_SHADOW}Press Enter to continue...${C_RESET}"
    read -r
}

#═══════════════════════════════════════════════════════════════════════════════
# BANNER DISPLAY
#═══════════════════════════════════════════════════════════════════════════════

show_banner() {
    clear
    echo -e "${C_RED}"
    cat << 'BANNER'

    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                                                                           ║
    ║  ███╗   ██╗███████╗████████╗██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗  ║
    ║  ████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗ ║
    ║  ██╔██╗ ██║█████╗     ██║   ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝ ║
    ║  ██║╚██╗██║██╔══╝     ██║   ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗ ║
    ║  ██║ ╚████║███████╗   ██║   ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║ ║
    ║  ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝ ║
    ║                                                                           ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
BANNER
    echo -e "${C_RESET}"
    echo
    echo -e "    ${C_BORDER}══════════════════════════════════════════════════════════════════════${C_RESET}"
    echo -e "    ${C_SHADOW}║${C_RESET} ${C_RED}\"Some tools scan.${C_RESET} ${C_CYAN}Some tools attack.${C_RESET} ${C_GREEN}I do both.\"${C_RESET}               ${C_SHADOW}║${C_RESET}"
    echo -e "    ${C_BORDER}══════════════════════════════════════════════════════════════════════${C_RESET}"
    echo -e "                   ${C_SHADOW}[${C_RESET} ${C_RED}v${VERSION}${C_RESET} ${C_SHADOW}•${C_RESET} ${C_CYAN}${CODENAME}${C_RESET} ${C_SHADOW}•${C_RESET} ${C_GREEN}70+ Tools${C_RESET} ${C_SHADOW}]${C_RESET}"
    echo
}

show_mini_banner() {
    echo -e "${C_BLOOD}    ╔═══════════════════════════════════════════════════════════════╗${C_RESET}"
    echo -e "${C_BLOOD}    ║${C_RESET}  ${C_SKULL}NETREAPER${C_RESET} ${C_SHADOW}v${VERSION}${C_RESET}                                              ${C_BLOOD}║${C_RESET}"
    echo -e "${C_BLOOD}    ╚═══════════════════════════════════════════════════════════════╝${C_RESET}"
}

show_skull() {
    echo -e "${C_BLOOD}"
    cat << 'SKULL'
                              ______
                           .-"      "-.
                          /            \
                         |              |
                         |,  .-.  .-.  ,|
                         | )(_o/  \o_)( |
                         |/     /\     \|
                         (_     ^^     _)
                          \__|IIIIII|__/
                           | \IIIIII/ |
                           \          /
                            `--------`
SKULL
    echo -e "${C_RESET}"
}

#═══════════════════════════════════════════════════════════════════════════════
# INPUT SANITIZATION
#═══════════════════════════════════════════════════════════════════════════════

strip_ansi() {
    local text="$1"
    # Remove all ANSI escape sequences
    echo -e "$text" | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g' | sed 's/\x1b\[[0-9;]*m//g' | sed 's/\x1b(B//g'
}

sanitize_filename() {
    local input="$1"
    # Strip ANSI, then keep only safe filename characters
    strip_ansi "$input" | tr -cd '[:alnum:]._-' | cut -c1-100
}

sanitize_target() {
    local input="$1"
    # Strip ANSI and trim whitespace
    strip_ansi "$input" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

#═══════════════════════════════════════════════════════════════════════════════
# INPUT FUNCTIONS
#═══════════════════════════════════════════════════════════════════════════════

get_target_input() {
    local prompt="${1:-Enter target}"
    local default="${2:-}"
    local target=""

    if [[ -n "$default" ]]; then
        echo -ne "    ${C_PROMPT}${prompt} ${C_SHADOW}[${default}]${C_RESET}: " >&2
    else
        echo -ne "    ${C_PROMPT}${prompt}: ${C_RESET}" >&2
    fi

    read -r target

    # Use default if empty
    [[ -z "$target" ]] && target="$default"

    # Sanitize and return (echo to stdout, prompts went to stderr)
    sanitize_target "$target"
}

get_input() {
    local prompt="${1:-Input}"
    local default="${2:-}"
    local input=""

    if [[ -n "$default" ]]; then
        echo -ne "    ${C_PROMPT}${prompt} ${C_SHADOW}[${default}]${C_RESET}: " >&2
    else
        echo -ne "    ${C_PROMPT}${prompt}: ${C_RESET}" >&2
    fi

    read -r input

    # Use default if empty
    [[ -z "$input" ]] && input="$default"

    # Sanitize and return
    strip_ansi "$input"
}

get_password_input() {
    local prompt="${1:-Password}"
    local password=""

    echo -ne "    ${C_PROMPT}${prompt}: ${C_RESET}" >&2
    read -rs password
    echo >&2  # Newline after hidden input

    echo "$password"
}

prompt_input() {
    local message="$1" validator="${2:-}" default="${3:-}" display_default=""
    [[ -n "$default" ]] && display_default=" ${C_SHADOW}[$default]${C_RESET}"
    while true; do
        echo -ne "    ${C_PROMPT}$message${display_default}: ${C_RESET}" >&2
        read -r input
        input="${input:-$default}"
        input=$(strip_ansi "$input")
        if [[ -z "$input" ]]; then
            log_warning "Input required"
            continue
        fi
        if [[ -n "$validator" ]]; then
            if $validator "$input"; then
                echo "$input"
                return 0
            else
                log_warning "Invalid input, please try again"
                continue
            fi
        fi
        echo "$input"
        return 0
    done
}

#═══════════════════════════════════════════════════════════════════════════════
# CONFIRMATION FUNCTIONS
#═══════════════════════════════════════════════════════════════════════════════

confirm() {
    local message="${1:-Continue?}" default="${2:-n}" prompt
    if [[ "$default" == "y" ]]; then prompt="[Y/n]"; else prompt="[y/N]"; fi
    echo -ne "    ${C_PROMPT}$message $prompt: ${C_RESET}"
    read -r response
    response="${response:-$default}"
    [[ "${response,,}" == "y" || "${response,,}" == "yes" ]]
}

# Alias for confirm
ask_yes_no() {
    confirm "$@"
}

confirm_action() {
    local prompt="${1:-Continue?}"
    local default="${2:-n}"
    local response=""

    if [[ "$default" == "y" ]]; then
        echo -ne "    ${C_PROMPT}${prompt} [Y/n]: ${C_RESET}" >&2
    else
        echo -ne "    ${C_PROMPT}${prompt} [y/N]: ${C_RESET}" >&2
    fi

    read -r response
    response="${response:-$default}"

    [[ "${response,,}" == "y" || "${response,,}" == "yes" ]]
}

confirm_dangerous() {
    local message="${1:-This is a dangerous operation}"
    local confirm_word="${2:-YES}"
    local response=""

    echo >&2
    echo -e "    ${C_RED}╔══════════════════════════════════════════════════════════════╗${C_RESET}" >&2
    echo -e "    ${C_RED}║${C_RESET}  ${C_YELLOW}⚠️  WARNING: POTENTIALLY DANGEROUS OPERATION  ⚠️${C_RESET}            ${C_RED}║${C_RESET}" >&2
    echo -e "    ${C_RED}╚══════════════════════════════════════════════════════════════╝${C_RESET}" >&2
    echo >&2
    echo -e "    ${C_SHADOW}$message${C_RESET}" >&2
    echo >&2
    echo -ne "    ${C_YELLOW}Type '${confirm_word}' to confirm: ${C_RESET}" >&2
    read -r response

    [[ "$response" == "$confirm_word" ]]
}

#═══════════════════════════════════════════════════════════════════════════════
# SELECTION FUNCTIONS
#═══════════════════════════════════════════════════════════════════════════════

select_option() {
    local prompt="$1"; shift; local options=("$@")
    echo
    echo -e "    ${C_CYAN}$prompt${C_RESET}"
    echo
    local i=1
    for opt in "${options[@]}"; do
        echo -e "    ${C_GHOST}[$i]${C_RESET} $opt"
        ((i++))
    done
    echo
    echo -ne "    ${C_PROMPT}Select [1-${#options[@]}]: ${C_RESET}"
    read -r choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && ((choice >= 1 && choice <= ${#options[@]})); then
        echo "${options[$((choice-1))]}"
        return 0
    fi
    return 1
}

#═══════════════════════════════════════════════════════════════════════════════
# OPERATION DISPLAY FUNCTIONS
#═══════════════════════════════════════════════════════════════════════════════

operation_header() {
    local title="${1:-Operation}"
    local target="${2:-}"

    echo
    echo -e "    ${C_CYAN}┌─────────────────────────────────────────────────────────────┐${C_RESET}"
    echo -e "    ${C_CYAN}│${C_RESET} ${C_FIRE}⚔${C_RESET}  ${C_WHITE}${title}${C_RESET}"
    if [[ -n "$target" ]]; then
        # Sanitize target for display
        local clean_target
        clean_target=$(strip_ansi "$target")
        echo -e "    ${C_CYAN}│${C_RESET} ${C_SHADOW}Target:${C_RESET} ${C_GREEN}${clean_target}${C_RESET}"
    fi
    echo -e "    ${C_CYAN}└─────────────────────────────────────────────────────────────┘${C_RESET}"
    echo

    log_audit "OPERATION" "$title" "started"
}

operation_summary() {
    local status="${1:-info}"
    local message="${2:-Complete}"
    local extra="${3:-}"

    if [[ ! "$status" =~ ^(success|ok|done|0|fail|failed|error|1|warn|warning|partial|info)$ ]]; then
        extra="${message}${extra:+\n$extra}"
        message="$status"
        status="info"
    fi

    echo
    case "$status" in
        success|ok|done|0)
            echo -e "    ${C_GREEN}[✓]${C_RESET} ${message}"
            log_audit "RESULT" "$message" "success"
            ;;
        fail|failed|error|1)
            echo -e "    ${C_RED}[✗]${C_RESET} ${message}"
            log_audit "RESULT" "$message" "failed"
            ;;
        warn|warning|partial)
            echo -e "    ${C_YELLOW}[!]${C_RESET} ${message}"
            log_audit "RESULT" "$message" "warning"
            ;;
        info|*)
            echo -e "    ${C_CYAN}[*]${C_RESET} ${message}"
            log_audit "RESULT" "$message" "info"
            ;;
    esac

    [[ -n "$extra" ]] && echo -e "    ${C_SHADOW}${extra}${C_RESET}"
}

operation_footer() {
    operation_summary "$@"
}

#═══════════════════════════════════════════════════════════════════════════════
# INPUT VALIDATORS
#═══════════════════════════════════════════════════════════════════════════════

validate_ip() { [[ "$1" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; }
validate_cidr() { [[ "$1" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/[0-9]{1,2}$ ]]; }
validate_domain() { [[ "$1" =~ ^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?)*$ ]]; }
validate_interface() { ip link show "$1" &>/dev/null; }
validate_file_exists() { [[ -f "$1" ]]; }
validate_port() { local p="$1"; [[ "$p" =~ ^[0-9]+$ ]] && ((p >= 1 && p <= 65535)); }

#═══════════════════════════════════════════════════════════════════════════════
# EXPORT FUNCTIONS
#═══════════════════════════════════════════════════════════════════════════════

# Visual effects
export -f typewriter spinner progress_bar draw_line

# Screen control
export -f clear_screen pause

# Banners
export -f show_banner show_mini_banner show_skull

# Input sanitization
export -f strip_ansi sanitize_filename sanitize_target

# Input functions
export -f get_target_input get_input get_password_input prompt_input

# Confirmation functions
export -f confirm ask_yes_no confirm_action confirm_dangerous

# Selection functions
export -f select_option

# Operation display
export -f operation_header operation_summary operation_footer

# Validators
export -f validate_ip validate_cidr validate_domain validate_interface validate_file_exists validate_port
