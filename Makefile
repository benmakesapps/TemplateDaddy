SCHEME        = TemplateDaddy
PROJECT       = TemplateDaddy.xcodeproj
CONFIGURATION = Debug
SIMULATOR     = platform=iOS Simulator,name=iPhone 16,OS=latest

.DEFAULT_GOAL := help

.PHONY: help generate open build clean bootstrap rename

# ── Help ──────────────────────────────────────────────────────────────────────

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

# ── Project ───────────────────────────────────────────────────────────────────

generate: ## Generate Xcode project from project.yml
	xcodegen generate --spec project.yml

open: generate ## Generate project and open in Xcode
	open $(PROJECT)

# ── Build ─────────────────────────────────────────────────────────────────────

build: ## Build for simulator
	xcodebuild \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-configuration $(CONFIGURATION) \
		-destination "$(SIMULATOR)" \
		build

# ── Maintenance ───────────────────────────────────────────────────────────────

clean: ## Remove generated Xcode project
	rm -rf $(PROJECT)

bootstrap: ## Install xcodegen if needed, then generate
	# Install xcodegen only if it isn't already available on PATH
	@command -v xcodegen >/dev/null || brew install xcodegen
	$(MAKE) generate

rename: ## Rename the project (usage: make rename NAME=MyNewApp)
	@bash scripts/rename.sh "$(NAME)"
