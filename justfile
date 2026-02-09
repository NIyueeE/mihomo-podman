default:
    @just --list

set dotenv-load := true

# Download/update Geo database files
update-geo:
    @echo "Downloading Geo databases to ./mihomo/"
    wget -O ./mihomo/country.mmdb {{env_var('COUNTRY_MMDB_URL')}}
    wget -O ./mihomo/geoip.dat {{env_var('GEOIP_DAT_URL')}}
    wget -O ./mihomo/geosite.dat {{env_var('GEOSITE_DAT_URL')}}
    @echo "Geo files updated."

# Update container images
update:
    podman-compose -f compose.yaml pull
    podman-compose -f compose.yaml up -d --force-recreate

# Start services
up *args:
    podman-compose -f compose.yaml up -d {{args}}

# Stop services
down *args:
    podman-compose -f compose.yaml down {{args}}

# Restart services
restart *args:
    podman-compose -f compose.yaml restart {{args}}

# View logs
logs *args:
    podman-compose -f compose.yaml logs -f {{args}}