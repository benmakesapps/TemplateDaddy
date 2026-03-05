#!/bin/bash
# Usage: make scene NAME=MyScene
# Scaffolds a new scene (Coordinator + View + ViewModel) with no service wiring.

set -euo pipefail

NAME="${1:-}"
if [ -z "$NAME" ]; then
  echo "Usage: make scene NAME=MyScene"
  exit 1
fi

SRC=$(grep '^name:' project.yml | awk '{print $2}')
DEST="$SRC/Scenes/$NAME"

if [ -d "$DEST" ]; then
  echo "Scene '$NAME' already exists at $DEST"
  exit 1
fi

mkdir -p "$DEST"

# ── Coordinator ───────────────────────────────────────────────────────────────
cat > "$DEST/${NAME}Coordinator.swift" <<SWIFT
import SwiftUI

struct ${NAME}Coordinator: View {
    @Environment(ServiceProvider.self) private var services

    var viewModel: ${NAME}ViewModel {
        ${NAME}ViewModel()
    }

    var body: some View {
        ${NAME}View(viewModel: viewModel)
    }
}
SWIFT

# ── ViewModel ─────────────────────────────────────────────────────────────────
cat > "$DEST/${NAME}ViewModel.swift" <<SWIFT
import Foundation
import Observation

@Observable
@MainActor
final class ${NAME}ViewModel {
    struct UIState {
        var isLoading: Bool = false
        var error: (any Error)?
    }

    var state = UIState()
}
SWIFT

# ── View ──────────────────────────────────────────────────────────────────────
cat > "$DEST/${NAME}View.swift" <<SWIFT
import SwiftUI

struct ${NAME}View: View {
    var viewModel: ${NAME}ViewModel

    var body: some View {
        ScrollView {
            VStack {
                if viewModel.state.isLoading {
                    ProgressView()
                } else if let error = viewModel.state.error {
                    Text(error.localizedDescription)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
SWIFT

echo "  Created $DEST/${NAME}Coordinator.swift"
echo "  Created $DEST/${NAME}ViewModel.swift"
echo "  Created $DEST/${NAME}View.swift"
echo "Scene '$NAME' created at $DEST"
