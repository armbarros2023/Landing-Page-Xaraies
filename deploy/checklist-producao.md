# Checklist de produção

- [ ] Confirmar domínio/subdomínio final.
- [ ] Apontar DNS tipo A para o IP da VPS.
- [ ] Testar landing localmente.
- [ ] Rodar `./scripts/deploy_vps.sh root@72.61.63.197 dominio.com.br`.
- [ ] Confirmar `nginx -t` sem erros.
- [ ] Validar `/health` retornando `ok`.
- [ ] Confirmar HTTPS no domínio principal.
- [ ] Conferir headers básicos de segurança.
- [ ] Testar versão mobile.
- [ ] Testar botão de WhatsApp.
- [ ] Testar QR Code.
- [ ] Adicionar Google Tag Manager, Meta Pixel ou Google Analytics, se necessário.
- [ ] Configurar backup do projeto no GitHub.
