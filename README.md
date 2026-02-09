# Mihomo Podman
Deploy [Mihomo](https://github.com/MetaCubeX/mihomo) (proxy/VPN client) and the [Metacubexd](https://github.com/MetaCubeX/metacubexd) web dashboard using Podman Compose.
[中文](./README.中文.md)
## Quick Start
### Prerequisites
- Podman and Podman Compose installed
- Basic understanding of containers
- Permissions to configure networking (required for privileged mode)
### Basic Setup
1. **Configure Mihomo**
   - Replace `mihomo/config.yaml` with your own configuration file.
   - **Clash Verge Rev users**: You can export a configuration from Settings → Verge Advanced Setting → Runtime Config.
     - Make sure to set `external-controller` and `secret` appropriately; the dashboard needs them.
     - Update `external-controller-cors` `allow-origins` to the correct value.
2. **Update GeoIP/GeoSite databases**
   ```bash
   just update-geo
   # or
   make update-geo
   ```
3. **Start services**
   ```bash
   just up
   # or
   make up
   ```
4. **Access the web interface**
   - Open in your browser: http://localhost:9090
## Configuration
### Environment variables (`.env` file)
| Variable | Default | Description |
|----------|---------|-------------|
| `MIHOMO_REGISTRY` | `docker.io` | Mihomo image registry |
| `METACUBEXD_REGISTRY` | `docker.io` | Metacubexd image registry |
| `MIHOMO_TAG` | `latest` | Mihomo image tag |
| `METACUBEXD_TAG` | `latest` | Metacubexd image tag |
| `WEBUI_PORT` | `9090` | Web UI port |
| `COUNTRY_MMDB_URL` | MetaCubeX URL | Country database download URL |
| `GEOIP_DAT_URL` | MetaCubeX URL | GeoIP database download URL |
| `GEOSITE_DAT_URL` | MetaCubeX URL | Geosite database download URL |
### Services
**Mihomo service:**
- Uses `host` networking
- Runs in privileged mode to perform network operations
- Mounts `./mihomo` to `/root/.config/mihomo`
- Capabilities: `NET_ADMIN`, `SYS_MODULE`
**Metacubexd service:**
- Uses `bridge` networking
- Exposes port `9090` for web access
- Mounts `./metacubexd` to `/config/caddy` (create the directory if needed)
## Commands
### Just commands
```justfile
just update-geo    # Download/update GeoIP/Geosite databases
just up            # Start services
just down          # Stop services
just restart       # Restart services
just logs          # View service logs
just update        # Update container images and restart
```
### Make commands
```makefile
make update-geo    # Download/update GeoIP/Geosite databases
make up            # Start services
make down          # Stop services
make restart       # Restart services
make logs          # View service logs
make update        # Update container images and restart
```
## Customization
### Port configuration
Edit the `.env` file:
```bash
WEBUI_PORT=9091  # Change the Web UI port
```
### Image tags
Edit the `.env` file:
```bash
MIHOMO_TAG=v1.18.0        # Use a specific Mihomo version
METACUBEXD_TAG=v2.0.0     # Use a specific Metacubexd version
```
