/* ==================================================
   UTILITY FUNCTIONS
   ================================================== */

/**
 * نمایش پیام موقت (Toast)
 */
function showToast(msg) {
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.classList.add('show');
  setTimeout(() => t.classList.remove('show'), 2200);
}


/* ==================================================
   THEME MODULE (همگام با سایت اصلی)
   ================================================== */

function loadTheme() {
  return localStorage.getItem('karevan_theme') || 'dark';
}

function applyTheme(theme) {
  document.documentElement.setAttribute('data-theme', theme);
  localStorage.setItem('karevan_theme', theme);
}

function initTheme() {
  applyTheme(loadTheme());

  const toggleBtn = document.getElementById('themeToggle');
  if (!toggleBtn) return; // اگر دکمه در صفحه نباشد، خطا ندهد

  toggleBtn.addEventListener('click', () => {
    const current = document.documentElement.getAttribute('data-theme');
    applyTheme(current === 'dark' ? 'light' : 'dark');
  });
}


/* ==================================================
   CONTACT FORM MODULE
   ================================================== */

function initContactForm() {
  const form = document.getElementById('contactForm');
  const errBox = document.getElementById('contactErr');
  const formWrap = document.getElementById('formWrap');
  const successBox = document.getElementById('formSuccess');
  const anotherBtn = document.getElementById('btnAnotherMsg');

  form.addEventListener('submit', (e) => {
    e.preventDefault();
    errBox.style.display = 'none';

    const name = document.getElementById('cName').value.trim();
    const phone = document.getElementById('cPhone').value.trim();
    const email = document.getElementById('cEmail').value.trim();
    const message = document.getElementById('cMessage').value.trim();

    if (!name || !phone || !email || !message) {
      errBox.textContent = 'لطفا همه فیلدهای ضروری رو پر کن.';
      errBox.style.display = 'block';
      return;
    }

    formWrap.style.display = 'none';
    successBox.style.display = 'block';
    showToast('پیامت با موفقیت ارسال شد ✅');
  });

  anotherBtn.addEventListener('click', () => {
    form.reset();
    successBox.style.display = 'none';
    formWrap.style.display = 'block';
  });
}


/* ==================================================
   FAQ ACCORDION MODULE
   ================================================== */

function initFaq() {
  const faqItems = document.querySelectorAll('.faq-item');

  faqItems.forEach((item) => {
    const question = item.querySelector('.faq-q');
    const answer = item.querySelector('.faq-a');

    question.addEventListener('click', () => {
      const isOpen = item.classList.contains('open');

      // بستن بقیه آیتم‌های باز
      document.querySelectorAll('.faq-item.open').forEach((other) => {
        if (other !== item) {
          other.classList.remove('open');
          other.querySelector('.faq-a').style.maxHeight = null;
        }
      });

      if (isOpen) {
        item.classList.remove('open');
        answer.style.maxHeight = null;
      } else {
        item.classList.add('open');
        answer.style.maxHeight = answer.scrollHeight + 40 + 'px';
      }
    });
  });
}


/* ==================================================
   MAIN INITIALIZATION
   ================================================== */

function init() {
  initTheme();
  initContactForm();
  initFaq();

  const yearElement = document.getElementById('footYear');
  if (yearElement) {
    yearElement.textContent = new Date().getFullYear().toLocaleString('fa-IR');
  }
}

document.addEventListener('DOMContentLoaded', init);