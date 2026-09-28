// ── Work Drones Geo — Service Worker v1.2 ──────────────────
const CACHE_NAME = 'wdg-cache-v1.2';

const STATIC_ASSETS = [
  './index.html',
  './manifest.json',
  './icons/icon.svg',
  './icons/icon-192.png',
  './icons/icon-512.png',
  'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/dist/umd/supabase.min.js',
  'https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700;900&display=swap'
];

// ── INSTALL: pré-cache dos assets estáticos ─────────────────
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      // Tenta cachear cada asset individualmente para não bloquear em falhas de rede
      return Promise.allSettled(
        STATIC_ASSETS.map(url =>
          cache.add(url).catch(err => console.warn('[SW] Não cacheado:', url, err))
        )
      );
    }).then(() => self.skipWaiting())
  );
});

// ── ACTIVATE: limpar caches antigos ────────────────────────
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(
        keys.filter(k => k !== CACHE_NAME).map(k => caches.delete(k))
      )
    ).then(() => self.clients.claim())
  );
});

// ── FETCH: estratégia por tipo de requisição ────────────────
self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);

  // Ignorar requisições não-GET e extensões de browser
  if (event.request.method !== 'GET') return;
  if (url.protocol === 'chrome-extension:') return;

  // Supabase API → Network-first (com fallback de cache)
  if (url.hostname.includes('supabase.co')) {
    event.respondWith(networkFirstStrategy(event.request));
    return;
  }

  // Google Fonts e CDN → Cache-first
  if (url.hostname.includes('fonts.g') || url.hostname.includes('jsdelivr.net') || url.hostname.includes('gstatic.com')) {
    event.respondWith(cacheFirstStrategy(event.request));
    return;
  }

  // Assets locais → Cache-first
  event.respondWith(cacheFirstStrategy(event.request));
});

// Cache-first: serve do cache, busca na rede se não tiver
async function cacheFirstStrategy(request) {
  const cached = await caches.match(request);
  if (cached) return cached;
  try {
    const response = await fetch(request);
    if (response.ok) {
      const cache = await caches.open(CACHE_NAME);
      cache.put(request, response.clone());
    }
    return response;
  } catch {
    return new Response('Recurso offline não disponível', { status: 503 });
  }
}

// Network-first: tenta rede, cai no cache se falhar
async function networkFirstStrategy(request) {
  try {
    const response = await fetch(request);
    if (response.ok) {
      const cache = await caches.open(CACHE_NAME);
      cache.put(request, response.clone());
    }
    return response;
  } catch {
    const cached = await caches.match(request);
    if (cached) return cached;
    return new Response(JSON.stringify({ error: 'offline', data: null }), {
      status: 503,
      headers: { 'Content-Type': 'application/json' }
    });
  }
}

// ── MENSAGENS do app ────────────────────────────────────────
self.addEventListener('message', event => {
  if (event.data?.action === 'skipWaiting') self.skipWaiting();
});
