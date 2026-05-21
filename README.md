# 📒 Caderneta 3A

Sistema escolar premium de controle de vendas a prazo (fiado).

## 🚀 Como executar

### Opção 1 — Arquivo direto (sem instalação)
Abra o `index.html` direto no navegador. Funciona sem servidor!

### Opção 2 — Com Vite (recomendado)

```bash
# Instalar dependências
npm install

# Rodar em desenvolvimento
npm run dev -- --host

# Acessar em:
http://localhost:3000
```

### Opção 3 — Termux Android

```bash
pkg install nodejs
npm install
npm run dev -- --host
# Acesse: http://localhost:3000
```

## ⚙️ Configuração Supabase

### 1. Configure a ANON KEY no index.html

Abra `index.html` e substitua:
```js
const SUPABASE_KEY = "COLOQUE_SUA_ANON_KEY_AQUI";
```
pela sua chave do Supabase (Dashboard → Settings → API → anon public).

### 2. Execute o SQL no Supabase

No painel do Supabase → SQL Editor, execute o conteúdo de `supabase.sql`.

### 3. Pronto!

O app conectará automaticamente e salvará todos os dados no Supabase.

> **Sem Supabase?** O app funciona em modo offline usando localStorage.

## 📱 Funcionalidades

- **Dashboard** — métricas, gráficos, top devedores
- **Clientes** — cadastro automático, histórico, edição
- **Vendas** — registro rápido, múltiplas por cliente
- **Pagamentos** — parcial/total, distribuição FIFO automática
- **Relatórios** — exportar CSV, imprimir
- **Configurações** — backup JSON, resetar dados
- **Realtime** — atualização automática via Supabase Realtime

## 🛠 Stack

- HTML5 + CSS3 + JavaScript Vanilla
- Supabase (banco + realtime)
- Chart.js (gráficos)
- Vite (dev server)

## 📄 Licença

MIT — uso livre para fins educacionais.
