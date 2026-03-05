#!/bin/bash
# Usage: make service NAME=MyService
# Scaffolds a new service (domain model, protocol, class) wired to its API.

set -euo pipefail

NAME="${1:-}"
if [ -z "$NAME" ]; then
  echo "Usage: make service NAME=MyService"
  exit 1
fi

SRC=$(grep '^name:' project.yml | awk '{print $2}')
CAMEL="$(echo "${NAME:0:1}" | tr '[:upper:]' '[:lower:]')${NAME:1}"
FILE="$SRC/Services/${NAME}Service.swift"

if [ -f "$FILE" ]; then
  echo "Service '$NAME' already exists at $FILE"
  exit 1
fi

cat > "$FILE" <<SWIFT
import Foundation

struct ${NAME}Model {
    // TODO: define domain model fields
}

protocol ${NAME}ServiceProtocol {
    func get() async throws -> ${NAME}Model
}

final class ${NAME}Service: ${NAME}ServiceProtocol {
    private let api: ${NAME}APIProtocol

    init(api: ${NAME}APIProtocol = ${NAME}API()) {
        self.api = api
    }

    func get() async throws -> ${NAME}Model {
        let response = try await api.fetch()
        // TODO: transform API response → domain model
        return ${NAME}Model()
    }
}
SWIFT

echo "  Created $FILE"
echo "Service '$NAME' created. Add \`${CAMEL}Service\` to ServiceProvider to wire it."
