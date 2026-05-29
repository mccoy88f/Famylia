// PWA service worker base — Flutter ne genera uno in build; questo file è un placeholder
// per sviluppo. In produzione usare l'output di `flutter build web`.
const CACHE_NAME = 'famylia-v1';

self.addEventListener('install', (event) => {
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(self.clients.claim());
});

self.addEventListener('fetch', (event) => {
  // Network-first per API; cache statica gestita da Flutter build.
});
