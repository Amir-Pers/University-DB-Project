/* ============================================================
   کاروان - app.js
   منطق مشترک بین تمام صفحات: ذخیره‌سازی، تم، هدر/فوتر، ابزارها
   ============================================================ */

/* ============ DATA ============ */

// const BRANDS_CAR = ["پراید","پژو 206","پژو پارس","سمند","تیبا","دنا","کوییک","ام‌وی‌ام"];
// const BRANDS_MOTO = ["هوندا","یاماها","باجاج","کویر موتور","اپاچی","روان"];

// const seedListings = [
//   {id:1, type:"car", brand:"پژو 206", model:"تیپ ۵", year:1399, price:720, km:65000, city:"تهران", phone:"0912xxxxxxx", desc:"بدون رنگ، فنی سالم، بیمه کامل.", owner:"seed"},
//   {id:2, type:"moto", brand:"هوندا", model:"CB 125F", year:1401, price:145, km:8000, city:"اصفهان", phone:"0913xxxxxxx", desc:"صفر کارکرده، تک‌برگ، رنگ مشکی.", owner:"seed"},
//   {id:3, type:"car", brand:"سمند", model:"LX", year:1397, price:480, km:120000, city:"مشهد", phone:"0915xxxxxxx", desc:"دوگانه‌سوز کارخانه، سند آزاد.", owner:"seed"},
//   {id:4, type:"moto", brand:"یاماها", model:"R15 V3", year:1400, price:390, km:12000, city:"تهران", phone:"0919xxxxxxx", desc:"اسپرت، فقط شهر، سرویس کامل.", owner:"seed"},
//   {id:5, type:"car", brand:"کوییک", model:"S", year:1402, price:980, km:21000, city:"کرج", phone:"0901xxxxxxx", desc:"زیر گارانتی شرکت، تصادفی نیست.", owner:"seed"},
//   {id:6, type:"moto", brand:"باجاج", model:"200NS", year:1399, price:210, km:30000, city:"شیراز", phone:"0917xxxxxxx", desc:"لوازم اورجینال، بدون افتادگی.", owner:"seed"},
// ];


/* ============ STORAGE ============ */

// function loadListings(){
//   try{
//     const raw = localStorage.getItem('karevan_listings');
//     return raw ? JSON.parse(raw) : seedListings;
//   }catch(e){ return seedListings; }
// }
// function saveListings(list){ localStorage.setItem('karevan_listings', JSON.stringify(list)); }

// function loadUsers(){
//   try{ return JSON.parse(localStorage.getItem('karevan_users')||'[]'); }catch(e){ return []; }
// }
// function saveUsers(u){ localStorage.setItem('karevan_users', JSON.stringify(u)); }

// function loadSession(){
//   try{ return JSON.parse(localStorage.getItem('karevan_session')||'null'); }catch(e){ return null; }
// }
// function saveSession(s){ s ? localStorage.setItem('karevan_session', JSON.stringify(s)) : localStorage.removeItem('karevan_session'); }

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
