#!/usr/bin/env bash
set -euo pipefail

PDFJS_URL="https://github.com/nicktehrani/pdfjs-2.16.105/archive/refs/heads/main.zip"
PDFJS_DIR="pdfjs"

echo "=== Worship Viewer Setup ==="
echo ""

# Check for required tools
for cmd in curl unzip; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: $cmd is required but not installed."
    exit 1
  fi
done

# Download PDF.js 2.16 if not present
if [ -d "$PDFJS_DIR/build" ] && [ -f "$PDFJS_DIR/build/pdf.js" ]; then
  echo "[OK] PDF.js 2.16 already present"
else
  echo "[..] Downloading PDF.js 2.16 legacy build..."
  curl -L -o pdfjs.zip "$PDFJS_URL"
  unzip -q pdfjs.zip
  rm -rf "$PDFJS_DIR"
  mv pdfjs-2.16.105-main "$PDFJS_DIR"
  rm pdfjs.zip
  echo "[OK] PDF.js 2.16 installed"
fi

# Create pdfs directory
mkdir -p pdfs

# Create sets.json from example if it doesn't exist
if [ ! -f sets.json ]; then
  cp sets.example.json sets.json
  echo "[OK] Created sets.json from example — edit this with your worship sets"
else
  echo "[OK] sets.json already exists"
fi

echo ""
echo "=== Setup complete ==="
echo ""
echo "Next steps:"
echo "  1. Drop your chord chart PDFs into pdfs/"
echo "  2. Edit sets.json to list your worship sets"
echo "  3. Run with Docker:  docker compose up -d"
echo "     Or without Docker: python3 -m http.server 8580"
echo ""
echo "Then open http://localhost:8580 in your browser."
