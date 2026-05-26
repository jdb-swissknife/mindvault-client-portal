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

- `portal.mindvaultstudio.net` for the shared client portal (current CNAME target)
- `clientname.mindvaultstudio.net` for client-specific branded entry

Do not use `app.mindvaultstudio.net`; it is reserved for the home-service company app.

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

## Current Deploy

Repo: `jdb-swissknife/mindvault-client-portal`
GitHub Pages: `https://jdb-swissknife.github.io/mindvault-client-portal/`
Custom domain target: `portal.mindvaultstudio.net` (requires Cloudflare CNAME: `portal` -> `jdb-swissknife.github.io`, DNS-only)

Example personalized URL:

`https://jdb-swissknife.github.io/mindvault-client-portal/?client=sloane&agent=sloane.mindvaultstudio.net`

Important: `app.mindvaultstudio.net` appears to be in use by another MindVault app right now, so no custom CNAME is active on this repo yet.

## Agent Safety Thread

Agent safety should be woven through the whole client journey, not isolated at the end. Early lessons and portal copy should reinforce:

- Never paste passwords, credit card numbers, private keys, or login codes into chat
- If the agent needs access, ask it to guide a safe setup flow
- Prefer OAuth, API keys in config files, or managed integrations over typing secrets
- Client controls what tools/accounts are connected
- Agent actions should be reviewed before they affect money, contracts, customers, or production systems

## Files

- `index.html` -- complete static portal prototype
