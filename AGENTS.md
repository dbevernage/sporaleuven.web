## Development

When starting the dev server, use background mode:

```
astro dev --background
```

Manage the background server with `astro dev stop`, `astro dev status`, and `astro dev logs`.

## Commits

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): short imperative summary
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`.

Scopes are optional and lowercase — typically a page, component, or area:
`history`, `calendar`, `teams`, `contact`, `nav`, `footer`, `analytics`, `content`, `iac`.

- Write the subject in English, imperative mood, lowercase after the colon, no trailing period, max 72 characters.
- Use the `ci` type for workflow changes instead of a `ci/cd` scope.
- Mark breaking changes with `!` before the colon: `feat(nav)!: drop legacy anchor links`.

Examples:

```
feat(history): add Spora-fuif photo album
fix(history): correct image path casing
chore(analytics): add Umami tracking id
ci: trigger deploy_release workflow on new GitHub release
docs: add wiki-style technical setup guide
```

Pull request titles use the same format. When a PR is squash-merged its title becomes
the commit subject on `master`, so the title is what has to be well-formed.

## Documentation

Full documentation: https://docs.astro.build

Consult these guides before working on related tasks:

- [Adding pages, dynamic routes, or middleware](https://docs.astro.build/en/guides/routing/)
- [Working with Astro components](https://docs.astro.build/en/basics/astro-components/)
- [Using React, Vue, Svelte, or other framework components](https://docs.astro.build/en/guides/framework-components/)
- [Adding or managing content](https://docs.astro.build/en/guides/content-collections/)
- [Adding styles or using Tailwind](https://docs.astro.build/en/guides/styling/)
- [Supporting multiple languages](https://docs.astro.build/en/guides/internationalization/)
