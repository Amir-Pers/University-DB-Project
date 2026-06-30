/* ============ DATA ============ */
const BRANDS_CAR = ["پراید","پژو 206","پژو پارس","سمند","تیبا","دنا","کوییک","ام‌وی‌ام"];
const BRANDS_MOTO = ["هوندا","یاماها","باجاج","کویر موتور","اپاچی","روان"];

const seedListings = [
  {id:1, type:"car", brand:"پژو 206", model:"تیپ ۵", year:1399, price:720, km:65000, city:"تهران", phone:"0912xxxxxxx", desc:"بدون رنگ، فنی سالم، بیمه کامل.", owner:"seed"},
  {id:2, type:"moto", brand:"هوندا", model:"CB 125F", year:1401, price:145, km:8000, city:"اصفهان", phone:"0913xxxxxxx", desc:"صفر کارکرده، تک‌برگ، رنگ مشکی.", owner:"seed"},
  {id:3, type:"car", brand:"سمند", model:"LX", year:1397, price:480, km:120000, city:"مشهد", phone:"0915xxxxxxx", desc:"دوگانه‌سوز کارخانه، سند آزاد.", owner:"seed"},
  {id:4, type:"moto", brand:"یاماها", model:"R15 V3", year:1400, price:390, km:12000, city:"تهران", phone:"0919xxxxxxx", desc:"اسپرت، فقط شهر، سرویس کامل.", owner:"seed"},
  {id:5, type:"car", brand:"کوییک", model:"S", year:1402, price:980, km:21000, city:"کرج", phone:"0901xxxxxxx", desc:"زیر گارانتی شرکت، تصادفی نیست.", owner:"seed"},
  {id:6, type:"moto", brand:"باجاج", model:"200NS", year:1399, price:210, km:30000, city:"شیراز", phone:"0917xxxxxxx", desc:"لوازم اورجینال، بدون افتادگی.", owner:"seed"},
];

/* ============ STORAGE ============ */
function loadListings(){
  try{
    const raw = localStorage.getItem('karevan_listings');
    return raw ? JSON.parse(raw) : seedListings;
  }catch(e){ return seedListings; }
}
function saveListings(list){ localStorage.setItem('karevan_listings', JSON.stringify(list)); }

function loadUsers(){
  try{ return JSON.parse(localStorage.getItem('karevan_users')||'[]'); }catch(e){ return []; }
}
function saveUsers(u){ localStorage.setItem('karevan_users', JSON.stringify(u)); }

function loadSession(){
  try{ return JSON.parse(localStorage.getItem('karevan_session')||'null'); }catch(e){ return null; }
}
function saveSession(s){ s ? localStorage.setItem('karevan_session', JSON.stringify(s)) : localStorage.removeItem('karevan_session'); }

/* ============ THEME ============ */
function loadTheme(){ return localStorage.getItem('karevan_theme') || 'dark'; }
function applyTheme(theme){
  document.documentElement.setAttribute('data-theme', theme);
  localStorage.setItem('karevan_theme', theme);
}
function initTheme(){
  applyTheme(loadTheme());
  document.getElementById('themeToggle').addEventListener('click', ()=>{
    const current = document.documentElement.getAttribute('data-theme');
    applyTheme(current === 'dark' ? 'light' : 'dark');
  });
}

/* ============ STATE ============ */
let listings = loadListings();
let currentUser = loadSession();
let authMode = 'login';
let adType = 'car';

/* ============ HELPERS ============ */
function toman(n){
  n = Number(n);
  return n >= 1000 ? (n/1000).toLocaleString('fa-IR',{maximumFractionDigits:1})+' میلیارد' : n.toLocaleString('fa-IR')+' میلیون';
}
function fa(n){ return Number(n).toLocaleString('fa-IR'); }
function showToast(msg){
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.classList.add('show');
  setTimeout(()=>t.classList.remove('show'), 2200);
}
function openModal(id){ document.getElementById(id).classList.add('show'); document.body.style.overflow='hidden'; }
function closeModal(id){ document.getElementById(id).classList.remove('show'); document.body.style.overflow=''; }

