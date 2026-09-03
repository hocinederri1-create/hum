# Movie Downloader

A local web app that finds, downloads and organizes movies on your computer —
exactly like the command-line script in `testfile.py.py`, but in your browser,
with a Netflix-style library, live progress, and 3 languages.

> `testfile.py.py` is **never touched** — all its logic was ported into the
> `backend/` folder as web services.

---

## What you get

- 🔍 **Search** — type a movie title, pick a release (720p/1080p only),
  confirm, and it starts downloading.
- ⬇️ **Downloads** — a live progress bar for every download, powered by a
  real-time stream between server and browser.
- 🎬 **Library** — every movie appears the moment its download starts.
  Click any movie to see its poster, plot, cast, director, rating and
  related movies.
- ⚙️ **Settings** — choose the folder where movies are saved, max parallel
  downloads, and max file size.
- 🌍 **Language** — English, Français, العربية (top-right corner).

## How to run it

1. Double-click **`run.bat`**.
2. Two small windows open (backend + frontend). Your browser opens:
   **http://127.0.0.1:5173**
3. Log in with the default account: **`admin` / `admin`**
4. Done. To stop everything, close the two small windows (or run `stop.bat`).

> First download installs a tiny portable download engine (`aria2c.exe`)
> automatically — internet needed once.

## Open it automatically every time you start Windows

Your computer already runs the app by itself at every login:

1. On startup, the website starts **by itself** (no terminal, no commands).
2. Your browser opens **http://127.0.0.1:5173** automatically a few seconds later.
3. Log in with `admin` / `admin` and you're done.

This is wired through your Windows **Startup** folder (a small shortcut named
`Movie-DL`). The launcher is *smart*: if the site is already running, it just
opens the browser and never starts a second copy.

**To stop everything:** double-click `stop.bat` (or end the two hidden
processes in Task Manager).

**To turn auto-start OFF:** open your Startup folder (Win+R, type
`shell:startup`, Enter) and delete the `Movie-DL` shortcut. You can still
launch it manually anytime with `run.bat`.

**Manual start:** double-click `run.bat` instead of waiting for Windows
(<kbd>Ctrl</kbd>+<kbd>C</kbd> in its windows stops the servers).

## Where movies are saved

Default folder: `D:\My TV\data\media\movies`

Each movie goes to its own folder `Title (Year)` with a single cleanly-named
video file inside, ready for a media server. You can change the folder anytime
in **Settings**.

## Change your password

Open `backend\.env` and edit:

```
APP_USERNAME=admin
APP_PASSWORD=admin
APP_TOKEN_SECRET=put-a-long-random-string-here
```

Save the file, then restart the app (`stop.bat`, then `run.bat`).

## Security features built in

| Priority | Protection |
|---|---|
| 1 | Login required (JWT in a secure HttpOnly cookie) |
| 2 | Path-traversal blocked — downloads can never escape the movies folder |
| 3 | No shell commands — the engine is driven through its daemon interface |
| 4 | Strict input validation (magnet format, titles, sizes) |
| 5 | SSRF guard — server only talks to approved endpoints + rate limiting |
| 6 | Disk-space check, file-size cap, max concurrent downloads |
| 7 | Secrets live in `.env`, never in code |
| 8 | XSS-safe rendering, SameSite=Strict cookie, origin check |

## Useful facts

- Backend (FastAPI): `http://127.0.0.1:8000` — public pages: `/docs`
- Web app (Vite): `http://127.0.0.1:5173` (auto-redirects API calls to 8000)
- The download engine downloads `aria2c.exe` into this folder on first use.
- Library history is stored in `backend\data\library.json`; delete it to reset.

## Rebuilding (only if you changed the code)

```
# Backend
cd backend
..\.venv\Scripts\pip install -r requirements.txt

# Frontend
cd frontend
npm install
npm run build        # type-check + production bundle
```