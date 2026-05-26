# MindVault Client Portal

Private client portal scaffold for MindVault personal-agent customers.

## Purpose

This becomes the client's home base:

- Open their personal agent
- Continue the 30-day Agent Quest
- View unlocked tools
- Request new custom tools
- Later: reports, automations, files, support, billing

## Current State

Static HTML prototype with Clerk-ready auth hooks.

Live deployment target options:

- `app.mindvaultstudio.net` for the shared portal
- `clientname.mindvaultstudio.net` for client-specific branded entry

The page detects client context from:

1. `?client=sloane&agent=sloane.mindvaultstudio.net`
2. subdomain, e.g. `sloane.mindvaultstudio.net`
3. fallback `demo`

It links training to:

`https://learn.mindvaultstudio.net?client=<client>&agent=<agent>`

## Clerk Setup Needed

1. Create Clerk app
2. Add allowed origins:
   - `https://app.mindvaultstudio.net`
   - `https://*.mindvaultstudio.net` if Clerk plan supports wildcard/subdomain strategy
   - local preview URL if testing
3. Copy publishable key
4. Set `CLERK_PUBLISHABLE_KEY` in `index.html` or inject during build/deployment

Current placeholder:

```js
const CLERK_PUBLISHABLE_KEY='';
```

## Future Backend Data Model

Clerk handles identity. App database should handle business data:

- organizations
- users
- agents
- lesson_progress
- unlocked_tools
- tool_requests
- automations
- support_requests

Recommended next stack:

- Clerk for auth/orgs
- Supabase Postgres or VPS Postgres for app data
- Cloudflare Pages or VPS tunnel for hosting

## Files

- `index.html` -- complete static portal prototype
