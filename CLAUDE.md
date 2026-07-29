# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

@AGENTS.md

The import above (`AGENTS.md`, which itself defers to `.github/copilot-instructions.md` and `docs/BOUNDARIES.md`) is the canonical short entry point: ownership boundaries, the validated command set, and PR-routing rules. Keep `AGENTS.md` short and ecosystem-neutral — put Claude-specific or longer-form guidance here instead. Everything below is the cross-repo "big picture" that those files assume but don't spell out.

## This checkout: the SFBV site

This particular checkout is not a generic starter fork — it's the live site for the **Société Française de Biologie du Vieillissement (SFBV)**, a French scientific society. It deploys as a GitHub Pages **project page**, repo `sfbvie/SFBVie`. **As of the 2026-07-29 session it's moving to a custom domain, `sfbvie.fr`** (the user bought the domain that session): `url: https://sfbvie.fr` and `baseurl:` (blank) in `_config.yml`, plus a root-level `CNAME` file (content: `sfbvie.fr`) that Jekyll copies into the build output — this is what tells GitHub Pages which custom domain to serve. Every internal link in this theme goes through Liquid's `relative_url`, so no page content needed touching; only `_config.yml` + the new `CNAME` file changed (confirmed via local build: nav links render as `/blog/` etc. with no `/SFBVie/` prefix). **DNS is the user's responsibility, not something this checkout can verify** — until the registrar's A/AAAA/CNAME records are set and GitHub's Pages custom-domain check passes, `https://sfbvie.fr` won't resolve to the site even though the repo config is correct; `https://sfbvie.github.io/SFBVie/` (the old `baseurl: /SFBVie` URL) will 404/misroute once this config ships, since paths are now root-relative. See the DNS records + GitHub-side steps given to the user in that session if this needs revisiting. (The previously-considered alternative — renaming the repo to `sfbvie.github.io` for an org root page — is moot now that a real custom domain is in play.)

Content was adapted from an association template (mission/groups/events/membership), not an academic portfolio, so several stock al-folio pages are deliberately unlinked (`nav: false`) rather than deleted: `cv.md` (personal-CV feature, disabled in `_config.yml` too), `teaching.md`, `repositories.md`, `publications.md` (no real bibliography yet), and `dropdown.md` (submenu demo). Content instead lives in `about.md` (mission/landing page), `_projects` (reframed as "groupes thématiques"), `_news` (announcements/events), `profiles.md` (repurposed as `bureau` at `/people/`, now populated with real board members — see 2026-07-26 session below), and two new pages: `ressources.md` (founding documents) and `adhesion.md` (membership).

### Deployment status (last checked 2026-07-26)

- Remote: `origin` → `https://github.com/sfbvie/SFBVie.git`, `main` pushed and up to date. `MichaelRera` was added as a collaborator on the org repo, but pushing still needs a per-machine auth step — see the "Pushing from a new machine" note below.
- **GitHub Pages is now live**: `curl -sS https://api.github.com/repos/sfbvie/SFBVie` returns `"has_pages": true`, and `https://sfbvie.github.io/SFBVie/` serves 200. The Pages-toggle blocker noted in earlier sessions is resolved.
- The repo's **default branch is still `gh-pages`, not `main`** (confirmed via the GitHub API) — unusual, and worth fixing in Settings → General → Default branch if it causes confused PRs/clones later. Left alone for now since it wasn't blocking anything. **Always edit source on `main`** — `gh-pages` is CI-built output only; do not hand-edit it (see the "Which branch to edit" note below, added after a session that briefly started editing on `gh-pages` by mistake).

#### Which branch to edit

`git status`/`git branch` can land you on `gh-pages` by default (see above). Before editing anything, confirm with `git branch --show-current` — if it says `gh-pages`, `git checkout main` first. `gh-pages` is only ever written by the `deploy.yml` GitHub Action; hand edits there are silently overwritten on the next push to `main` and never make it into `main`'s history.

#### Pushing from a new machine

