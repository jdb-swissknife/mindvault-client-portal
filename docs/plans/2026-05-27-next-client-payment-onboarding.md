# Next-Client Payment + Onboarding Flow Implementation Plan

> For Hermes: use subagent-driven-development skill to implement this plan task-by-task.

Goal: create a repeatable onboarding flow for the next MindVault personal-agent client that collects an initial setup payment, starts a monthly subscription, and hands the client into Clerk-authenticated portal access.

Architecture: keep the first version static and low-friction. Use Stripe Payment Links for one-time setup and recurring subscription, a branded activation page in the existing client-portal repo, Clerk for account creation/login, and personalized query params for client/agent routing. Do not build backend provisioning yet; use a manual ops checklist after payment while validating the process with early clients.

Tech Stack: GitHub Pages static HTML, Stripe Payment Links, Clerk JavaScript frontend auth, Cloudflare DNS, existing MindVault client portal.

---

## Current state summary

- `portal.mindvaultstudio.net` now has working Clerk production auth.
- Personalized shared-portal URLs work, e.g. `?client=sue-bird&agent=isabella.mindvaultstudio.net`.
- `learn.mindvaultstudio.net` is still static and uses query params + localStorage.
- No backend exists yet for lesson progress, billing state, or automated provisioning.
- Existing Stripe reference pattern already exists in `/root/projects/mindvault-assess/index.html` using a static Stripe link and post-payment follow-up flow.

---

## Recommended client flow

1. Sales closes the client.
2. Client receives one personalized activation link.
3. Activation page walks them through:
   - pay setup fee (one-time)
   - start monthly subscription (recurring)
   - create portal login / sign in
4. Ops manually confirms both payments in Stripe.
5. Ops provisions agent profile, domain, and initial client context.
6. Client logs into portal and continues into learn site + agent.

Important first-version rule: do not block on backend automation. Build a clean front-end process and a manual provisioning checklist first.

---

## Task 1: Add a client activation page to the portal repo

Objective: create a branded static handoff page for new clients that explains the three-step activation flow.

Files:
- Create: `/root/projects/mindvault-client-portal/activate.html`
- Modify: `/root/projects/mindvault-client-portal/README.md`

Implementation details:
- Reuse MindVault styling patterns from `index.html`.
- Personalize from query params:
  - `client=anne-fonseca`
  - `agent=sloane.mindvaultstudio.net`
- Display a friendly title using prettified client name.
- Include three cards/steps:
  1. Pay setup fee
  2. Start monthly support subscription
  3. Create portal login / open portal
- Include support contact and a short “what happens next” section.
- Use constants near the top of the script for:
  - `SETUP_PAYMENT_URL`
  - `MONTHLY_SUBSCRIPTION_URL`
- Link the portal CTA to:
  - `https://portal.mindvaultstudio.net/?client=<client>&agent=<agent>`

Verification:
- Open `activate.html?client=anne-fonseca&agent=sloane.mindvaultstudio.net`
- Confirm the client name personalizes correctly.
- Confirm the portal link resolves to the shared portal with client context.

Commit:
- `feat: add client activation handoff page`

---

## Task 2: Document the repeatable manual ops process

Objective: define the exact human checklist to run after a client pays.

Files:
- Create: `/root/projects/mindvault-client-portal/docs/client-activation-checklist.md`
- Modify: `/root/projects/mindvault-client-portal/README.md`

Checklist sections:
- Before sending activation link
  - create/confirm agent subdomain
  - confirm Clerk production is healthy
  - confirm Stripe links are live
- After setup payment
  - verify payment in Stripe
  - create or verify client agent URL
  - prepare personalized portal URL
- After monthly subscription starts
  - verify recurring subscription in Stripe
  - send welcome email with activation + support instructions
- After Clerk sign-up
  - confirm client can access portal
  - confirm learn link opens with client context

Verification:
- Checklist should be usable by a non-developer operator with no additional context.

Commit:
- `docs: add client activation checklist`

---

## Task 3: Replace placeholder Stripe URLs with real payment links

Objective: wire the activation page to real Stripe checkout links once created.

Files:
- Modify: `/root/projects/mindvault-client-portal/activate.html`

Implementation details:
- Create one Stripe Payment Link for one-time setup.
- Create one Stripe recurring Payment Link for monthly support.
- Paste those links into the activation page constants.
- If helpful, append `client_reference_id`-style metadata via query params or separate tracking notes outside Stripe if Payment Links don’t support the same structure needed.

Verification:
- Setup button opens Stripe one-time payment page.
- Monthly button opens Stripe recurring payment page.

Commit:
- `feat: wire activation page to live Stripe links`

---

## Task 4: Create the first reusable client-link pattern

Objective: standardize the personalized URL format for future ops.

Files:
- Modify: `/root/projects/mindvault-client-portal/docs/client-activation-checklist.md`
- Optional create: `/root/projects/mindvault-client-portal/docs/client-link-template.md`

Link patterns:
- Activation page:
  - `https://portal.mindvaultstudio.net/activate.html?client=<slug>&agent=<agent-host>`
- Portal page:
  - `https://portal.mindvaultstudio.net/?client=<slug>&agent=<agent-host>`
- Learn page:
  - `https://learn.mindvaultstudio.net?client=<slug>&agent=<agent-host>`

Verification:
- Generate examples for Anne Fonseca and Jane Mazerall.

Commit:
- `docs: standardize client onboarding link patterns`

---

## Task 5: Define the backend phase without implementing it yet

Objective: capture the minimum backend needed once week-one testing validates demand and client behavior.

Files:
- Create: `/root/projects/mindvault-client-portal/docs/backend-phase-outline.md`

Include:
- Stripe webhook events to store later:
  - setup payment succeeded
  - subscription created
  - invoice paid
  - payment failed
  - subscription canceled
- Clerk user mapping
- Client table
- Agent table
- Billing status table
- Lesson progress table
- Provisioning queue/job concept

Verification:
- Document clearly what remains manual now vs what will become automated later.

Commit:
- `docs: outline backend phase for billing and provisioning`

---

## Recommended implementation order for this week

1. Build `activate.html`
2. Add manual ops checklist
3. Test with 2-3 clients manually
4. Observe friction points
5. Only then create backend/webhook automation plan in more depth

---

## First implementation slice to do now

Implement Task 1 and Task 2 immediately.

Reason:
- They create a real repeatable process for the next clients.
- They do not require backend.
- They let MindVault validate the commercial flow before investing in subscription automation.

---

## Acceptance criteria

- There is a clean branded activation page in the live portal repo.
- It supports personalized `client` and `agent` query params.
- It points to setup payment, monthly subscription, and portal login as three explicit steps.
- There is a written ops checklist for internal use.
- Anne and Jane can each be given a deterministic activation URL once Stripe links are inserted.
