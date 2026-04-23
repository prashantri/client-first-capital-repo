#!/usr/bin/env bash
# deploy.sh — Build and restart Client First Capital on the Linux server
# Run as: bash deploy.sh
# Expects: Node 18+, PM2, Nginx already installed

set -euo pipefail

DEPLOY_ROOT="/var/www/cfc"
ADMIN_DIST="$DEPLOY_ROOT/admin-dist"
BACKEND_DIR="$DEPLOY_ROOT/client-first-backend"

echo "==> Pulling latest code"
git pull origin main

# ─── Backend ──────────────────────────────────────────────────────────────────
echo "==> Building backend"
cd client-first-backend
npm ci                 # install ALL deps — nest CLI is a devDependency, needed for build
npm run build          # nest build → outputs to dist/

echo "==> Deploying backend to $BACKEND_DIR"
mkdir -p "$BACKEND_DIR"
rsync -a --delete dist/ "$BACKEND_DIR/dist/"
cp package.json package-lock.json "$BACKEND_DIR/"

# Copy .env — manage this file directly on the server for production secrets
[ -f .env ] && cp .env "$BACKEND_DIR/.env"

cd "$BACKEND_DIR"
npm ci --omit=dev      # install only production deps in the deploy directory

# ─── Admin Panel ──────────────────────────────────────────────────────────────
echo "==> Building admin panel"
cd -   # back to repo root
cd client-first-admin-panel
npm ci
npm run build          # outputs to dist/ with base=/admin

echo "==> Syncing admin build to $ADMIN_DIST"
rsync -a --delete dist/ "$ADMIN_DIST/"
cd -

# ─── PM2 ──────────────────────────────────────────────────────────────────────
echo "==> Restarting PM2 processes"
pm2 startOrRestart ecosystem.config.js --env production
pm2 save

# ─── Nginx ────────────────────────────────────────────────────────────────────
echo "==> Reloading Nginx"
sudo nginx -t && sudo systemctl reload nginx

echo ""
echo "✓ Deployment complete"
echo "  Admin panel : http://<your-server-ip>/admin"
echo "  API          : http://<your-server-ip>/api/v1"
