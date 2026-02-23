# Get the directory where the script is located
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $SCRIPT_DIR

Write-Host "Starting the API server (Uvicorn)..."

# If using Poetry
poetry run uvicorn src.server:app --reload --host 0.0.0.0 --port 8000