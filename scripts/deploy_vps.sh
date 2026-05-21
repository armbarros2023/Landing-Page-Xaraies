#!/usr/bin/env bash
set -euo pipefail

# Uso:
#   ./scripts/deploy_vps.sh root@IP_DA_VPS [dominio.com.br]
#
# Exemplo:
#   ./scripts/deploy_vps.sh root@123.123.123.123 lp.xaraies.com.br

SERVER="${1:-}"
DOMAIN="${2:-_}"

if [ -z "$SERVER" ]; then
  echo "Uso: ./scripts/deploy_vps.sh root@IP_DA_VPS [dominio.com.br]"
  exit 1
fi

SITE_DIR="/var/www/xaraies-landing"
TMP_DIR="/tmp/xaraies-landing-release"
TMP_CONF="/tmp/xaraies-landing.conf"

if [ "$DOMAIN" = "_" ]; then
  SERVER_NAMES="_"
else
  SERVER_NAMES="$DOMAIN www.$DOMAIN"
fi

echo "==> Validando arquivos locais..."
test -f index.html
if [ -d assets ]; then
  LOCAL_FILES=(index.html assets)
else
  LOCAL_FILES=(index.html)
fi

echo "==> Preparando configuração do Nginx..."
sed "s/__SERVER_NAMES__/$SERVER_NAMES/g" deploy/nginx-xaraies.conf > "$TMP_CONF"

echo "==> Instalando dependências e criando diretório na VPS..."
ssh "$SERVER" "apt-get update && apt-get install -y nginx rsync && mkdir -p '$TMP_DIR' '$SITE_DIR'"

echo "==> Enviando release para $SERVER..."
rsync -az --delete "${LOCAL_FILES[@]}" "$SERVER:$TMP_DIR/"
scp "$TMP_CONF" "$SERVER:/tmp/xaraies-landing.conf"

echo "==> Publicando release e recarregando Nginx..."
ssh "$SERVER" "rsync -a --delete '$TMP_DIR/' '$SITE_DIR/' && cp /tmp/xaraies-landing.conf /etc/nginx/sites-available/xaraies-landing && ln -sf /etc/nginx/sites-available/xaraies-landing /etc/nginx/sites-enabled/xaraies-landing && nginx -t && systemctl reload nginx"

echo "==> Deploy HTTP concluído."
if [ "$DOMAIN" = "_" ]; then
  echo "Acesse pelo IP da VPS ou pelo domínio apontado para ela."
else
  echo "Acesse: http://$DOMAIN"
fi
echo ""
if [ "$DOMAIN" != "_" ]; then
  echo "Depois que o DNS do domínio já estiver apontando para a VPS, rode:"
  echo "ssh $SERVER"
  echo "apt-get install -y certbot python3-certbot-nginx"
  echo "certbot --nginx -d $DOMAIN -d www.$DOMAIN"
fi