A fresh dev machine/container has no cached GitHub credentials by default, so `git push` fails with `fatal: could not read Username`. The working flow (used successfully in the 2026-07-26 session): install/locate the `gh` CLI, then run `gh auth login --web` (needs `--web` explicitly — the harness's bash tool isn't a TTY, so plain `gh auth login` errors with "--web or --with-token required when not running interactively"). That prints a one-time code and opens the browser device flow; once `gh` reports "Logged in as ...", run `gh auth setup-git` so plain `git push`/`git pull` over HTTPS pick up the token, no separate credential-helper config needed.

### Privacy audit (2026-07-24)

Ran a full check for real personal data after the site went public. The founding/legal documents in `assets/pdf/` (statuts, dossier de reconnaissance, charte, programme) contain **no real names, addresses, or ID numbers** — they're early-draft templates with blank governance sections. The one real finding: stock al-folio starter demo content was still live (blog nav was enabled) and one demo post embedded a real third party's personal email as sample git-diff content. Remediated by removing all al-folio starter demo content wholesale rather than picking through it: `_posts/*` (all 30 stock posts), `__resources/` (the scratch source material, now fully migrated — see below), the Einstein CV/resume/bibliography placeholder data (`_data/cv.yml`, `assets/json/resume.json`, `assets/rendercv/`, `_bibliography/papers.bib` contents, and the now-pointless `jekyll_get_json`/`jsonresume` blocks in `_config.yml`), and `.github/workflows/render-cv.yml` (its only triggers were the files just deleted; left in place it would fail on every push). If real SFBV publications or CVs are added later, these features can be re-enabled from scratch rather than resurrected from stock data.

Outstanding TODOs before this is truly launch-ready:

- Real contact email (`sfbvie@services.cnrs.fr`), Bluesky (`https://bsky.app/profile/sfbvie.bsky.social`), and LinkedIn company page (`https://www.linkedin.com/company/sfbvie/`) are now set in `_data/socials.yml` / `about.md` / `adhesion.md` — the `TODO`/`example.org` placeholders from this note are resolved (2026-07-26 session). The RSS icon (`rss_icon`) was intentionally removed rather than filled in.
- GitHub Pages is enabled — see deployment-status note above.
- Removing all the stock demo posts changes what the visual-regression baseline expects on `/blog/`; `npm run test:visual:update` may still be needed to refresh Playwright snapshots (not run yet in any session — local rendering works on at least one dev machine now, see below, so this is doable next time UI changes need a visual-diff check).

### Local Jekyll rendering: machine-dependent

Whether `bundle`/`jekyll serve`/`jekyll build` work locally **depends on which machine you're on** — this is not a fixed repo-wide fact, so check fresh each session rather than trusting a past note:

