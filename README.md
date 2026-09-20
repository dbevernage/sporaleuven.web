# Spora Leuven website

## Technical documentation

GitHub Wiki-style technical documentation is available in [`/wiki/Home.md`](wiki/Home.md).

## Commands

All commands are run from the repository root:

| Command         | Action                                  |
| :-------------- | :-------------------------------------- |
| `npm install`   | Install dependencies                    |
| `npm run dev`   | Start the local Astro development server |
| `npm run build` | Build the production site into `dist/`  |
| `npm run preview` | Preview the production build locally  |

## Visitor analytics

This site uses a centralized [Umami](https://umami.is/) script include in `/src/components/Analytics.astro`, which is mounted once from `/src/layouts/BaseLayout.astro` so every page is tracked consistently.

The public Umami configuration is centralized in `/src/consts.ts`, which reads:

- `UMAMI_WEBSITE_ID`: the configured Umami website identifier
- `PUBLIC_UMAMI_SCRIPT_URL` (optional): overrides the default script URL of `https://cloud.umami.is/script.js`

The deploy workflow forwards Umami-related values into the Astro build. The current site code consumes the optional script URL override and keeps the website identifier in source control.
