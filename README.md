# Worship Viewer

A simple, self-hosted web app for displaying chord charts and sheet music on tablets during worship services. Designed for small churches that want a free, no-account-needed solution for getting chord sheets and sheet music onto iPads and tablets.

## Features

- **Page-turn mode** — tap left/right or swipe to navigate pages
- **Scroll mode** — continuous scroll through all pages with song dividers
- **Song picker** — drawer to jump between songs in a set
- **Multi-set support** — organize songs into worship sets by date
- **iPad optimized** — works in Safari with proper touch handling
- **Zero accounts** — no logins, no subscriptions, just drop PDFs and go
- **Docker deployment** — single container, bind-mounted content

## Quick Start

### Automated Setup

```bash
git clone https://github.com/boomertechie/worship-viewer.git
cd worship-viewer
bash setup.sh
```

This downloads PDF.js 2.16, creates the `pdfs/` directory, and sets up `sets.json` from the example template. Requires `curl` and `unzip`.

### Add your content

1. Drop your chord chart PDFs into `pdfs/`
2. Edit `sets.json` to list your worship sets:

```json
[
  {
    "date": "2026-03-30",
    "title": "Sunday Worship",
    "songs": [
      { "title": "Amazing Grace", "file": "amazing-grace.pdf" },
      { "title": "How Great Thou Art", "file": "how-great-thou-art.pdf" }
    ]
  }
]
```

### Run

**With Docker:**
```bash
docker compose up -d
```

**Without Docker (Python 3):**
```bash
python3 -m http.server 8580
```

Open `http://your-server:8580` on your tablets.

### Updating Content

Content updates require **zero rebuilds**:

1. Drop new PDFs into `pdfs/`
2. Edit `sets.json`
3. Refresh the browser

The `pdfs/` directory and `sets.json` are bind-mounted into the container.

## Configuration

### Customizing the look

Edit `index.html` to change:
- Church name in the title and footer
- Colors (header: `#12394F`, accent: `#577045`)
- Fonts (Bebas Neue + Poppins via Google Fonts)

### nginx

The included `nginx.conf` handles:
- `.mjs` MIME type (required for PDF.js)
- Cache headers for PDFs (`no-cache`) and sets (`no-store`)
- SPA fallback routing

## Browser Compatibility

| Browser | Status |
|---------|--------|
| iPad Safari (iOS 15+) | Primary target, fully tested |
| Chrome / Firefox / Edge | Works |
| Android Chrome | Works |
| Older iOS (< 15) | Should work (PDF.js 2.16 targets ES5) |

## Diagnostics

Open the browser console (F12) to access the built-in performance logger:

| Command | Description |
|---------|-------------|
| `WVLog.dump()` | Full state + render stats + recent log entries |
| `WVLog.errors()` | Warnings and errors only |
| `WVLog.stats('pageTurn')` | Page-turn render timing (avg, p50, p95) |
| `WVLog.stats('scrollPage')` | Scroll mode render timing |
| `WVLog.stats('pdfLoad')` | PDF download timing |

## Why PDF.js 2.16?

PDF.js versions 3+ use modern JavaScript features (private class fields, ES modules, top-level await) that break on iPad Safari — especially older models that churches are likely to use. Version 2.16 is the last release that works reliably across all tablet browsers using a simple `<script>` tag.

## License

MIT
