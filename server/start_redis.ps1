# Get the directory where this script is located
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $SCRIPT_DIR

Write-Host "Starting Redis (foreground)..."

# Go into redis folder
Set-Location "redis"

# Run docker compose
docker compose -f docker-compose.yaml up