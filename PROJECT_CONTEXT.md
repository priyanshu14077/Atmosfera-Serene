# Atmosfera Serene — Project Context Memory

This document is a **living memory file** to keep all context of the project consistent across development. Update this file as new decisions are made.

- **PRD Link:** `https://drive.google.com/file/d/1ojK6slb-7Ec5EhMhkRw9zviOcQM5aCBx/view?usp=drive_link`

---

## Context Summary (Quick Reference)

- **App:** Atmosfera Serene — open-source air-quality dashboard (Next.js + Express + Prisma/Postgres).
- **Core:** Auth (NextAuth), OpenAQ data via backend proxy, DB caching (1h TTL), Leaflet map, Chart.js time-series, Prophet/ARIMA forecasting, CI/CD (Vercel/Railway/GitHub Actions).
- **Security:** Secrets via env only; OpenAQ key never exposed to frontend.
- **Testing:** Vitest, Supertest + Testcontainers, Playwright; mock forecasting in CI.
- **Open Questions:** NextAuth adapter persistence, forecast refresh cadence, multi-pollutant charts, staging env, geolocation default.

---

## 1. App Overview

- **Name:** Atmosfera Serene
- **Type:** Open-source air-quality dashboard.
- **Goal:** Allow users to authenticate, explore air quality data (from OpenAQ), visualize stations on a map, analyze time-series, and forecast future air quality trends.
- **Hosting:** Frontend on Vercel, backend on Railway.

---

## 2. Core Features (MVP)

1. **Authentication** — NextAuth.js (OAuth: Google, GitHub, Email).
2. **Data Fetch** — OpenAQ API v3 integration.
3. **Caching** — Prisma + PostgreSQL on Railway.
4. **Map Rendering** — Leaflet + React-Leaflet.
5. **Charts** — Chart.js (via react-chartjs-2) for pollutant time-series.
6. **Forecasting** — Prophet (Python) or ARIMA for short-term predictions.
7. **CI/CD** — Vercel (frontend), Railway (backend), GitHub Actions.

---

## 3. Tech Stack

- **Frontend:** Next.js 14 (App Router), React, TailwindCSS.
- **Auth:** NextAuth.js with secure cookies & OAuth providers.
- **Backend:** Express.js (Node), Prisma ORM, PostgreSQL.
- **Data:** OpenAQ API (proxied through backend for security).
- **Visualization:** React-Leaflet (map), Chart.js (charts).
- **Forecasting:** Python service (Prophet/ARIMA).
- **Infrastructure:** Vercel + Railway, GitHub CI/CD.

---

## 4. Architecture

- **Frontend:** Handles UI, authentication (NextAuth), fetches data from backend.
- **Backend:** Provides authenticated APIs, manages caching, runs forecasting.
- **Database:** PostgreSQL via Prisma for caching stations + measurements.
- **Forecasting Service:** Python (standalone or child_process from Node).
- **Data Flow:**

  - User logs in (NextAuth).
  - Frontend requests measurements/forecast → Backend.
  - Backend validates session → fetch from DB (or OpenAQ if stale) → cache + return.
  - Forecasting runs via Python on demand or scheduled.
  - Frontend renders map + charts with returned data.

---

## 5. Environment & Config

- **Frontend (Vercel):**

  - NEXTAUTH_SECRET
  - NEXTAUTH_URL
  - GOOGLE_ID, GOOGLE_SECRET (OAuth)

- **Backend (Railway):**

  - DATABASE_URL (Postgres)
  - OPENAQ_API_KEY
  - NEXTAUTH_SECRET (if session verification needed)

- **Forecasting:**

  - DATABASE_URL (for Python service)

---

## 6. Security & Privacy

- All secrets stored in Vercel/Railway environment settings.
- HTTPS enforced.
- OpenAQ key never exposed to frontend.
- PII-free: only environmental data handled.

---

## 7. Testing Strategy

- **Unit:** Vitest for utils.
- **Integration:** Supertest (Express), Testcontainers (Postgres).
- **E2E:** Playwright (auth → dashboard → charts).
- **Forecasting:** Mock Prophet/ARIMA in CI for speed.

---

## 8. Open Questions (to revisit)

1. Should user profiles be persisted in Postgres (via NextAuth adapter) or session-only?
2. How often should forecasts refresh (nightly batch vs. on-demand)?
3. Do we support multiple pollutants in one chart, or one pollutant per chart?
4. Should staging env mirror production before release?
5. Do we eventually add geolocation-based personalization (map centers on user)?

---

## 9. Next Steps

- Scaffold authentication flow with NextAuth.js.
- Define Prisma schema (Station, Measurement).
- Build Express endpoints for `/measurements` and `/forecast`.
- Integrate Leaflet map with sample markers.
- Add Chart.js time-series with mock data before API wiring.
- Setup CI/CD workflows (GitHub Actions → Vercel/Railway).

---

# End of Project Context Memory
