#!/usr/bin/env bash
# deploy.sh — Build and restart Client First Capital on the Linux server
# Run as: bash deploy.sh  (from the repo root)
# Expects: Node 18+, PM2, Nginx already installed

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_ROOT="/var/www/cfc"
ADMIN_DIST="$DEPLOY_ROOT/admin-dist"
BACKEND_DIR="$DEPLOY_ROOT/client-first-backend"

echo "==> Repo root: $REPO_ROOT"

echo "==> Pulling latest code"
cd "$REPO_ROOT"
git pull origin main

# ─── Backend ──────────────────────────────────────────────────────────────────
echo "==> Building backend"
cd "$REPO_ROOT/client-first-backend"
npm ci                  # install ALL deps — @nestjs/cli is a devDependency, needed for build
npm run build           # nest build → outputs to dist/

echo "==> Deploying backend to $BACKEND_DIR"
mkdir -p "$BACKEND_DIR"
rsync -a --delete dist/ "$BACKEND_DIR/dist/"
cp package.json package-lock.json "$BACKEND_DIR/"

# .env lives permanently on the server — only copy if present in repo (local dev)
[ -f .env ] && cp .env "$BACKEND_DIR/.env"

cd "$BACKEND_DIR"
npm ci --omit=dev       # install only production deps in the deploy directory

# ─── Admin Panel ──────────────────────────────────────────────────────────────
echo "==> Building admin panel"
cd "$REPO_ROOT/client-first-admin-panel"
npm ci
npm run build           # Vite outputs to dist/ with base=/admin

echo "==> Syncing admin build to $ADMIN_DIST"
mkdir -p "$ADMIN_DIST"
rsync -a --delete dist/ "$ADMIN_DIST/"

# ─── PM2 ──────────────────────────────────────────────────────────────────────
echo "==> Restarting PM2 processes"
cd "$REPO_ROOT"
pm2 startOrRestart ecosystem.config.js --env production
pm2 save

# ─── Nginx ────────────────────────────────────────────────────────────────────
echo "==> Reloading Nginx"
sudo nginx -t && sudo systemctl reload nginx

echo ""
echo "✓ Deployment complete"
echo "  Admin panel : http://<your-server-ip>/admin"
echo "  API          : http://<your-server-ip>/api/v1"
