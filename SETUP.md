# Guia de Configuração — Work Drones Geo + Supabase

## PASSO 1 — Criar conta Supabase (grátis)
1. Acesse https://supabase.com → clique em "Start for free"
2. Faça login com Google ou GitHub
3. Clique em "New Project"
4. Preencha:
   - Name: workdronesgeo
   - Database Password: crie uma senha forte e anote
   - Region: South America (São Paulo)
5. Clique em "Create new project" — aguarde ~2 minutos

## PASSO 2 — Rodar o script SQL
1. No painel Supabase → SQL Editor → New query
2. Abra o arquivo schema.sql (mesma pasta do index.html)
3. Copie todo o conteúdo e cole no editor
4. Clique em Run (F5)
5. Deve aparecer: "Success. No rows returned"

## PASSO 3 — Pegar as credenciais
1. Project Settings (engrenagem) → API
2. Copie:
   - Project URL (ex: https://xyzabcdef.supabase.co)
   - anon public key (começa com "eyJ...")

## PASSO 4 — Configurar o index.html
1. Abra o index.html com Bloco de Notas ou VS Code
2. Encontre no topo do arquivo:
   const SUPABASE_URL = 'COLE_AQUI_A_PROJECT_URL';
   const SUPABASE_KEY = 'COLE_AQUI_A_ANON_PUBLIC_KEY';
3. Substitua pelos valores copiados no Passo 3
4. Salve o arquivo

## PASSO 5 — Criar o usuário admin
1. No painel Supabase → Authentication → Users
2. Clique em "Add user" → "Create new user"
3. Email: admin@workdronesgeo.com
4. Password: defina a senha que desejar
5. Clique em "Create User"

## PASSO 6 — Abrir e testar
1. Abra o index.html no navegador (duplo clique)
2. Faça login com o e-mail e senha do Passo 5
3. Cadastre uma operação e um documento para testar

## Aviso: projeto pausado (plano gratuito)
O Supabase pausa projetos gratuitos sem uso por mais de 7 dias.
Para reativar: https://supabase.com/dashboard → seu projeto → Restore project.
