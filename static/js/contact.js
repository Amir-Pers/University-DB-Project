/* ==================================================
   UTILITY FUNCTIONS
   ================================================== */

/**
 * نمایش پیام موقت (Toast)
 */
function showToast(msg) {
  let t = document.getElementById("toast");
  
  // ساخت المان Toast در صورت عدم وجود در صفحه
  if (!t) {
    t = document.createElement("div");
    t.id = "toast";
    t.className = "toast";
    document.body.appendChild(t);
  }

  t.textContent = msg;
  t.classList.add("show");
  setTimeout(() => t.classList.remove("show"), 2200);
}

/* ==================================================
   CONTACT FORM MODULE
   ================================================== */

function initContactForm() {
  const form = document.getElementById("contactForm");
  const errBox = document.getElementById("contactErr");
  const formWrap = document.getElementById("formWrap");
  const successBox = document.getElementById("formSuccess");
  const anotherBtn = document.getElementById("btnAnotherMsg");

  if (!form) return;

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    if (errBox) errBox.style.display = "none";

    const name = document.getElementById("cName")?.value.trim();
    const phone = document.getElementById("cPhone")?.value.trim();
    const email = document.getElementById("cEmail")?.value.trim();
    const message = document.getElementById("cMessage")?.value.trim();

    if (!name || !phone || !email || !message) {
      if (errBox) {
        errBox.textContent = "لطفا همه فیلدهای ضروری رو پر کن.";
        errBox.style.display = "block";
      }
      return;
    }

    if (formWrap) formWrap.style.display = "none";
    if (successBox) successBox.style.display = "block";
    showToast("پیامت با موفقیت ارسال شد ✅");
  });

  if (anotherBtn) {
    anotherBtn.addEventListener("click", () => {
      form.reset();
      if (successBox) successBox.style.display = "none";
      if (formWrap) formWrap.style.display = "block";
    });
  }
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