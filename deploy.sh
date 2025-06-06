#!/bin/bash

# Script de implantação para o Website de Fornecedores da Indústria de Óleo e Gás
# Autor: Manus AI
# Data: 06/06/2025

# Cores para saída no terminal
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Função para exibir mensagens de status
status() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

# Função para exibir avisos
warning() {
  echo -e "${YELLOW}[AVISO]${NC} $1"
}

# Função para exibir erros
error() {
  echo -e "${RED}[ERRO]${NC} $1"
}

# Verificar se o Node.js está instalado
if ! command -v node &> /dev/null; then
  error "Node.js não encontrado. Por favor, instale o Node.js (versão 16 ou superior)."
  exit 1
fi

# Verificar se o pnpm está instalado
if ! command -v pnpm &> /dev/null; then
  warning "pnpm não encontrado. Tentando instalar..."
  npm install -g pnpm
  if [ $? -ne 0 ]; then
    error "Falha ao instalar pnpm. Por favor, instale manualmente."
    exit 1
  fi
  status "pnpm instalado com sucesso."
fi

# Verificar a versão do Node.js
NODE_VERSION=$(node -v | cut -d 'v' -f 2)
NODE_MAJOR_VERSION=$(echo $NODE_VERSION | cut -d '.' -f 1)
if [ $NODE_MAJOR_VERSION -lt 16 ]; then
  warning "Versão do Node.js ($NODE_VERSION) é menor que a recomendada (16.0.0)."
  read -p "Deseja continuar mesmo assim? (s/n): " CONTINUE
  if [ "$CONTINUE" != "s" ]; then
    error "Implantação cancelada."
    exit 1
  fi
fi

# Instalar dependências
status "Instalando dependências..."
pnpm install
if [ $? -ne 0 ]; then
  error "Falha ao instalar dependências."
  exit 1
fi
status "Dependências instaladas com sucesso."

# Gerar build de produção
status "Gerando build de produção..."
pnpm run build
if [ $? -ne 0 ]; then
  error "Falha ao gerar build de produção."
  exit 1
fi
status "Build de produção gerada com sucesso."

# Verificar se a pasta dist foi criada
if [ ! -d "dist" ]; then
  error "Pasta 'dist' não encontrada. A build pode ter falhado."
  exit 1
fi

# Perguntar qual método de implantação usar
echo ""
echo "Escolha o método de implantação:"
echo "1. Servidor local (copia para uma pasta específica)"
echo "2. GitHub Pages (requer gh-pages instalado)"
echo "3. Netlify (requer CLI do Netlify instalado)"
echo "4. Vercel (requer CLI do Vercel instalado)"
echo "5. Azure Static Web Apps (requer CLI do Azure instalado)"
echo "6. Apenas gerar a build (sem implantação)"
read -p "Opção (1-6): " DEPLOY_OPTION

