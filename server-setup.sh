#!/usr/bin/env bash
# server-setup.sh — One-time setup on a fresh Ubuntu/Debian Linux instance
# Run as root or with sudo: bash server-setup.sh

set -euo pipefail

DEPLOY_ROOT="/var/www/cfc"

echo "==> Installing Node 18 via NodeSource"
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

echo "==> Installing PM2 globally"
npm install -g pm2

echo "==> Installing Nginx"
apt-get install -y nginx

echo "==> Creating deploy directories"
mkdir -p "$DEPLOY_ROOT/client-first-backend"
mkdir -p "$DEPLOY_ROOT/admin-dist"

echo "==> Installing Nginx site config"
cp nginx/cfc.conf /etc/nginx/sites-available/cfc.conf
ln -sf /etc/nginx/sites-available/cfc.conf /etc/nginx/sites-enabled/cfc.conf
rm -f /etc/nginx/sites-enabled/default
nginx -t
systemctl enable nginx
systemctl start nginx

echo "==> Configuring PM2 startup on boot"
pm2 startup systemd -u "$SUDO_USER" --hp "/home/$SUDO_USER"

echo ""
echo "✓ Server ready. Now:"
echo "  1. Clone your repo to the server"
echo "  2. Copy .env into client-first-backend/"
echo "  3. Run: bash deploy.sh"
