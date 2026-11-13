# Checklist de publicação

- [ ] Confirmar a pasta pública de `xaraies.arbtechinfo.online`.
- [ ] Testar a página localmente em desktop e celular.
- [ ] Enviar os arquivos e as pastas de publicação indicados no README.
- [ ] Confirmar que estilos, JavaScript, imagens e fontes retornam HTTP 200.
- [ ] Validar `/health` retornando `ok`.
- [ ] Confirmar HTTPS no domínio.
- [ ] Abrir e fechar o menu móvel, inclusive por teclado.
- [ ] Testar links de navegação e campos obrigatórios.
- [ ] Conferir o destino do WhatsApp sem enviar mensagem de teste automaticamente.
- [ ] Limpar o cache da hospedagem se a versão anterior continuar aparecendo.
- [ ] Conferir visualmente a página pública.

Para VPS com Nginx, a configuração fornecida é opcional. Confirme o servidor explicitamente, valide `nginx -t` e recarregue somente o serviço necessário. Não altere DNS quando o domínio já estiver corretamente conectado à hospedagem escolhida.
