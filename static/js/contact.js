/* ==================================================
   UTILITY FUNCTIONS
   ================================================== */

/**
 * نمایش پیام موقت (Toast)
 */
function showToast(msg) {
  let t = document.getElementById("toast");
  
  if (!t) {
    t = document.createElement("div");
    t.id = "toast";
    t.className = "toast";
    document.body.appendChild(t);
  }

  t.textContent = msg;
  t.classList.add("show");
  setTimeout(() => t.classList.remove("show"), 3000);
}

/**
 * دریافت CSRF Token از کوکی
 */
function getCSRFToken() {
  const cookieValue = document.cookie
    .split('; ')
    .find(row => row.startsWith('csrftoken='));
  return cookieValue ? cookieValue.split('=')[1] : '';
}

/* ==================================================
   CONTACT FORM MODULE (با AJAX)
   ================================================== */

function initContactForm() {
  const form = document.getElementById("contactForm");
  const errBox = document.getElementById("contactErr");
  const formWrap = document.getElementById("formWrap");
  const successBox = document.getElementById("formSuccess");
  const anotherBtn = document.getElementById("btnAnotherMsg");

  if (!form) return;

  form.addEventListener("submit", function(e) {
    e.preventDefault();

    // مخفی کردن خطاهای قبلی
    if (errBox) {
      errBox.style.display = "none";
      errBox.textContent = "";
    }

    // گرفتن دکمه ارسال
    const submitBtn = form.querySelector('button[type="submit"]');
    
    // غیرفعال کردن دکمه و تغییر متن آن
    submitBtn.disabled = true;
    submitBtn.textContent = 'در حال ارسال...';

    // ایجاد FormData از فرم
    const formData = new FormData(form);

    // ارسال درخواست AJAX با fetch
    fetch(form.action, {
      method: 'POST',
      body: formData,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',  // برای تشخیص AJAX در سرور
        'X-CSRFToken': getCSRFToken(),         // ارسال CSRF Token
      },
    })
    .then(response => {
      // بررسی وضعیت پاسخ
      if (!response.ok) {
        return response.json().then(data => {
          throw data;
        });
      }
      return response.json();
    })
    .then(data => {
      if (data.success) {
        // موفقیت: نمایش پیام موفقیت
        if (formWrap) formWrap.style.display = "none";
        if (successBox) successBox.style.display = "block";
        showToast("✅ پیامت با موفقیت ارسال شد");
        form.reset();  // پاک کردن فرم
      } else {
        // خطا: نمایش پیام خطا
        if (errBox) {
          errBox.textContent = data.message || '❌ خطا در ارسال پیام';
          errBox.style.display = "block";
        }
        showToast("❌ خطا در ارسال پیام");
      }
    })
    .catch(error => {
      // نمایش خطاهای سرور یا شبکه
      let errorMsg = '❌ خطا در ارتباط با سرور';
      if (error.errors && Array.isArray(error.errors)) {
        errorMsg = error.errors.join(' | ');
      } else if (error.message) {
        errorMsg = error.message;
      }
      
      if (errBox) {
        errBox.textContent = errorMsg;
        errBox.style.display = "block";
      }
      showToast("❌ خطا در ارسال پیام");
    })
    .finally(() => {
      // فعال کردن مجدد دکمه ارسال
      submitBtn.disabled = false;
      submitBtn.textContent = 'ارسال پیام';
    });
  });

  // دکمه "ارسال پیام دیگر"
  if (anotherBtn) {
    anotherBtn.addEventListener("click", function() {
      if (successBox) successBox.style.display = "none";
      if (formWrap) formWrap.style.display = "block";
      form.reset();
      // پاک کردن خطاها
      if (errBox) {
        errBox.style.display = "none";
        errBox.textContent = "";
      }
    });
  }
}
/* ==================================================
   CONTACT FORM MODULE (با دریافت خطاهای سرور)
   ================================================== */

