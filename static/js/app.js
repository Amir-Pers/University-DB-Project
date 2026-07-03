/* ============================================================
   کاروان - app.js
   منطق مشترک بین تمام صفحات: ذخیره‌سازی، تم، هدر/فوتر، ابزارها
   ============================================================ */

/* ============ THEME ============ */
function loadTheme(){ return localStorage.getItem('karevan_theme') || 'dark'; }
function applyTheme(theme){
  document.documentElement.setAttribute('data-theme', theme);
  localStorage.setItem('karevan_theme', theme);
}
function initTheme(){
  applyTheme(loadTheme());
  const toggle = document.getElementById('themeToggle');
  if(toggle){
    toggle.addEventListener('click', ()=>{
      const current = document.documentElement.getAttribute('data-theme');
      applyTheme(current === 'dark' ? 'light' : 'dark');
    });
  }
}

/* ============ HELPERS ============ */
function toman(n){
  n = Number(n);
  return n >= 1000 ? (n/1000).toLocaleString('fa-IR',{maximumFractionDigits:1})+' میلیارد' : n.toLocaleString('fa-IR')+' میلیون';
}
function fa(n){ return Number(n).toLocaleString('fa-IR'); }

function showToast(msg){
  let t = document.getElementById('toast');
  if(!t){
    t = document.createElement('div');
    t.className = 'toast';
    t.id = 'toast';
    document.body.appendChild(t);
  }
  t.textContent = msg;
  t.classList.add('show');
  setTimeout(()=>t.classList.remove('show'), 2200);
}

/* ============ MODAL (still used for ad detail popup on index) ============ */
function openModal(id){ const el=document.getElementById(id); if(!el) return; el.classList.add('show'); document.body.style.overflow='hidden'; }
function closeModal(id){ const el=document.getElementById(id); if(!el) return; el.classList.remove('show'); document.body.style.overflow=''; }
function bindModalCloseEvents(){
  document.querySelectorAll('[data-close]').forEach(b=>{
    b.addEventListener('click', ()=> closeModal(b.dataset.close));
  });
  document.querySelectorAll('.overlay').forEach(o=>{
    o.addEventListener('click', e=>{ if(e.target === o) closeModal(o.id); });
  });
}

/* ============ HEADER / FOOTER (shared across all pages) ============ */
function initHeaderFooter(){
  // footer year
  const yearEl = document.getElementById('footYear');
  if(yearEl) yearEl.textContent = new Date().getFullYear();

  // header account button reflects login state + redirects to account page
  const accBtn = document.getElementById('btnAccount');
  const session = loadSession();
  if(accBtn){
    if(session){
      accBtn.classList.add('is-logged');
      accBtn.title = session.name;
    }
    accBtn.addEventListener('click', ()=>{
      window.location.href = 'account.html';
    });
  }

  // "+ ثبت آگهی" button in header -> goes to post-ad.html (guard is handled on that page)
  const addBtn = document.getElementById('btnAddAd');
  if(addBtn){
    addBtn.addEventListener('click', ()=>{
      window.location.href = 'post-ad.html';
    });
  }
}

/* Require login helper - used on post-ad.html */
function requireLogin(){
  const session = loadSession();
  if(!session){
    sessionStorage.setItem('karevan_redirect', 'post-ad.html');
    showToast('برای ثبت آگهی اول وارد حساب شو');
    setTimeout(()=>{ window.location.href = 'account.html'; }, 900);
    return null;
  }
  return session;
}

/* ============ INIT COMMON ============ */
document.addEventListener('DOMContentLoaded', ()=>{
  initTheme();
  initHeaderFooter();
  bindModalCloseEvents();
});
