#!/usr/bin/env bash
set -euo pipefail

# Uso:
#   ./scripts/deploy_vps.sh root@IP_DA_VPS SEU_DOMINIO.com.br
#
# Exemplo:
#   ./scripts/deploy_vps.sh root@123.123.123.123 lp.xaraies.com.br

SERVER="${1:-}"
DOMAIN="${2:-}"

if [ -z "$SERVER" ] || [ -z "$DOMAIN" ]; then
  echo "Uso: ./scripts/deploy_vps.sh root@IP_DA_VPS SEU_DOMINIO.com.br"
  exit 1
fi

SITE_DIR="/var/www/xaraies-landing"
TMP_CONF="/tmp/nginx-xaraies.conf"

echo "==> Enviando arquivos para $SERVER..."
ssh "$SERVER" "mkdir -p $SITE_DIR"
scp -r index.html assets "$SERVER:$SITE_DIR/" 2>/dev/null || scp index.html "$SERVER:$SITE_DIR/"

echo "==> Preparando configuração do Nginx..."
sed "s/SEU_DOMINIO.com.br/$DOMAIN/g" deploy/nginx-xaraies.conf > "$TMP_CONF"
scp "$TMP_CONF" "$SERVER:/tmp/xaraies-landing.conf"

echo "==> Instalando e configurando Nginx na VPS..."
ssh "$SERVER" "apt update && apt install -y nginx && cp /tmp/xaraies-landing.conf /etc/nginx/sites-available/xaraies-landing && ln -sf /etc/nginx/sites-available/xaraies-landing /etc/nginx/sites-enabled/xaraies-landing && nginx -t && systemctl reload nginx"

echo "==> Deploy HTTP concluído."
echo "Acesse: http://$DOMAIN"
echo ""
echo "Depois que o DNS do domínio já estiver apontando para a VPS, rode:"
echo "ssh $SERVER"
echo "apt install -y certbot python3-certbot-nginx"
echo "certbot --nginx -d $DOMAIN"
