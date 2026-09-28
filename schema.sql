-- ============================================================
--  WORK DRONES GEO — Schema Supabase
--  Cole este script no SQL Editor do seu projeto Supabase
--  e clique em "Run" (F5).
-- ============================================================

-- ── 1. TABELA: operations ────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.operations (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  code        text NOT NULL,
  client      text NOT NULL,
  location    text NOT NULL,
  date        date NOT NULL,
  drone       text,
  altitude    text DEFAULT '120',
  objective   text,
  notes       text,
  status      text NOT NULL DEFAULT 'Em planejamento',
  created_at  timestamptz DEFAULT now()
);

-- ── 2. TABELA: documents ─────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.documents (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name        text NOT NULL,
  category    text NOT NULL DEFAULT 'Outros',
  due_date    date,
  file_name   text,
  file_path   text,
  file_type   text,
  created_at  timestamptz DEFAULT now()
);

-- ── 3. TABELA: fleet ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.fleet (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name        text NOT NULL,
  serial      text DEFAULT 'A DEFINIR',
  status      text NOT NULL DEFAULT 'Ativa',
  created_at  timestamptz DEFAULT now()
);

-- ── 4. TABELA: history ───────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.history (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  text        text NOT NULL,
  created_at  timestamptz DEFAULT now()
);

-- ============================================================
--  ROW LEVEL SECURITY (RLS)
-- ============================================================

ALTER TABLE public.operations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.documents  ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.fleet      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.history    ENABLE ROW LEVEL SECURITY;

CREATE POLICY "ops_select" ON public.operations FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "ops_insert" ON public.operations FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "ops_update" ON public.operations FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "ops_delete" ON public.operations FOR DELETE USING (auth.uid() = user_id);

CREATE POLICY "docs_select" ON public.documents FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "docs_insert" ON public.documents FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "docs_update" ON public.documents FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "docs_delete" ON public.documents FOR DELETE USING (auth.uid() = user_id);

CREATE POLICY "fleet_select" ON public.fleet FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "fleet_insert" ON public.fleet FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "fleet_update" ON public.fleet FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "fleet_delete" ON public.fleet FOR DELETE USING (auth.uid() = user_id);

CREATE POLICY "hist_select" ON public.history FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "hist_insert" ON public.history FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "hist_delete" ON public.history FOR DELETE USING (auth.uid() = user_id);

-- ============================================================
--  STORAGE — Bucket para arquivos dos documentos
-- ============================================================

INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'doc-files',
  'doc-files',
  false,
  52428800,
  ARRAY['application/pdf','image/jpeg','image/png','image/webp']
)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "storage_select" ON storage.objects FOR SELECT
  USING (bucket_id = 'doc-files' AND auth.uid()::text = (storage.foldername(name))[1]);

CREATE POLICY "storage_insert" ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'doc-files' AND auth.uid()::text = (storage.foldername(name))[1]);

CREATE POLICY "storage_delete" ON storage.objects FOR DELETE
  USING (bucket_id = 'doc-files' AND auth.uid()::text = (storage.foldername(name))[1]);
