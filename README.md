# Landing Page Xaraiés

Landing page premium para barcos hotéis, pesca esportiva e turismo ecológico no Pantanal.

## Deploy

Projeto preparado para deploy em VPS com Nginx.

### Preview local

```bash
./scripts/preview_local.sh
```

Abra `http://localhost:8080`.

### Produção na VPS

Com domínio:

```bash
./scripts/deploy_vps.sh root@72.61.63.197 seu-dominio.com.br
```

Sem domínio definido ainda, publique pelo IP/default server:

```bash
./scripts/deploy_vps.sh root@72.61.63.197
```

O deploy publica a landing em `/var/www/xaraies-landing`, instala/valida a configuração Nginx e recarrega o serviço. Depois que o DNS estiver apontando para a VPS, emita o SSL com Certbot conforme a mensagem final do script.
