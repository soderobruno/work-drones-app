# 🚀 Deploy — Work Drones Geo PWA no GitHub + Netlify (grátis)

## Pré-requisitos
- Conta GitHub: https://github.com (gratuita)
- Conta Netlify: https://app.netlify.com (gratuita, login com GitHub)

---

## PASSO 1 — Criar repositório no GitHub

1. Acesse https://github.com/new
2. Preencha:
   - **Repository name:** `workdronesgeo`
   - **Description:** Central de Operações — Work Drones Geo
   - **Visibility:** Private ✅ (recomendado, suas credenciais Supabase ficam privadas)
3. Clique em **Create repository**
4. GitHub vai mostrar a tela com comandos — **copie o link do repositório** (ex: `https://github.com/SEU_USUARIO/workdronesgeo.git`)

---

## PASSO 2 — Enviar arquivos pelo GitHub Desktop (mais fácil)

### Opção A: GitHub Desktop (recomendado para quem não usa linha de comando)
1. Baixe o GitHub Desktop: https://desktop.github.com
2. Abra o GitHub Desktop → **File → Add local repository**
3. Clique em **Choose…** → Selecione a pasta `AMBIENTE WORK DRONES GEO`
4. Clique em **create a repository here**
5. Adicione um commit: `Initial commit — Work Drones Geo PWA`
6. Clique em **Publish repository**
7. Desmarque "Keep this code private" se quiser público, ou deixe marcado
8. Clique em **Publish repository**

### Opção B: Via Git no terminal (PowerShell)
```powershell
cd "C:\Users\bsode\OneDrive\Desktop\AMBIENTE WORK DRONES GEO"
git init
git add .
git commit -m "Work Drones Geo PWA v2.0"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/workdronesgeo.git
git push -u origin main
```

---

## PASSO 3 — Conectar ao Netlify

1. Acesse https://app.netlify.com
2. Clique em **Add new site → Import an existing project**
3. Selecione **GitHub**
4. Autorize o Netlify a acessar sua conta GitHub
5. Selecione o repositório `workdronesgeo`
6. Configurações de build:
   - **Base directory:** (deixe em branco)
   - **Build command:** (deixe em branco)
   - **Publish directory:** `.` (ponto simples)
7. Clique em **Deploy site**
8. Aguarde ~1 minuto — o Netlify vai dar uma URL como:
   `https://amazing-name-123456.netlify.app`

---

## PASSO 4 — Domínio personalizado (opcional, grátis)

No painel Netlify:
1. **Site configuration → Domain management → Add custom domain**
2. Ou renomeie o subdomínio: **Site configuration → Site details → Change site name**
   - Ex: `workdronesgeo.netlify.app`

---

## PASSO 5 — Testar o PWA no celular

1. Abra o link Netlify no Chrome do celular
2. O Chrome vai mostrar um banner: **"Adicionar à tela inicial"**
3. Toque em **Adicionar** — o app vai aparecer como um app nativo
4. No iOS (Safari): toque no ícone de compartilhar → **Adicionar à Tela de Início**

---

## PASSO 6 — Atualizar o app no futuro

Sempre que editar o `index.html`:
1. **GitHub Desktop:** Stage changes → Commit → Push origin
2. **Netlify** vai detectar automaticamente e republicar em ~30 segundos

---

## Teste local (antes do deploy)

Para testar o Service Worker localmente (requer HTTPS ou localhost):

```powershell
# Instale o serve globalmente (requer Node.js)
npm install -g serve

# Rode na pasta do projeto
serve "C:\Users\bsode\OneDrive\Desktop\AMBIENTE WORK DRONES GEO"
```
Acesse: http://localhost:3000

---

## Arquivos da pasta (estrutura final)

```
AMBIENTE WORK DRONES GEO/
├── index.html          ← App PWA completo
├── manifest.json       ← Configurações do PWA
├── sw.js               ← Service Worker (offline)
├── schema.sql          ← Schema do banco Supabase
├── SETUP.md            ← Guia Supabase
├── DEPLOY.md           ← Este guia
└── icons/
    ├── icon.svg        ← Ícone vetorial
    ├── icon-192.png    ← Ícone Android
    ├── icon-512.png    ← Ícone splash screen
    └── apple-touch-icon.png ← Ícone iOS
```

---

## Segurança

> ⚠️ O `SUPABASE_KEY` no `index.html` é a chave **anon/public** — ela é segura
> para ficar no frontend. O que protege seus dados são as políticas **RLS**
> configuradas no banco, não a chave em si.
>
> Nunca coloque a `service_role` key no frontend.
