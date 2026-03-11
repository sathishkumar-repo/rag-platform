# =============================================================================
# STAGE 1: Builder
# =============================================================================
FROM python:3.11-slim AS builder

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libmagic-dev \
    libpoppler-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir poetry==2.3.2

COPY pyproject.toml poetry.lock* ./

RUN poetry config virtualenvs.in-project true && \
    poetry install --only=main --no-interaction --no-ansi --no-root

# ── STRIP TORCH + NVIDIA + CUDA ONLY ─────────────────────────────────────────
# We keep: unstructured-inference, onnxruntime, onnx, opencv
# These are hard imports in the unstructured-inference chain and must stay.
#
# We remove: torch, torchvision, triton, nvidia-*, cuda-*, timm, effdet
# These are only needed for hi_res (Detectron2) strategy which we don't use.
# Removing them saves ~7GB. onnxruntime (~48MB) stays — acceptable tradeoff.
RUN .venv/bin/pip uninstall -y \
        torch torchvision torchaudio triton \
        timm effdet pycocotools \
        accelerate \
        opencv-python \
        2>/dev/null || true && \
    # Dynamically remove all nvidia-* and cuda-* packages
    .venv/bin/pip list --format=freeze | grep -iE "^(nvidia|cuda)-" | \
        cut -d= -f1 | xargs -r .venv/bin/pip uninstall -y 2>/dev/null || true && \
    # Install headless OpenCV — identical API, no GUI/Qt deps
    .venv/bin/pip install --no-cache-dir opencv-python-headless && \
    # Hard-delete leftover dirs pip uninstall sometimes misses
    find .venv -type d -name "nvidia" -exec rm -rf {} + 2>/dev/null || true && \
    find .venv -type d -name "torch" -exec rm -rf {} + 2>/dev/null || true && \
    find .venv -type d -name "triton" -exec rm -rf {} + 2>/dev/null || true && \
    find .venv -name "*.dist-info" -path "*nvidia*" -exec rm -rf {} + 2>/dev/null || true && \
    .venv/bin/pip cache purge 2>/dev/null || true

# ── VERIFY ────────────────────────────────────────────────────────────────────
RUN echo "=== Checking torch is removed ===" && \
    ! .venv/bin/python -c "import torch" 2>/dev/null && \
    echo "✓ torch not present" && \
    echo "=== Checking critical imports ===" && \
    .venv/bin/python -c "from unstructured.partition.pdf import partition_pdf; print('✓ partition_pdf OK')" && \
    .venv/bin/python -c "from unstructured.partition.docx import partition_docx; print('✓ partition_docx OK')" && \
    .venv/bin/python -c "from unstructured.partition.pptx import partition_pptx; print('✓ partition_pptx OK')" && \
    .venv/bin/python -c "import cv2; print('✓ cv2 OK')" && \
    .venv/bin/python -c "import fastapi, celery, redis, langchain; print('✓ core stack OK')" && \
    echo "=== Final venv size ===" && \
    du -sh .venv

# =============================================================================
# STAGE 2: Runtime
# =============================================================================
FROM python:3.11-slim AS runtime

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    poppler-utils \
    tesseract-ocr \
    libmagic1 \
    libgl1 \
    libglib2.0-0 \
    libreoffice \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=builder /app/.venv /app/.venv

ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

COPY . .

EXPOSE 8000

CMD ["uvicorn", "src.server:app", "--host", "0.0.0.0", "--port", "8000"]