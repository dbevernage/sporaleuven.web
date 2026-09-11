import { defineCollection, z } from 'astro:content';
import { glob, file } from 'astro/loaders';

const news = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/news' }),
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    summary: z.string(),
  }),
});

const teams = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/teams' }),
  schema: z.object({
    name: z.string(),
    category: z.string(),
    verantwoordelijke: z.string(),
    trainingMoment: z.string(),
    wedstrijden: z.string(),
    competitie: z.string(),
    zaal: z.string(),
  }),
});

const gyms = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/gyms' }),
  schema: z.object({
    name: z.string(),
    address: z.string(),
    city: z.string(),
    notes: z.string(),
    mapsUrl: z.string().url(),
  }),
});

const games = defineCollection({
  loader: file('./src/content/games/games.json'),
  schema: z.object({
    id: z.string(),
    team: z.string(),
    opponent: z.string(),
    date: z.coerce.date(),
    time: z.string(),
    location: z.string(),
    homeOrAway: z.enum(['thuis', 'uit']),
  }),
});

export const collections = { news, teams, gyms, games };
