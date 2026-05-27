# Client Activation Checklist

Use this checklist after a client says yes and before/during their first-day onboarding.

## 1. Before sending the activation link

- Confirm the client slug
  - Example: `anne-fonseca`
- Confirm the agent host
  - Example: `sloane.mindvaultstudio.net`
- Confirm the shared portal URL pattern works:
  - `https://portal.mindvaultstudio.net/?client=<slug>&agent=<agent-host>`
- Confirm the activation page URL pattern works:
  - `https://portal.mindvaultstudio.net/activate.html?client=<slug>&agent=<agent-host>`
- Confirm Clerk production login is healthy on the shared portal.
- Confirm Stripe setup and monthly payment links are live in `activate.html`.

## 2. Send the activation link

Send the client a personalized activation link:

- `https://portal.mindvaultstudio.net/activate.html?client=<slug>&agent=<agent-host>`

Explain the 3 steps:
- pay setup fee
- start monthly subscription
- create portal login

## 3. After setup payment succeeds

- Verify the one-time setup payment in Stripe.
- Mark the client as paid-for-setup in your ops notes.
- Confirm the client agent subdomain is ready and reachable.
- Prepare the personalized portal URL for support follow-up.

## 4. After monthly subscription starts

- Verify the recurring subscription is active in Stripe.
- Record the subscription start date.
- Record the billing amount and plan label.
- Note who to contact if payment fails later.

## 5. After Clerk sign-up completes

- Confirm the client can open:
  - personalized portal URL
  - personalized learn URL
  - agent host URL
- Confirm the client sees their personalized name on the sign-in gate/portal.
- Confirm they understand first-time sign-up vs returning sign-in.

## 6. Welcome handoff

Send a short follow-up that includes:
- portal URL
- learn URL
- agent URL
- support email
- reminder not to paste passwords or private keys into chat

## Example link set

### Anne Fonseca
- Activation: `https://portal.mindvaultstudio.net/activate.html?client=anne-fonseca&agent=sloane.mindvaultstudio.net`
- Portal: `https://portal.mindvaultstudio.net/?client=anne-fonseca&agent=sloane.mindvaultstudio.net`
- Learn: `https://learn.mindvaultstudio.net?client=anne-fonseca&agent=sloane.mindvaultstudio.net`

### Jane Mazerall
- Activation: `https://portal.mindvaultstudio.net/activate.html?client=jane-mazerall&agent=siena.mindvaultstudio.net`
- Portal: `https://portal.mindvaultstudio.net/?client=jane-mazerall&agent=siena.mindvaultstudio.net`
- Learn: `https://learn.mindvaultstudio.net?client=jane-mazerall&agent=siena.mindvaultstudio.net`
