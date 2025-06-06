# Website de Fornecedores da Indústria de Óleo e Gás no Rio de Janeiro

![Logo do Projeto](./src/assets/logo.png)

## Sobre o Projeto

Este projeto é um website completo para reunir informações sobre fornecedores da indústria de óleo e gás no estado do Rio de Janeiro. O objetivo é criar uma plataforma centralizada para consulta de contatos, produtos e serviços oferecidos por empresas do setor.

### Funcionalidades Principais

- 🔍 **Busca Avançada**: Encontre fornecedores por nome, produtos, serviços ou localização
- 📋 **Listagem Completa**: Visualize todos os fornecedores cadastrados com filtros personalizáveis
- 📄 **Informações Detalhadas**: Acesse dados completos sobre cada fornecedor
- 📱 **Design Responsivo**: Experiência otimizada para dispositivos móveis e desktop
- 🌐 **Suporte Multi-idiomas**: Disponível em Português e Inglês

## Tecnologias Utilizadas

- **React**: Biblioteca JavaScript para construção de interfaces
- **React Router**: Gerenciamento de rotas e navegação
- **Vite**: Build tool e servidor de desenvolvimento
- **CSS Personalizado**: Estilos customizados para uma experiência única

## Pré-requisitos

- Node.js (versão 16 ou superior)
- pnpm (recomendado) ou npm

## Instalação e Execução

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/oil-gas-suppliers-app.git
   cd oil-gas-suppliers-app
   ```

2. Instale as dependências:
   ```bash
   pnpm install
   ```

3. Inicie o servidor de desenvolvimento:
   ```bash
   pnpm run dev
   ```

4. Acesse o website no navegador:
   ```
   http://localhost:5173
   ```

## Estrutura do Projeto

```
oil-gas-suppliers-app/
├── public/                 # Arquivos públicos estáticos
├── src/                    # Código-fonte da aplicação
│   ├── assets/             # Recursos estáticos (imagens, ícones)
│   ├── components/         # Componentes reutilizáveis
│   │   ├── layout/         # Componentes de layout (Header, Footer)
│   │   ├── suppliers/      # Componentes relacionados a fornecedores
│   │   └── ui/             # Componentes de interface do usuário
│   ├── data/               # Dados da aplicação
│   ├── pages/              # Páginas da aplicação
│   ├── App.css             # Estilos globais da aplicação
│   ├── App.jsx             # Componente principal da aplicação
│   ├── index.css           # Estilos de inicialização
│   └── main.jsx            # Ponto de entrada da aplicação
├── .gitignore              # Arquivos ignorados pelo Git
├── index.html              # Arquivo HTML principal
├── package.json            # Dependências e scripts do projeto
├── vite.config.js          # Configuração do Vite (bundler)
└── README.md               # Esta documentação
```

## Build para Produção

Para gerar uma build de produção:

```bash
pnpm run build
```

Os arquivos otimizados serão gerados na pasta `dist/`.

## Hospedagem

Este projeto pode ser hospedado em diversas plataformas:

- **Microsoft Azure**: Recomendado para ambientes corporativos
- **Netlify**: Fácil implantação com integração contínua
- **Vercel**: Excelente para projetos React
- **GitHub Pages**: Opção gratuita para projetos de código aberto
- **Servidor Próprio**: Para maior controle e personalização

Para instruções detalhadas sobre hospedagem, consulte o [Guia de Hospedagem](../oil-gas-suppliers/guia_hospedagem.md).

## Manutenção e Atualização

### Atualização de Dados

Para adicionar, remover ou atualizar fornecedores:

1. Edite o arquivo `/src/data/data.json`
2. Siga a estrutura de dados existente
3. Reinicie o servidor de desenvolvimento para ver as alterações

### Modificação de Componentes

Para modificar a aparência ou comportamento:

1. Localize o componente desejado na estrutura de diretórios
2. Edite o arquivo JSX e/ou CSS correspondente
3. Teste as alterações no navegador

## Documentação Completa

Para uma documentação mais detalhada, consulte:

- [Documentação Completa](../oil-gas-suppliers/documentacao.md): Visão geral detalhada do projeto
- [Guia de Hospedagem](../oil-gas-suppliers/guia_hospedagem.md): Instruções para implantação em produção

## Contribuição

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Faça commit das suas alterações (`git commit -m 'Adiciona nova funcionalidade'`)
4. Faça push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## Contato

Para suporte ou dúvidas sobre o projeto, entre em contato através do e-mail: contato@oilgasrj.com.br

---

© 2025 OilGasRJ. Todos os direitos reservados.

