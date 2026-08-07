/* ============================================================
   کاروان - app.js
   منطق مشترک بین تمام صفحات: تم، پیام‌ها (Toast) و مدال‌ها
   ============================================================ */

/* ============ THEME MANAGEMENT ============ */
function loadTheme() { 
  return localStorage.getItem('karevan_theme') || 'dark'; 
}

function applyTheme(theme) {
  document.documentElement.setAttribute('data-theme', theme);
  localStorage.setItem('karevan_theme', theme);
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
});