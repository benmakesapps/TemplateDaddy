#!/bin/bash
# Usage: make package NAME=MyPackage
# Scaffolds a new local Swift package and wires it into project.yml.

set -euo pipefail

NAME="${1:-}"
if [ -z "$NAME" ]; then
  echo "Usage: make package NAME=MyPackage"
  exit 1
fi

if [ -d "$NAME" ]; then
  echo "Package '$NAME' already exists at $NAME/"
  exit 1
fi

# ── Create package directory & sources ────────────────────────────────────────

mkdir -p "$NAME/Sources"

cat > "$NAME/Package.swift" <<SWIFT
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "$NAME",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "$NAME", targets: ["$NAME"]),
    ],
    targets: [
        .target(name: "$NAME"),
    ]
)
SWIFT

cat > "$NAME/Sources/$NAME.swift" <<SWIFT
// $NAME
SWIFT

echo "  Created $NAME/Package.swift"
echo "  Created $NAME/Sources/$NAME.swift"

# ── Wire into project.yml ────────────────────────────────────────────────────

# Insert new package entry after the last "path:" line in the packages: section.
# Insert new dependency entry after the last "product:" line in the dependencies: section.
awk -v name="$NAME" '
  # Track when we enter the packages: section
  /^packages:/ { in_packages = 1 }
  in_packages && /^[^ ]/ && !/^packages:/ { in_packages = 0 }
  in_packages && /^    path:/ { last_pkg_line = NR; last_pkg_text = $0 }

  # Track when we enter the dependencies: section (indented under a target)
  /^    dependencies:/ { in_deps = 1 }
  in_deps && /^    [^ ]/ && !/^    dependencies:/ && !/^      / { in_deps = 0 }
  in_deps && /product:/ { last_dep_line = NR }

  { lines[NR] = $0 }

  END {
    for (i = 1; i <= NR; i++) {
      print lines[i]
      if (i == last_pkg_line) {
        print "  " name ":"
        print "    path: " name
      }
      if (i == last_dep_line) {
        print "      - package: " name
        print "        product: " name
      }
    }
  }
' project.yml > project.yml.tmp && mv project.yml.tmp project.yml

echo "  Updated project.yml"

# ── Regenerate Xcode project ─────────────────────────────────────────────────

make generate

echo "Package '$NAME' created and wired into the project."