function bindModalCloseEvents(){
  document.querySelectorAll('[data-close]').forEach(b=>{
    b.addEventListener('click', ()=> closeModal(b.dataset.close));
  });
  document.querySelectorAll('.overlay').forEach(o=>{
    o.addEventListener('click', e=>{ if(e.target === o) closeModal(o.id); });
  });
}

/* ============ BRAND FILTER OPTIONS ============ */
function refreshBrandOptions(){
  const type = document.getElementById('fType').value;
  const sel = document.getElementById('fBrand');
  const brands = type === 'moto' ? BRANDS_MOTO : type === 'car' ? BRANDS_CAR : [...BRANDS_CAR, ...BRANDS_MOTO];
  const current = sel.value;
  sel.innerHTML = '<option value="">برند: همه</option>' + brands.map(b=>`<option value="${b}">${b}</option>`).join('');
  if(brands.includes(current)) sel.value = current;
}

/* ============ RENDER LISTINGS ============ */
function renderListings(){
  const search = document.getElementById('fSearch').value.trim().toLowerCase();
  const type = document.getElementById('fType').value;
  const brand = document.getElementById('fBrand').value;
  const min = parseFloat(document.getElementById('fPriceMin').value);
  const max = parseFloat(document.getElementById('fPriceMax').value);

  let filtered = listings.filter(l=>{
    if(type && l.type !== type) return false;
    if(brand && l.brand !== brand) return false;
    if(!isNaN(min) && l.price < min) return false;
    if(!isNaN(max) && l.price > max) return false;
    if(search && !(l.brand+l.model).toLowerCase().includes(search)) return false;
    return true;
  }).sort((a,b)=> b.id - a.id);

  const grid = document.getElementById('listingGrid');
  document.getElementById('resultCount').textContent = filtered.length + ' آگهی';

  if(filtered.length === 0){
    grid.innerHTML = `<div class="empty" style="grid-column:1/-1;"><div class="ico">🔍</div>چیزی با این فیلترها پیدا نشد<br>فیلترها رو تغییر بده یا پاک کن.</div>`;
    return;
  }

  grid.innerHTML = filtered.map(l=>{
    const icon = l.type==='car' ? '🚗' : '🏍️';
    const mediaClass = l.type==='car' ? 'media-car' : 'media-moto';
    const badgeClass = l.type==='car' ? 'badge-car' : 'badge-moto';
    return `
    <div class="card" data-id="${l.id}">
      <div class="card-media ${mediaClass}">
        ${icon}
        <span class="badge ${badgeClass}">${l.type==='car'?'خودرو':'موتورسیکلت'}</span>
      </div>
      <div class="card-body">
        <div class="card-title">${l.brand} ${l.model}</div>
        <div class="card-sub">مدل ${fa(l.year)} · ${l.city}</div>
        <div class="card-meta">
          <span>📍 ${l.city}</span>
          <span>⏱️ ${fa(l.km)} کیلومتر</span>
        </div>
        <div class="card-price">
          <span style="font-size:12px;color:var(--muted);">قیمت</span>
          <span class="price-val">${toman(l.price)} تومان</span>
        </div>
      </div>
    </div>`;
  }).join('');

  grid.querySelectorAll('.card').forEach(c=>{
    c.addEventListener('click', ()=> openDetail(parseInt(c.dataset.id)));
  });
}

function updateStats(){
  document.getElementById('statTotal').textContent = fa(listings.length);
  document.getElementById('statCar').textContent = fa(listings.filter(l=>l.type==='car').length);
  document.getElementById('statMoto').textContent = fa(listings.filter(l=>l.type==='moto').length);
}

