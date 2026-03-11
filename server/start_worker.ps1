# Get the directory where this script is located
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $SCRIPT_DIR

Write-Host "Starting Celery Worker (foreground)..."

# Function to run celery
function Run-Celery($celeryPath) {
    & $celeryPath -A src.services.celery:celery_app worker --loglevel=info --pool=threads --without-gossip --without-mingle --without-heartbeat
}

# Try Poetry-managed environment first
$poetryExists = Get-Command poetry -ErrorAction SilentlyContinue

if ($poetryExists) {
    $poetryEnvPath = poetry env info -p 2>$null

    if ($poetryEnvPath) {
        $celeryPath = Join-Path $poetryEnvPath "Scripts\celery.exe"

        if (Test-Path $celeryPath) {
            Run-Celery $celeryPath
            exit $LASTEXITCODE
        }
    }
}

# Fallback to celery in PATH
$celeryGlobal = Get-Command celery -ErrorAction SilentlyContinue

if ($celeryGlobal) {
    Run-Celery $celeryGlobal.Source
    exit $LASTEXITCODE
}

Write-Host "Celery command not found. Activate your virtual environment or install dependencies."
exit 1