function initContactForm() {
  const form = document.getElementById("contactForm");
  const errBox = document.getElementById("contactErr");
  const formWrap = document.getElementById("formWrap");
  const successBox = document.getElementById("formSuccess");
  const anotherBtn = document.getElementById("btnAnotherMsg");

  if (!form) return;

  form.addEventListener("submit", function(e) {
    e.preventDefault();

    // پاک کردن خطاهای قبلی
    if (errBox) {
      errBox.style.display = "none";
      errBox.textContent = "";
    }
    
    // پاک کردن خطاهای کنار هر فیلد (اگر داری)
    document.querySelectorAll('.field-error').forEach(el => el.remove());
    document.querySelectorAll('.form-control.error').forEach(el => el.classList.remove('error'));

    const submitBtn = form.querySelector('button[type="submit"]');
    submitBtn.disabled = true;
    submitBtn.textContent = 'در حال ارسال...';

    const formData = new FormData(form);

    fetch(form.action, {
      method: 'POST',
      body: formData,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRFToken': getCSRFToken(),
      },
    })
    .then(response => {
      if (!response.ok) {
        return response.json().then(data => {
          throw data;
        });
      }
      return response.json();
    })
    .then(data => {
      if (data.success) {
        // موفقیت
        if (formWrap) formWrap.style.display = "none";
        if (successBox) successBox.style.display = "block";
        showToast("✅ پیامت با موفقیت ارسال شد");
        form.reset();
      } else {
        // نمایش خطاهای دریافتی از سرور
        if (data.errors) {
          displayServerErrors(data.errors);
        } else {
          // اگر خطای کلی وجود داشت
          if (errBox) {
            errBox.textContent = data.message || '❌ خطا در ارسال پیام';
            errBox.style.display = "block";
          }
        }
        showToast("❌ لطفاً خطاها را برطرف کنید");
      }
    })
    .catch(error => {
      // خطای شبکه یا سرور
      let errorMsg = '❌ خطا در ارتباط با سرور';
      if (error.errors) {
        displayServerErrors(error.errors);
        errorMsg = '❌ لطفاً خطاها را برطرف کنید';
      } else if (error.message) {
        errorMsg = error.message;
      }
      
      if (errBox && !error.errors) {
        errBox.textContent = errorMsg;
        errBox.style.display = "block";
      }
      showToast("❌ خطا در ارسال پیام");
    })
    .finally(() => {
      submitBtn.disabled = false;
      submitBtn.textContent = 'ارسال پیام';
    });
  });

  // تابع نمایش خطاهای سرور در کنار هر فیلد
  function displayServerErrors(errors) {
    // نمایش خطا در باکس عمومی
    if (errBox) {
      const errorMessages = Object.values(errors).join(' | ');
      errBox.textContent = '❌ ' + errorMessages;
      errBox.style.display = "block";
    }

    for (const [fieldName, errorMessage] of Object.entries(errors)) {
      // پیدا کردن فیلد مربوطه با attribute name
      const field = document.querySelector(`[name="${fieldName}"]`);
      if (field) {
        // اضافه کردن کلاس خطا
        field.classList.add('error');
        
        // ایجاد المان نمایش خطا در کنار فیلد
        const errorEl = document.createElement('div');
        errorEl.className = 'field-error';
        errorEl.textContent = '⚠️ ' + errorMessage;
        errorEl.style.cssText = 'color: #dc3545; font-size: 13px; margin-top: 4px;';
        
        // قرار دادن خطا بعد از فیلد
        field.parentNode.appendChild(errorEl);
      }
    }
  }

  // دکمه "ارسال پیام دیگر"
  if (anotherBtn) {
    anotherBtn.addEventListener("click", function() {
      if (successBox) successBox.style.display = "none";
      if (formWrap) formWrap.style.display = "block";
      form.reset();
      // پاک کردن خطاها
      if (errBox) {
        errBox.style.display = "none";
        errBox.textContent = "";
      }
      document.querySelectorAll('.field-error').forEach(el => el.remove());
      document.querySelectorAll('.form-control.error').forEach(el => el.classList.remove('error'));
    });
  }
}

/* ==================================================
   UTILITY FUNCTIONS
   ================================================== */

function getCSRFToken() {
  const cookieValue = document.cookie
    .split('; ')
    .find(row => row.startsWith('csrftoken='));
  return cookieValue ? cookieValue.split('=')[1] : '';
}

function showToast(msg) {
  let t = document.getElementById("toast");
  if (!t) {
    t = document.createElement("div");
    t.id = "toast";
    t.className = "toast";
    document.body.appendChild(t);
  }
  t.textContent = msg;
  t.classList.add("show");
  setTimeout(() => t.classList.remove("show"), 3000);
}

/* ==================================================
   FAQ ACCORDION MODULE
   ================================================== */

function initFaq() {
  const faqItems = document.querySelectorAll(".faq-item");

  faqItems.forEach((item) => {
    const question = item.querySelector(".faq-q");
    const answer = item.querySelector(".faq-a");

    if (!question || !answer) return;

    question.addEventListener("click", () => {
      const isOpen = item.classList.contains("open");

      // بستن سایر آکاردئون‌های باز
      document.querySelectorAll(".faq-item.open").forEach((other) => {
        if (other !== item) {
          other.classList.remove("open");
          const otherAnswer = other.querySelector(".faq-a");
          if (otherAnswer) otherAnswer.style.maxHeight = null;
        }
      });

      if (isOpen) {
        item.classList.remove("open");
        answer.style.maxHeight = null;
      } else {
        item.classList.add("open");
        answer.style.maxHeight = answer.scrollHeight + 40 + "px";
      }
    });
  });
}

/* ==================================================
   MAIN INITIALIZATION
   ================================================== */

function init() {
  initContactForm();
  initFaq();

  const yearElement = document.getElementById("footYear");
  if (yearElement) {
    yearElement.textContent = new Date().getFullYear().toLocaleString("fa-IR");
  }
}

document.addEventListener("DOMContentLoaded", init);