case $DEPLOY_OPTION in
  1)
    # Implantação em servidor local
    read -p "Digite o caminho para a pasta de destino: " DEST_FOLDER
    if [ ! -d "$DEST_FOLDER" ]; then
      warning "Pasta de destino não existe. Tentando criar..."
      mkdir -p "$DEST_FOLDER"
      if [ $? -ne 0 ]; then
        error "Falha ao criar pasta de destino."
        exit 1
      fi
    fi
    
    status "Copiando arquivos para $DEST_FOLDER..."
    cp -r dist/* "$DEST_FOLDER"
    if [ $? -ne 0 ]; then
      error "Falha ao copiar arquivos."
      exit 1
    fi
    status "Arquivos copiados com sucesso para $DEST_FOLDER."
    ;;
    
  2)
    # Implantação no GitHub Pages
    status "Preparando para implantação no GitHub Pages..."
    if ! command -v gh &> /dev/null; then
      warning "CLI do GitHub não encontrado. Tentando instalar gh-pages..."
      pnpm add -D gh-pages
      if [ $? -ne 0 ]; then
        error "Falha ao instalar gh-pages."
        exit 1
      fi
    fi
    
    status "Implantando no GitHub Pages..."
    pnpm exec gh-pages -d dist
    if [ $? -ne 0 ]; then
      error "Falha ao implantar no GitHub Pages."
      exit 1
    fi
    status "Implantação no GitHub Pages concluída com sucesso."
    ;;
    
  3)
    # Implantação no Netlify
    status "Preparando para implantação no Netlify..."
    if ! command -v netlify &> /dev/null; then
      warning "CLI do Netlify não encontrado. Tentando instalar..."
      npm install -g netlify-cli
      if [ $? -ne 0 ]; then
        error "Falha ao instalar CLI do Netlify."
        exit 1
      fi
    fi
    
    status "Implantando no Netlify..."
    netlify deploy --dir=dist
    if [ $? -ne 0 ]; then
      error "Falha ao implantar no Netlify."
      exit 1
    fi
    
    read -p "Deseja promover esta implantação para produção? (s/n): " PROMOTE
    if [ "$PROMOTE" = "s" ]; then
      netlify deploy --dir=dist --prod
      status "Implantação promovida para produção."
    fi
    status "Implantação no Netlify concluída com sucesso."
    ;;
    
  4)
    # Implantação no Vercel
    status "Preparando para implantação no Vercel..."
    if ! command -v vercel &> /dev/null; then
      warning "CLI do Vercel não encontrado. Tentando instalar..."
      npm install -g vercel
      if [ $? -ne 0 ]; then
        error "Falha ao instalar CLI do Vercel."
        exit 1
      fi
    fi
    
    status "Implantando no Vercel..."
    vercel --prod
    if [ $? -ne 0 ]; then
      error "Falha ao implantar no Vercel."
      exit 1
    fi
    status "Implantação no Vercel concluída com sucesso."
    ;;
    
  5)
    # Implantação no Azure Static Web Apps
    status "Preparando para implantação no Azure Static Web Apps..."
    if ! command -v az &> /dev/null; then
      warning "CLI do Azure não encontrado. Por favor, instale manualmente."
      error "Visite: https://docs.microsoft.com/cli/azure/install-azure-cli"
      exit 1
    fi
    
    # Verificar login no Azure
    az account show &> /dev/null
    if [ $? -ne 0 ]; then
      warning "Você não está logado no Azure. Iniciando processo de login..."
      az login
      if [ $? -ne 0 ]; then
        error "Falha ao fazer login no Azure."
        exit 1
      fi
    fi
    
    # Solicitar informações para implantação
    read -p "Nome do grupo de recursos: " RESOURCE_GROUP
    read -p "Nome do aplicativo estático: " STATIC_APP_NAME
    read -p "Região (ex: brazilsouth): " REGION
    
    # Criar grupo de recursos se não existir
    az group show --name "$RESOURCE_GROUP" &> /dev/null
    if [ $? -ne 0 ]; then
      warning "Grupo de recursos não encontrado. Criando..."
      az group create --name "$RESOURCE_GROUP" --location "$REGION"
      if [ $? -ne 0 ]; then
        error "Falha ao criar grupo de recursos."
        exit 1
      fi
    fi
    
    # Criar aplicativo estático
    status "Criando aplicativo estático no Azure..."
    az staticwebapp create --name "$STATIC_APP_NAME" --resource-group "$RESOURCE_GROUP" --location "$REGION" --source . --output-location dist
    if [ $? -ne 0 ]; then
      error "Falha ao criar aplicativo estático no Azure."
      exit 1
    fi
    
    # Implantar
    status "Implantando no Azure Static Web Apps..."
    az staticwebapp deploy --name "$STATIC_APP_NAME" --resource-group "$RESOURCE_GROUP" --source-path . --output-location dist
    if [ $? -ne 0 ]; then
      error "Falha ao implantar no Azure Static Web Apps."
      exit 1
    fi
    status "Implantação no Azure Static Web Apps concluída com sucesso."
    ;;
    
  6)
    # Apenas gerar a build
    status "Build gerada com sucesso em ./dist"
    status "Para implantar manualmente, copie o conteúdo da pasta dist para seu servidor web."
    ;;
    
  *)
    error "Opção inválida."
    exit 1
    ;;
esac

echo ""
status "Processo de implantação concluído."
echo ""
echo "Para mais informações sobre hospedagem e manutenção, consulte:"
echo "- ./documentacao.pdf"
echo "- ./guia_hospedagem.pdf"
echo ""

exit 0

