# Spora Leuven website

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

- `PUBLIC_UMAMI_WEBSITE_ID` (required): the Umami website identifier for the `sporaleuven.be` property
- `PUBLIC_UMAMI_SCRIPT_URL` (optional): overrides the default script URL of `https://cloud.umami.is/script.js`

The deploy workflow forwards these values into the Astro build. When `PUBLIC_UMAMI_WEBSITE_ID` is not configured, the tracking script is omitted entirely.
