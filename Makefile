# OpenCost Helm Chart Makefile
# Provides targets for local development, testing, and CI validation

.PHONY: help lint lint-default lint-ci lint-all template template-ci validate-schema test-all clean

# Default target
help:
	@echo "OpenCost Helm Chart - Available targets:"
	@echo ""
	@echo "  make lint              - Lint chart with default values"
	@echo "  make lint-ci           - Lint chart with all CI test scenarios"
	@echo "  make lint-all          - Lint default + all CI scenarios"
	@echo "  make template          - Template chart with default values"
	@echo "  make template-ci       - Template chart with all CI scenarios"
	@echo "  make validate-schema   - Validate values.schema.json"
	@echo "  make test-all          - Run all tests (lint + template + schema)"
	@echo "  make clean             - Clean generated files"
	@echo ""

# Chart directory
CHART_DIR := charts/opencost
CI_DIR := $(CHART_DIR)/ci

# Find all CI values files
CI_FILES := $(wildcard $(CI_DIR)/*.yaml)
CI_FILES := $(filter-out $(CI_DIR)/README.md,$(CI_FILES))

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[1;33m
NC := \033[0m # No Color

# Lint chart with default values
lint-default:
	@echo "$(YELLOW)Linting chart with default values...$(NC)"
	@helm lint $(CHART_DIR) --strict
	@echo "$(GREEN)✓ Default values lint passed$(NC)"

# Lint chart with all CI scenarios
lint-ci:
	@echo "$(YELLOW)Linting chart with CI scenarios...$(NC)"
	@failed=0; \
	for file in $(CI_FILES); do \
		echo "  Testing $$(basename $$file)..."; \
		if helm lint $(CHART_DIR) -f $$file --strict > /dev/null 2>&1; then \
			echo "    $(GREEN)✓ PASSED$(NC)"; \
		else \
			echo "    $(RED)✗ FAILED$(NC)"; \
			helm lint $(CHART_DIR) -f $$file --strict; \
			failed=$$((failed + 1)); \
		fi; \
	done; \
	if [ $$failed -eq 0 ]; then \
		echo "$(GREEN)✓ All CI scenarios passed$(NC)"; \
	else \
		echo "$(RED)✗ $$failed scenario(s) failed$(NC)"; \
		exit 1; \
	fi

# Lint both default and CI scenarios
lint-all: lint-default lint-ci
	@echo "$(GREEN)✓ All linting passed$(NC)"

# Alias for lint-all
lint: lint-all

# Template chart with default values
template-default:
	@echo "$(YELLOW)Templating chart with default values...$(NC)"
	@helm template opencost $(CHART_DIR) > /dev/null
	@echo "$(GREEN)✓ Default template rendered successfully$(NC)"

# Template chart with all CI scenarios
template-ci:
	@echo "$(YELLOW)Templating chart with CI scenarios...$(NC)"
	@failed=0; \
	for file in $(CI_FILES); do \
		echo "  Templating $$(basename $$file)..."; \
		if helm template opencost $(CHART_DIR) -f $$file > /dev/null 2>&1; then \
			echo "    $(GREEN)✓ PASSED$(NC)"; \
		else \
			echo "    $(RED)✗ FAILED$(NC)"; \
			helm template opencost $(CHART_DIR) -f $$file; \
			failed=$$((failed + 1)); \
		fi; \
	done; \
	if [ $$failed -eq 0 ]; then \
		echo "$(GREEN)✓ All CI scenarios templated successfully$(NC)"; \
	else \
		echo "$(RED)✗ $$failed scenario(s) failed$(NC)"; \
		exit 1; \
	fi

# Template both default and CI scenarios
template: template-default template-ci
	@echo "$(GREEN)✓ All templating passed$(NC)"

# Validate JSON schema
validate-schema:
	@echo "$(YELLOW)Validating values.schema.json...$(NC)"
	@if command -v python3 > /dev/null 2>&1; then \
		python3 -m json.tool $(CHART_DIR)/values.schema.json > /dev/null && \
		echo "$(GREEN)✓ Schema is valid JSON$(NC)"; \
	else \
		echo "$(YELLOW)⚠ python3 not found, skipping schema validation$(NC)"; \
	fi

# Run all tests
test-all: validate-schema lint-all template
	@echo ""
	@echo "$(GREEN)========================================$(NC)"
	@echo "$(GREEN)✓ All tests passed!$(NC)"
	@echo "$(GREEN)========================================$(NC)"

# Clean generated files (if any)
clean:
	@echo "$(YELLOW)Cleaning generated files...$(NC)"
	@rm -f $(CHART_DIR)/*.tgz
	@echo "$(GREEN)✓ Clean complete$(NC)"

# Quick test (lint only, faster for iteration)
quick: lint-default
	@echo "$(GREEN)✓ Quick test passed$(NC)"

# List all CI test files
list-ci:
	@echo "CI test scenarios:"
	@for file in $(CI_FILES); do \
		echo "  - $$(basename $$file)"; \
	done