- **That "earlier dev machine" is now confirmed working (2026-07-29 session), root cause fully diagnosed and fixed — plain `bundle`/`jekyll` both work now.** Ruby is apt-installed (`ruby3.2`, Ubuntu 24.04), and the project's `vendor/bundle/ruby/3.2.0` (~184M, gitignored, `BUNDLE_PATH: "vendor/bundle"` set in `.bundle/config`) already has every gem installed and satisfies the Gemfile — `bundle check` confirms this without needing `bundle install`. The blocker was `PATH` ordering: `/usr/local/bin/bundle`, `/usr/local/bin/bundler`, and `/usr/local/bin/jekyll` were stale root-owned wrapper scripts (dated Dec 2024, shebang `#!/usr/bin/ruby3.0` — that Ruby no longer existed on this box) left over from a `sudo gem install` under a since-removed Ruby 3.0, and `/usr/local/bin` precedes `/usr/bin` in `$PATH`, so the plain `bundle`/`jekyll` commands always hit the broken stub and failed with `cannot execute: required file not found`. **The user ran `sudo rm /usr/local/bin/{bundle,bundler,jekyll}` (2026-07-29) to delete the stale stubs**, and `bundle`/`jekyll` now resolve straight to the working apt-installed `/usr/bin/bundle` (bundler 4.0.6, matching this repo's Gemfile.lock `BUNDLED WITH`) with no path workaround needed. Confirmed working with bare commands: `bundle check`, `bundle exec jekyll build --baseurl /SFBVie`, `bundle exec jekyll serve --baseurl /SFBVie --port 4000` (verified via `curl -fsS http://127.0.0.1:4000/SFBVie/` → 200, and rendered HTML matched source changes). No package uninstall/reinstall was ever needed — the whole fix was deleting three stray files.
- One other earlier dev machine had an unreliable Ruby setup; the user asked to stop attempting local verification there and rely on the `deploy.yml` GitHub Actions pipeline instead (see git history around commit `7f6a39a` if that machine's setup is ever revisited — a different, less-diagnosed workaround than the one above).
- On the machine used in the 2026-07-26 session (Ruby 3.0.2, gems under `~/gems`), `bundle install` + `bundle exec jekyll serve --port 4000` worked fine and is the preferred way to verify changes (page content, image rendering, Liquid logic, tag/category links) before pushing — confirm with a plain HTTP request, e.g. `curl -fsS http://127.0.0.1:4000/SFBVie/blog/`.
- **Gemfile.lock is machine-specific here and must not be committed from a local session.** This machine's Ruby resolves several gems to older versions than the lockfile checked into `main` (e.g. `activesupport 7.0.10` vs `7.2.3.1`, `jekyll-sass-converter 2.2.0` vs `3.1.0`). Running `bundle install` rewrites `Gemfile.lock` to match locally installed gems every time. Always `git checkout -- Gemfile.lock` before any `git add`/`git commit` on this machine, or the commit will silently downgrade pins for every other environment (CI, other dev machines).
- `_config.yml` edits are **not** hot-reloaded by `jekyll serve --watch`; a config change requires killing and restarting the server for the new value to take effect (page/include/post edits do hot-reload).
- The `.codex/skills`/`.claude/skills` → `.agents/skills` symlinks trigger a harmless `** ERROR: directory is already being watched! **` from the `listen` gem on every serve/rebuild — cosmetic, ignore it.
- `test/integration_distill.sh` and `test/integration_comments.sh` both ran clean locally on this machine after the 2026-07-26 changes (see below) — a useful pre-push check whenever a change might affect the `2018-12-22-distill.md` / `2015-10-20-disqus-comments.md` / `2022-12-10-giscus-comments.md` posts, since those exact pages are asserted to exist by those scripts.

### Session log: bureau photos, groupes thématiques rewrite, content cleanup (2026-07-26)

Content-focused session (no gem/runtime changes), across several pushes to `main` (`20e78a0`..`71c079d`):

- **Bureau (`/people/`)**: added real photos (`assets/img/eric_gilson.jpg`, `isabelle_ader.png`, `michael_rera.jpg` — Michael's copied from his `michaelrera.github.io` repo's `prof_pic.jpg`) and Eric Gilson's bio (`_pages/about_gilson.md`). Order is Gilson → Ader → Rera; the inaccurate "Co-fondateur" credit was dropped from Rera's entry per his own correction.
- **Groupes thématiques (`_projects/*_groupe.md`)**: replaced the original 3 siloed groups with 6 non-siloed cross-cutting groups per Eric Gilson's review comment (mécanismes biologiques; mesure et trajectoires de santé/applications médicales; evolution et écologie; biologie des systèmes/modélisation/IA; philosophie et sociologie; formation/intégrité/science ouverte), each carrying his full keyword list. One typo in his source text was silently corrected: "défense de l'hôtel" → "défense de l'hôte" (host defense).
- **Actualités (`/blog/`) cleanup**:
  - Featured card swapped from the stock "a distill-style blog post" demo to the real Summer School announcement (`featured: true` moved between posts' front matter).
  - Removed the `external_sources` block from `_config.yml` entirely (al-folio's own Medium RSS feed + a Google Gemini press-release stub) — pure stock demo content, no CI dependency.
  - The three remaining al-folio sample posts (`2018-12-22-distill.md`, `2015-10-20-disqus-comments.md`, `2022-12-10-giscus-comments.md`) are hidden from the listing via a custom `hide_from_list: true` front-matter flag + a `where_exp` filter added in `_pages/blog.md`, **not deleted or unpublished** — `test/integration_distill.sh` and `test/integration_comments.sh` assert those exact generated pages exist, so removal/unpublishing would break CI. This is the pattern to reuse if more stock posts need hiding later.
  - `_config.yml`'s `blog_name`/`blog_description` (leftover `al-folio` / theme tagline) replaced with real SFBVie branding.
  - `display_tags`/`display_categories` (also `_config.yml`) replaced with real keywords now that the two real posts carry matching `tags`/`categories` front matter (`formation`, `senescence`, `evolution`, `ecologie`, `symbiose`, `colloque`; category `evenements`) — the old stock list (`formatting`, `images`, `math`, …) pointed at now-empty archive pages once the sample posts were hidden.
- **Contact/socials**: real address `sfbvie@services.cnrs.fr` set in `_data/socials.yml`, `about.md`, `adhesion.md` (was `contact@sfbv.example.org`). Real Bluesky/LinkedIn URLs set (see outstanding-TODOs update above). RSS icon (`rss_icon`) removed rather than resolved.
- **Nav wording**: "about" → "à propos" for consistency with the rest of the French-language nav (`actualités`, `groupes thématiques`, `ressources`, `adhésion`, `bureau`).
- **Asset audit**: no byte-identical duplicate files found in `assets/img`, but a batch of leftover al-folio stock demo assets are now unreferenced by any content since the privacy-audit post purge — `assets/img/2.jpg`-`12.jpg`, `prof_pic_color.png`, `assets/json/table_data.json`, `assets/jupyter/blog.ipynb`, `assets/audio/epicaly-short-113909.mp3`, `assets/video/pexels-engin-akyurt-*.mp4`. Flagged to the user but **not deleted** — no decision made yet on whether to clean these up.
- **Statuts document replaced**: `assets/pdf/statuts_sfbv.docx` was the early-draft placeholder (blank `[À compléter]` governance sections) noted in the privacy audit. The user dropped a finalized, signed version (real siège social address, full bureau/Conseil scientifique/AG structure, signed by Eric Gilson and Isabelle Ader, "Fait à Nice, le 8 juin 2026") in as a differently-named file; it was moved over the old filename so the existing `ressources.md` link needed no change. If more founding-document updates land as oddly-named drops in `assets/pdf/`, diff them against the current file before assuming they're just a rename (compare via `unzip -p file.docx word/document.xml`, since these are `.docx` not plain text).
- **Homepage "latest posts" still leaked a sample post.** The `/blog/` fix (hide_from_list flag) doesn't reach the homepage's separate `latest_posts.liquid` include (see the corrected override-policy bullet above) — it lists `site.posts` raw, so with `limit: 3` the newest sample post (giscus-comments, Dec 2022) filled the 3rd slot once the 2 real posts took the top 2. Fixed by lowering `about.md`'s `latest_posts.limit` to `2`, matching the current count of real posts. **This is a ticking time bomb**: publishing a 3rd real post without also raising the limit will silently resurface a sample post there. Whoever adds the next real post should bump `latest_posts.limit` back up at the same time.

## What this repo is

`al-folio` v1.x is a **thin Jekyll starter**, not a theme. It owns only: starter wiring (`Gemfile`, `_config.yml`, `_data/featured_plugins.yml`), example content (`_pages`, `_posts`, `_projects`, `_news`, `_teachings`, `_books`, `_bibliography`), docs (`docs/`), cross-gem integration tests (`test/integration_*.sh`), and visual/parity tests (`test/visual/`). **All runtime, layouts, includes, Sass, tags, filters, and feature JS live in versioned gems**, published independently on RubyGems. `docs/BOUNDARIES.md` is the authoritative area→gem ownership table.

The biggest recurring mistake is editing runtime here. If a change is layout/include/tag/filter/feature-behavior, it belongs in the owning gem (see routing below), not in this repo.

## The plugin ecosystem (read this before routing any change)

The `al-*` / `al_folio_*` gems are developed as **sibling repos on disk** at `~/Documents/dev/al-org/<repo>` (repo dir uses hyphens, e.g. `al-folio-core`; gem/plugin id uses underscores, e.g. `al_folio_core`). To test a gem fix against this site, point the `Gemfile` at it: `gem "al_folio_core", path: "../al-folio-core"` (or `git:`/`branch:`), then `bundle install`.

**`al_folio_core` is the hub.** `_config.yml` sets `theme: al_folio_core`; the gem ships every base `_layouts/*.liquid` and `_includes/*.liquid`, the base theme JS/CSS, and the `details`/`file_exists` tags + `hideCustomBibtex`/`remove_accents` filters. Crucially, its `_includes/plugins/*.liquid` are **thin wrappers that call custom Liquid tags defined by sibling gems**. So a feature renders only when _both_ (a) its gem is present in the plugin list, and (b) the relevant flag is on. The wrapper→tag→gem delegation map:

| Wrapper / call site       | Tag                                                 | Gem                                                                            |
| ------------------------- | --------------------------------------------------- | ------------------------------------------------------------------------------ |
| search assets             | `al_search_assets`                                  | `al_search` (Cmd-K ninja-keys palette; index built at build time from content) |
| comments                  | `al_comments`                                       | `al_comments` (Giscus + Disqus, front-matter gated)                            |
| cookie banner             | `al_cookie_styles` / `al_cookie_scripts`            | `al_cookie` (consent-mode gating of analytics)                                 |
| icon `<link>`s            | `al_icons_styles`                                   | `al_icons` (FontAwesome/Academicons/Scholar Icons from CDN)                    |
| analytics                 | `al_analytics_scripts`                              | `al_analytics` (GA/Cronitor/Pirsch/OpenPanel)                                  |
| math                      | `al_math_styles` / `al_math_scripts`                | `al_math` (MathJax, pseudocode.js, TikZJax)                                    |
| charts                    | `al_charts_scripts`                                 | `al_charts` (Mermaid/Chart.js/ECharts/Plotly/Vega/Leaflet/diff2html)           |
| image tools               | `al_img_tools_styles` / `al_img_tools_scripts`      | `al_img_tools` (zoom, lightbox, sliders, galleries)                            |
| newsletter                | `al_newsletter_form` / `al_newsletter_scripts`      | `al_newsletter` (Loops.so signup)                                              |
| `layout: cv`              | `al_folio_cv_render`                                | `al_folio_cv` (RenderCV YAML + JSONResume)                                     |
| `layout: distill`         | `al_folio_distill_render`                           | `al_folio_distill` (vendored, hash-pinned distillpub runtime)                  |
| citation badges           | `google_scholar_citations` / `inspirehep_citations` | `al_citations`                                                                 |
| external posts            | (generator, no tag)                                 | `al_ext_posts` (RSS/URL ingestion → synthetic posts)                           |
| legacy Bootstrap behavior | (opt-in assets)                                     | `al_folio_bootstrap_compat`                                                    |
| upgrade/audit CLI         | `bundle exec al-folio …`                            | `al_folio_upgrade`                                                             |

Architectural facts that span repos:

- **Feature gating is two-layered.** Site-wide config flags (`search_enabled`, `enable_math`, `enable_cookie_consent`, `enable_darkmode`, `al_folio.features.cv.enabled`, `al_folio.features.distill.enabled`) _and_ per-page front matter (`images:`, `tikzjax`, `chart.*`, `mermaid.*`, `giscus_comments`, `layout: distill|cv`). A tag emits an empty string when its gem/flag/config is absent — features fail silently, not loudly.
- **Most feature gems are `AssetsGenerator`s** that inject their JS/CSS as Jekyll static files at build time _only when enabled_. These assets are not committed into the site, and several use pinned-CDN URLs + SRI hashes read from `_config.yml`'s `third_party_libraries:` block.
- **Two parallel lists must stay in sync:** `Gemfile` (pinned versions, e.g. `al_folio_core '= 1.0.9'`) and `_config.yml`'s `plugins:` list. Adding/removing a plugin means editing both.
- **The v1 config contract** (`al_folio.api_version: 1`, `style_engine: tailwind`, `tailwind.{version,css_entry,preflight}`, `distill.{engine,source}`) is enforced twice: as build-time warnings/violations by `al_folio_core`'s `:after_init` hook, and as **blocking** findings by `al-folio upgrade audit`. Don't remove these keys.
- **Local overrides are allowed but tracked — except in this checkout.** The general al-folio policy is that a site may shadow a gem-owned `_layouts/_includes/_sass` file locally, tracked via `.al-folio-overrides.yml`. **This repo's `test/style_contract.js` does not implement that exception**: it hard-fails (`exists("_includes")` etc., no allowlist) the instant a starter-owned `_includes`/`_layouts`/`_sass` directory exists at all, checked and confirmed 2026-07-26. So in this checkout specifically, don't create `_includes`/`_layouts`/`_sass` to override a gem file, even one registered in `.al-folio-overrides.yml` — find a starter-owned lever instead (page front matter, `_config.yml`, post front matter), or accept the limitation and document it. Example: `latest_posts.liquid` (`al_folio_core`) lists `site.posts` with no per-post exclusion hook; see the 2026-07-26 session log below for the front-matter-only workaround used instead of shadowing that include.
- **Bootstrap compat is opt-in and time-boxed.** `al_folio.compat.bootstrap.enabled: true` (default false) activates `al_folio_bootstrap_compat`. Supported through v1.2, deprecated v1.3, removed in v2.0 — migrate content off `data-toggle`/Bootstrap classes before then.

## Daily dev loop (not in the AGENTS.md command set)

```bash
bundle install                                # ruby gems
bundle exec jekyll serve                      # dev server → http://localhost:4000/al-folio/  (NOTE baseurl)
bundle exec jekyll build --baseurl /al-folio  # production-style build to _site/
bash test/integration_distill.sh             # run ONE integration test (any of the five)
npm run test:visual:update                    # refresh playwright snapshots after intentional UI change
bundle exec al-folio upgrade apply --safe     # deterministic codemods (font-weight-* → font-*, remote→local URLs)
bundle exec al-folio upgrade overrides diff <path>    # then `overrides accept <path>` to acknowledge an override
```

`bin/setup-python-deps` installs the optional Python toolchain in `requirements.txt` (`nbconvert` for `jekyll-jupyter-notebook`, `rendercv[full]` for CV rendering, `scholarly` for `bin/update_scholar_citations.py`). Responsive-image generation (`imagemagick.enabled: true`) needs ImageMagick `convert` on PATH. `bin/deploy` is the manual `gh-pages` build+purgecss+force-push path (CI normally deploys).

## Docker serving model (v1-specific)

`docker compose up -d` bind-mounts the repo to `/srv/jekyll` and runs `bin/entry_point.sh`, which serves with `--force_polling --destination /tmp/_site`. The build output deliberately goes to **container-local `/tmp/_site`, not the bind-mounted `_site`** — writing `_site` back across the host bind mount caused write deadlocks. The container also `inotifywait`s `_config.yml` and restarts Jekyll on change (config edits aren't hot-reloaded by `--watch`). Verify with the `/al-folio` baseurl: `curl -fsS http://127.0.0.1:8080/al-folio/`. `docker-compose-slim.yml` pulls a prebuilt `:slim` image instead of building locally.

## CI gates and the style contract

`npm run lint:style-contract` (`test/style_contract.js`) is the automated enforcement of the thin-starter boundary, and it will fail CI if you cross it: the starter must **not** define `build:css`/`build:tailwind` npm scripts, must **not** own `_includes`/`_layouts`/`_sass`/`_scripts`/`assets/tailwind`/`tailwind.config.js`/icon-font artifacts, must keep `theme: al_folio_core` and the required plugins in `_config.yml`, and must keep the `third_party_libraries` SRI pins and `al_math` Gemfile pin. Other gates: `unit-tests.yml` (style contract + the five integration scripts), `visual-regression.yml` (Playwright chromium+webkit, diffs candidate against a v0.16.3 baseline served on :4100 via `BASELINE_URL`), `upgrade-check.yml` (`al-folio upgrade audit`), `prettier.yml`. Prettier uses `@shopify/prettier-plugin-liquid` with `printWidth: 150`; run `npm run lint:prettier` before pushing.
