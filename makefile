# Makefile for Mihomo Podman Compose Project
# Alternative to justfile with traditional make syntax

# Load environment variables from .env file
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

# Default target - show help
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make update-geo   - Download/update Geo database files"
	@echo "  make update       - Update container images and restart services"
	@echo "  make up           - Start services (add ARGS for additional options)"
	@echo "  make down         - Stop services (add ARGS for additional options)"
	@echo "  make restart      - Restart services (add ARGS for additional options)"
	@echo "  make logs         - View service logs (add ARGS for additional options)"
	@echo ""
	@echo "Usage examples:"
	@echo "  make up ARGS=\"--build\"    # Start services with --build flag"
	@echo "  make logs ARGS=\"mihomo\"   # View logs for mihomo service only"

# Download/update Geo database files
.PHONY: update-geo
update-geo:
	@echo "Downloading Geo databases to ./mihomo/"
	wget -O ./mihomo/country.mmdb $(COUNTRY_MMDB_URL)
	wget -O ./mihomo/geoip.dat $(GEOIP_DAT_URL)
	wget -O ./mihomo/geosite.dat $(GEOSITE_DAT_URL)
	@echo "Geo files updated."

# Update container images
.PHONY: update
update:
	podman compose -f compose.yaml pull
	podman compose -f compose.yaml up -d --force-recreate

# Start services
.PHONY: up
up:
	podman compose -f compose.yaml up -d $(ARGS)

# Stop services
.PHONY: down
down:
	podman compose -f compose.yaml down $(ARGS)

# Restart services
.PHONY: restart
restart:
	podman compose -f compose.yaml restart $(ARGS)

# View logs
.PHONY: logs
logs:
	podman compose -f compose.yaml logs -f $(ARGS)
