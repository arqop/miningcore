#!/usr/bin/env bash

miningcore_is_release_tag() {
  local tag=$1
  local identifier
  local -a identifiers

  # Build metadata is excluded because '+' cannot be used in OCI image tags.
  if [[ ! "$tag" =~ ^v(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*)?$ ]]; then
    return 1
  fi

  if [[ "$tag" == *-* ]]; then
    IFS=. read -r -a identifiers <<< "${tag#*-}"
    for identifier in "${identifiers[@]}"; do
      if [[ "$identifier" =~ ^0[0-9]+$ ]]; then
        return 1
      fi
    done
  fi
}
