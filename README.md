# Xaraiés Barco-Hotel

Versão aprovada em 13/11/2026, com menu móvel, contraste reforçado, tipografia ajustada, comparação da frota e formulário com validação.

Site estático em HTML, CSS e JavaScript. As fotos e os textos da versão aprovada foram preservados. As fontes estão incluídas em `fonts/`, sem dependências de fontes externas. O formulário abre o WhatsApp da Xaraiés com o período, a quantidade de pessoas e o interesse informados pelo visitante.

## Prévia local

Na pasta do repositório:

```sh
python -m http.server 8080 --bind 127.0.0.1
```

Abra `http://127.0.0.1:8080`. Em sistemas com `python3`, também é possível executar `./scripts/preview_local.sh`.

## Publicação na Hostinger

Domínio de destino: `https://xaraies.arbtechinfo.online/`.

Envie à pasta pública do subdomínio somente:

- `index.html`, `original.css`, `melhorias.css`, `fonts.css` e `site.js`;
- as pastas `images/` e `fonts/`;
- `robots.txt` e `health`.

`original.css` contém a base visual usada pela versão aprovada; `melhorias.css` contém os refinamentos. Ambos são necessários.

O envio de um commit ao GitHub não comprova publicação na Hostinger. Verifique o domínio após o deploy e a atualização do cache.

## VPS com Nginx

O script opcional `scripts/deploy_vps.sh` recebe o servidor e o domínio explicitamente. Ele instala dependências e altera a configuração do servidor: execute somente ao escolher esse tipo de hospedagem e autorizar a operação. Não é necessário para hospedagem estática pelo gerenciador de arquivos da Hostinger.

## Verificação

- Menu móvel abre e fecha; links chegam às seções corretas.
- Fotos e fontes locais carregam.
- Campos obrigatórios exibem mensagens de validação.
- Consulta monta o pedido no WhatsApp; o visitante decide se envia a mensagem.
- `/health` responde `ok` após a publicação dos arquivos.
