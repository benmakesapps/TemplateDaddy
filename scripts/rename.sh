#!/bin/bash
# Usage: ./scripts/rename.sh <NewName>
# Renames the project from its current name (read from project.yml) to <NewName>.
# Touches: project.yml, Makefile, the source folder, and all .swift files.

set -euo pipefail

NEW="${1:-}"
if [ -z "$NEW" ]; then
  echo "Usage: make rename NAME=YourAppName"
  exit 1
fi

# Detect the current project name from project.yml
CURRENT=$(grep '^name:' project.yml | awk '{print $2}')

if [ "$NEW" = "$CURRENT" ]; then
  echo "Project is already named '$NEW'."
  exit 0
fi

echo "Renaming '$CURRENT' → '$NEW'..."

# Update all references in project.yml and Makefile
sed -i '' "s/$CURRENT/$NEW/g" project.yml
sed -i '' "s/$CURRENT/$NEW/g" Makefile

# Update all references inside Swift source files
find "$CURRENT" -name "*.swift" -exec sed -i '' "s/$CURRENT/$NEW/g" {} \;

# Rename the app entry point file (e.g. TemplateDaddyApp.swift → MyNewAppApp.swift)
if [ -f "$CURRENT/${CURRENT}App.swift" ]; then
  mv "$CURRENT/${CURRENT}App.swift" "$CURRENT/${NEW}App.swift"
fi

# Rename the source folder itself
mv "$CURRENT" "$NEW"

echo "Done. Running 'make generate' to rebuild the Xcode project..."
make generate
