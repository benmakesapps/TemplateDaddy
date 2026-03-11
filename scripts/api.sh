#!/bin/bash
# Usage: make api NAME=MyApi
# Scaffolds a new API (response struct, protocol, class).

set -euo pipefail

NAME="${1:-}"
if [ -z "$NAME" ]; then
  echo "Usage: make api NAME=MyApi"
  exit 1
fi

SRC=$(grep '^name:' project.yml | awk '{print $2}')
FILE="Source/API/${NAME}API.swift"

if [ -f "$FILE" ]; then
  echo "API '$NAME' already exists at $FILE"
  exit 1
fi

cat > "$FILE" <<SWIFT
import Foundation

struct ${NAME}Response: Decodable {
    // TODO: define response fields
}

protocol ${NAME}APIProtocol {
    func fetch() async throws -> ${NAME}Response
}

final class ${NAME}API: ${NAME}APIProtocol {
    func fetch() async throws -> ${NAME}Response {
        // Stubbed — replace with a real URLSession call
        return ${NAME}Response()
    }
}
SWIFT

echo "  Created $FILE"
echo "API '$NAME' created."
