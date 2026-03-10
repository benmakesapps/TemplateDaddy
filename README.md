# TemplateDaddy

An iOS SwiftUI starter template with automated scaffolding, modular architecture, and XcodeGen-based project generation. Clone it, rename it, and start building.

## Features

- **XcodeGen** — project generated from `project.yml`, eliminating merge conflicts on `.xcodeproj`
- **Scaffolding** — `make` commands to generate scenes, services, APIs, and local Swift packages
- **Navigation** — enum-based stack and sheet navigation via the [Navigation](https://github.com/benmakesapps/Navigation) package
- **Dependency injection** — `@Observable` `ServiceProvider` injected through SwiftUI environment
- **Swift Testing** — unit test target with coverage, parallel execution, and random ordering

## Prerequisites

- Xcode 16+
- iOS 18.2+ deployment target

## Setup

```bash
# Install xcodegen (if needed) and generate the Xcode project
make bootstrap

# Or generate and open in Xcode in one step
make open
```

## Common Workflows

### Building

```bash
make build       # Build for iOS Simulator (iPhone 16)
make generate    # Regenerate Xcode project from project.yml
make clean       # Remove generated .xcodeproj
```

### Scaffolding

```bash
# Scene (Coordinator + ViewModel + View)
make scene NAME=Profile
# → Source/Scenes/Profile/{ProfileCoordinator,ProfileViewModel,ProfileView}.swift

# API layer (Response + Protocol + Implementation)
make api NAME=User
# → Source/API/UserAPI.swift

# Service (Model + Protocol + Implementation, wired to API)
make service NAME=User
# → Source/Services/UserService.swift

# Local Swift package
make package NAME=Analytics
# → Analytics/ with Package.swift, Sources/, Tests/
#   Automatically added to project.yml as a dependency
```

### Renaming the Project

```bash
make rename NAME=MyNewApp
```

Updates `project.yml`, `Makefile`, Swift source files, and directory names.

### Running Tests

Open the project in Xcode and press **Cmd+U**, or run the `Tests` scheme.

## Project Structure

```
TemplateDaddy/
├── Source/                  # App source (synced folder)
│   ├── TemplateDaddyApp.swift
│   ├── Navigation/          # AppDestination + AppRouter
│   ├── Components/          # Reusable views (AppToolbar, SheetToolbar)
│   └── Services/            # ServiceProvider (DI container)
├── Tests/                   # Unit tests (Swift Testing)
├── scripts/                 # Shell scripts for scaffolding
├── project.yml              # XcodeGen project spec
└── Makefile                 # Development commands
```

## Architecture

- **Scenes** follow a Coordinator / ViewModel / View pattern. The coordinator owns the view model and wires navigation; the view model holds state; the view renders UI.
- **Navigation** uses `AppDestination` (an enum of all routes) and `AppRouter` (maps destinations to views). Stack and sheet navigation are handled by the Navigation package.
- **Services** are initialized in `ServiceProvider`, an `@Observable` class injected into the SwiftUI environment. Views access services via `@Environment(ServiceProvider.self)`.
