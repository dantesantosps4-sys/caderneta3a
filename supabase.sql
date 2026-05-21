-- ═══════════════════════════════════════════
-- CADERNETA 3A — Schema Supabase
-- Execute este SQL no Supabase SQL Editor
-- ═══════════════════════════════════════════

-- Habilitar extensões
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ═══════════════════════════════════════════
-- TABELA: clientes
-- ═══════════════════════════════════════════
CREATE TABLE IF NOT EXISTS clientes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  nome VARCHAR(255) NOT NULL,
  telefone VARCHAR(20),
  observacao TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índice para busca por nome
CREATE INDEX IF NOT EXISTS idx_clientes_nome ON clientes(nome);

-- ═══════════════════════════════════════════
-- TABELA: vendas
-- ═══════════════════════════════════════════
CREATE TABLE IF NOT EXISTS vendas (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  cliente_id UUID NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
  descricao VARCHAR(500) NOT NULL,
  valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
  data DATE DEFAULT CURRENT_DATE,
  observacao TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_vendas_cliente ON vendas(cliente_id);
CREATE INDEX IF NOT EXISTS idx_vendas_data ON vendas(data);

-- ═══════════════════════════════════════════
-- TABELA: pagamentos
-- ═══════════════════════════════════════════
CREATE TABLE IF NOT EXISTS pagamentos (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  venda_id UUID NOT NULL REFERENCES vendas(id) ON DELETE CASCADE,
  valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
  data DATE DEFAULT CURRENT_DATE,
  observacao TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_pagamentos_venda ON pagamentos(venda_id);
CREATE INDEX IF NOT EXISTS idx_pagamentos_data ON pagamentos(data);

-- ═══════════════════════════════════════════
-- ROW LEVEL SECURITY (RLS)
-- ═══════════════════════════════════════════

-- Habilitar RLS nas tabelas
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE vendas ENABLE ROW LEVEL SECURITY;
ALTER TABLE pagamentos ENABLE ROW LEVEL SECURITY;

-- POLÍTICAS: Acesso público (anon key)
-- Para uso escolar sem autenticação, permitir tudo via anon

-- Clientes
CREATE POLICY "Allow all clientes" ON clientes
  FOR ALL TO anon, authenticated
  USING (true)
  WITH CHECK (true);

-- Vendas
CREATE POLICY "Allow all vendas" ON vendas
  FOR ALL TO anon, authenticated
  USING (true)
  WITH CHECK (true);

-- Pagamentos
CREATE POLICY "Allow all pagamentos" ON pagamentos
  FOR ALL TO anon, authenticated
  USING (true)
  WITH CHECK (true);

-- ═══════════════════════════════════════════
-- REALTIME — Habilitar publicações
-- ═══════════════════════════════════════════

-- Habilitar realtime para as tabelas
ALTER PUBLICATION supabase_realtime ADD TABLE clientes;
ALTER PUBLICATION supabase_realtime ADD TABLE vendas;
ALTER PUBLICATION supabase_realtime ADD TABLE pagamentos;

-- ═══════════════════════════════════════════
-- TRIGGERS: atualizar updated_at
-- ═══════════════════════════════════════════

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER clientes_updated_at
  BEFORE UPDATE ON clientes
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER vendas_updated_at
  BEFORE UPDATE ON vendas
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ═══════════════════════════════════════════
-- DADOS DE EXEMPLO (opcional)
-- Remova este bloco em produção
-- ═══════════════════════════════════════════

-- INSERT INTO clientes (nome) VALUES ('Dante'), ('Maria Silva'), ('João Pedro');
-- (Adicione vendas e pagamentos de teste conforme necessário)
