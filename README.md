# podman-antigravity-tools

Deploy [Antigravity Manager](https://hub.docker.com/r/lbjlaq/antigravity-manager) as a systemd user service using Podman Quadlet.

## Prerequisites

- Podman
- systemd

## Quick Start

```bash
chmod +x deploy.sh
./deploy.sh
```

The script will:

1. Pull the latest image
2. Install the Quadlet `.container` file to `~/.config/containers/systemd/`
3. Reload systemd
4. Start the service
5. Enable User Linger (keeps the service running when the user is not logged in)

## Configuration

Edit the environment variables in `antigravity-manager.container`:

```ini
Environment=LOG_LEVEL=info
Environment=API_KEY=your-secret-key
```

Re-run `./deploy.sh` after making changes.

## Service Management

```bash
# Check status
systemctl --user status antigravity-manager

# View logs
journalctl --user -u antigravity-manager -f

# Restart
systemctl --user restart antigravity-manager

# Stop
systemctl --user stop antigravity-manager

# Update to latest image
podman pull docker.io/lbjlaq/antigravity-manager:latest
systemctl --user restart antigravity-manager

# Clean up old images
podman image prune -f
```

## Files

| File | Description |
|------|-------------|
| `antigravity-manager.container` | Podman Quadlet container unit file |
| `deploy.sh` | Deployment script |
| `docker-compose.yaml` | Original Docker Compose file (for reference only) |
