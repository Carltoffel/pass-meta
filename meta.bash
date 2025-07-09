#!/usr/bin/env bash
# pass meta - Password Store Extension (https://www.passwordstore.org/)
# Copyright (C) 2025 Carl Ahring
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -euo pipefail

VERSION="0.1.0"


cmd_meta_usage() {
  cat <<EOF
Usage:
  $PROGRAM meta pass-name [key]     – Print the password (line 1) or metadata field by key

Examples:
  $PROGRAM meta wiki.archlinux.org         → shows the password
  $PROGRAM meta wiki.archlinux.org user    → shows the user value

Options:
  -h, --help                Show this help
  --version                 Show version info
EOF
}


cmd_meta_version() {
  echo "pass-meta $VERSION"
  exit 0
}


cmd_meta_get() {
  local entry="${1:-}"
  local key="${2:-}"

  if [[ -z "$entry" ]]; then
    echo "Error: No entry specified." >&2
    cmd_meta_usage
    exit 1
  fi

  local output
  output="$($PROGRAM show "$entry")"

  if [[ -z "$key" ]]; then
    echo "$output" | head -n1
  else
    local match
    match=$(echo "$output" | grep -i "^$key:" | head -n1 || true)
    if [[ -n "$match" ]]; then
      echo "$match" | sed -E "s/^$key:[[:space:]]*//I"
    else
      echo "Key '$key' not found in entry '$entry'" >&2
      return 1
    fi
  fi
}


case "${1:-}" in
  help|-h|--help)
    shift
    cmd_meta_usage "$@"
    ;;
  version|--version|-v|-V)
    shift
    cmd_meta_version "$@"
    ;;
  *)
    cmd_meta_get "$@"
    ;;
esac

exit 0
