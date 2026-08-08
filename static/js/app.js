/* ============================================================
   کاروان - app.js
   منطق مشترک بین تمام صفحات: تم، پیام‌ها (Toast)، مدال‌ها و عکس پیش‌فرض
   ============================================================ */

/* ============ PATHS ============ */
const DEFAULT_IMG_DARK = '/static/images/default-car-dark.jpeg';
const DEFAULT_IMG_LIGHT = '/static/images/default-car-light.jpeg';

/* ============ THEME MANAGEMENT ============ */
function loadTheme() { 
  return localStorage.getItem('karevan_theme') || 'dark'; 
}

function applyTheme(theme) {
  document.documentElement.setAttribute('data-theme', theme);
  localStorage.setItem('karevan_theme', theme);
  updateFallbackImages(theme);
}

function initTheme() {
  applyTheme(loadTheme());
  const toggle = document.getElementById('themeToggle');
  if (toggle) {
    toggle.addEventListener('click', () => {
      const current = document.documentElement.getAttribute('data-theme');
      applyTheme(current === 'dark' ? 'light' : 'dark');
    });
  }
}

/* ============ FALLBACK IMAGES MANAGEMENT ============ */
function getFallbackImageByTheme() {
  const currentTheme = document.documentElement.getAttribute('data-theme') || 'dark';
  return currentTheme === 'dark' ? DEFAULT_IMG_DARK : DEFAULT_IMG_LIGHT;
}

// به‌روزرسانی عکس‌های پیش‌فرضِ لودشده هنگام تغییر تم
function updateFallbackImages(theme) {
  const fallbackImages = document.querySelectorAll('img[data-is-fallback="true"]');
  const newSrc = theme === 'dark' ? DEFAULT_IMG_DARK : DEFAULT_IMG_LIGHT;

  fallbackImages.forEach(img => {
    img.src = newSrc;
  });
}

// تابع جایگزینی عکس در صورت خطا
function handleImageError(img) {
  if (img.getAttribute('data-is-fallback') === 'true') return;
  img.setAttribute('data-is-fallback', 'true');
  img.src = getFallbackImageByTheme();
}

// گوش‌به‌زنگ خطای لود عکس‌ها
function initAdImagesFallback() {
  // گرفتن تمام عکس‌های مربوط به آگهی‌ها با کلاس‌های مختلف پروژه‌تان
  const adImages = document.querySelectorAll(
    '.card-image, .card-media img, .ad-image img, #mainImage, .thumb, .detail-gallery img'
  );

  adImages.forEach(img => {
    // اگر عکس قبلاً دچار خطا شده باشد
    if (img.complete && img.naturalWidth === 0) {
      handleImageError(img);
    }

    img.addEventListener('error', function() {
      handleImageError(this);
    });
  });
}

/* ============ UTILS & TOAST ============ */
function showToast(msg) {
  let t = document.getElementById('toast');
  if (!t) {
    t = document.createElement('div');
    t.className = 'toast';
    t.id = 'toast';
    document.body.appendChild(t);
  }
  t.textContent = msg;
  t.classList.add('show');
  setTimeout(() => t.classList.remove('show'), 2200);
}

/* ============ MODALS ============ */
function openModal(id) { 
  const el = document.getElementById(id); 
  if (!el) return; 
  el.classList.add('show'); 
  document.body.style.overflow = 'hidden'; 
}

function closeModal(id) { 
  const el = document.getElementById(id); 
  if (!el) return; 
  el.classList.remove('show'); 
  document.body.style.overflow = ''; 
}

function bindModalCloseEvents() {
  document.querySelectorAll('[data-close]').forEach(b => {
    b.addEventListener('click', () => closeModal(b.dataset.close));
  });
  document.querySelectorAll('.overlay').forEach(o => {
    o.addEventListener('click', e => { 
      if (e.target === o) closeModal(o.id); 
    });
  });
}

/* ============ INIT COMMON ============ */
document.addEventListener('DOMContentLoaded', () => {
  initTheme();
  bindModalCloseEvents();
  initAdImagesFallback();
});