/* ============ DETAIL MODAL ============ */
function openDetail(id){
  const l = listings.find(x=>x.id===id);
  if(!l) return;
  const icon = l.type==='car' ? '🚗' : '🏍️';
  const mediaClass = l.type==='car' ? 'media-car' : 'media-moto';
  document.getElementById('detailContent').innerHTML = `
    <div class="detail-hero ${mediaClass}">${icon}</div>
    <h3 style="font-size:20px; font-weight:800; margin-bottom:4px;">${l.brand} ${l.model}</h3>
    <p style="color:var(--muted); font-size:13.5px;">مدل ${fa(l.year)} · ${l.city}</p>
    <div class="detail-grid">
      <div class="detail-item"><span>قیمت</span><b>${toman(l.price)} تومان</b></div>
      <div class="detail-item"><span>کارکرد</span><b>${fa(l.km)} کیلومتر</b></div>
      <div class="detail-item"><span>سال</span><b>${fa(l.year)}</b></div>
      <div class="detail-item"><span>شهر</span><b>${l.city}</b></div>
    </div>
    <p style="font-size:13.5px; line-height:1.9; color:var(--muted); margin-bottom:16px;">${l.desc || 'بدون توضیحات.'}</p>
    <button class="btn btn-amber" style="width:100%;" id="callBtn">📞 نمایش شماره تماس</button>
  `;
  document.getElementById('callBtn').onclick = function(){
    this.textContent = '📞 ' + l.phone;
  };
  openModal('detailOverlay');
}

/* ============ ADD AD ============ */
function initAddAdFlow(){
  document.querySelectorAll('.ad-type').forEach(b=>{
    b.addEventListener('click', ()=>{
      document.querySelectorAll('.ad-type').forEach(x=>x.classList.remove('active'));
      b.classList.add('active');
      adType = b.dataset.val;
    });
  });

  document.getElementById('btnAddAd').addEventListener('click', ()=>{
    if(!currentUser){
      showToast('برای ثبت آگهی اول وارد حساب شو');
      openModal('authOverlay');
      return;
    }
    openModal('addOverlay');
  });

  document.getElementById('addForm').addEventListener('submit', e=>{
    e.preventDefault();
    const errBox = document.getElementById('addErr');
    errBox.style.display = 'none';

    const brand = document.getElementById('adBrand').value.trim();
    const model = document.getElementById('adModel').value.trim();
    const year = parseInt(document.getElementById('adYear').value);
    const km = parseInt(document.getElementById('adKm').value);
    const price = parseFloat(document.getElementById('adPrice').value);
    const city = document.getElementById('adCity').value.trim();
    const phone = document.getElementById('adPhone').value.trim();
    const desc = document.getElementById('adDesc').value.trim();

    if(!brand || !model || !year || !km || !price || !city || !phone){
      errBox.textContent = 'لطفا همه فیلدهای ضروری رو پر کن.';
      errBox.style.display = 'block';
      return;
    }

    const newAd = {
      id: Date.now(),
      type: adType, brand, model, year, km, price, city, phone, desc,
      owner: currentUser.email
    };
    listings.push(newAd);
    saveListings(listings);
    refreshBrandOptions();
    renderListings();
    updateStats();
    closeModal('addOverlay');
    document.getElementById('addForm').reset();
    showToast('آگهی با موفقیت ثبت شد ✅');
  });
}

/* ============ FILTERS ============ */
function initFilters(){
  ['fSearch','fType','fBrand','fPriceMin','fPriceMax'].forEach(id=>{
    document.getElementById(id).addEventListener('input', ()=>{
      if(id === 'fType') refreshBrandOptions();
      renderListings();
    });
  });
  document.getElementById('btnResetFilter').addEventListener('click', ()=>{
    document.getElementById('fSearch').value='';
    document.getElementById('fType').value='';
    document.getElementById('fPriceMin').value='';
    document.getElementById('fPriceMax').value='';
    refreshBrandOptions();
    renderListings();
  });
}

