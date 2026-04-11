// Basic service worker to prevent 404 errors
// This is a minimal service worker that does nothing
// Can be enhanced later for PWA functionality

self.addEventListener('install', (event) => {
  // Skip waiting to activate immediately
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  // Claim all clients
  event.waitUntil(self.clients.claim());
});

self.addEventListener('fetch', (event) => {
  // Pass through all requests without caching
  event.respondWith(fetch(event.request));
});