/* ============ AUTH ============ */
function initAuth(){
  document.querySelectorAll('.auth-tab').forEach(b=>{
    b.addEventListener('click', ()=>{
      document.querySelectorAll('.auth-tab').forEach(x=>x.classList.remove('active'));
      b.classList.add('active');
      authMode = b.dataset.val;
      document.getElementById('authTitle').textContent = authMode==='login' ? 'ورود به حساب' : 'ساخت حساب کاربری';
      document.getElementById('authSubmitBtn').textContent = authMode==='login' ? 'ورود' : 'ثبت‌نام';
      document.getElementById('nameField').classList.toggle('hidden', authMode==='login');
      document.getElementById('authErr').style.display='none';
    });
  });

  document.getElementById('btnAccount').addEventListener('click', ()=>{
    if(currentUser){ openAccount(); }
    else{ authMode='login'; openModal('authOverlay'); }
  });

  document.getElementById('authForm').addEventListener('submit', e=>{
    e.preventDefault();
    const errBox = document.getElementById('authErr');
    errBox.style.display = 'none';
    const email = document.getElementById('authEmail').value.trim().toLowerCase();
    const pass = document.getElementById('authPass').value;
    let users = loadUsers();

    if(authMode === 'signup'){
      const name = document.getElementById('authName').value.trim();
      if(!name){ errBox.textContent='نام رو وارد کن.'; errBox.style.display='block'; return; }
      if(users.find(u=>u.email===email)){
        errBox.textContent = 'این ایمیل قبلا ثبت‌نام کرده. وارد شو.';
        errBox.style.display = 'block';
        return;
      }
      const user = {name, email, pass};
      users.push(user);
      saveUsers(users);
      currentUser = {name, email};
      saveSession(currentUser);
      showToast('خوش اومدی ' + name + '! 🎉');
    } else {
      const found = users.find(u=>u.email===email && u.pass===pass);
      if(!found){
        errBox.textContent = 'ایمیل یا رمز عبور اشتباهه.';
        errBox.style.display = 'block';
        return;
      }
      currentUser = {name: found.name, email: found.email};
      saveSession(currentUser);
      showToast('خوش اومدی ' + found.name + '!');
    }
    document.getElementById('authForm').reset();
    closeModal('authOverlay');
  });
}

/* ============ ACCOUNT ============ */
function openAccount(){
  const myAds = listings.filter(l => l.owner === currentUser.email);
  document.getElementById('accountContent').innerHTML = `
    <div class="acc-top">
      <div class="avatar">${currentUser.name.charAt(0)}</div>
      <div>
        <div style="font-weight:700; font-size:16px;">${currentUser.name}</div>
        <div style="font-size:12.5px; color:var(--muted);">${currentUser.email}</div>
      </div>
    </div>
    <div class="acc-card" style="margin-top:0; padding:14px;">
      <div style="font-weight:700; font-size:14px; margin-bottom:4px;">آگهی‌های من (${myAds.length})</div>
      ${myAds.length===0 ? '<p style="color:var(--muted); font-size:13px; padding:10px 0;">هنوز آگهی‌ای ثبت نکردی.</p>' :
        myAds.map(l=>`
          <div class="my-list-item">
            <div>
              <div style="font-weight:600; font-size:13.5px;">${l.brand} ${l.model}</div>
              <div style="font-size:11.5px; color:var(--muted);">${toman(l.price)} تومان</div>
            </div>
            <button class="btn btn-ghost" data-del="${l.id}" style="padding:6px 12px; font-size:12px;">حذف</button>
          </div>
        `).join('')
      }
    </div>
    <button class="btn btn-ghost" id="logoutBtn" style="width:100%; margin-top:16px;">خروج از حساب</button>
  `;
  document.getElementById('logoutBtn').onclick = ()=>{
    currentUser = null;
    saveSession(null);
    closeModal('accountOverlay');
    showToast('از حساب خارج شدی.');
  };
  document.querySelectorAll('[data-del]').forEach(btn=>{
    btn.onclick = ()=>{
      const id = parseInt(btn.dataset.del);
      listings = listings.filter(l=>l.id!==id);
      saveListings(listings);
      renderListings();
      updateStats();
      openAccount();
      showToast('آگهی حذف شد.');
    };
  });
  openModal('accountOverlay');
}

/* ============ INIT ============ */
function init(){
  initTheme();
  bindModalCloseEvents();
  initFilters();
  initAddAdFlow();
  initAuth();
  refreshBrandOptions();
  renderListings();
  updateStats();
}
document.addEventListener('DOMContentLoaded', init);
