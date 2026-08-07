document.addEventListener("DOMContentLoaded", function() {

  // مدیریت نمایش و پنهان‌سازی شماره تماس
  const btn = document.getElementById("showPhoneBtn");
  const phone = document.getElementById("phoneBox");

  if (btn && phone) {
    btn.addEventListener("click", function() {
      if (phone.style.display === "none" || phone.style.display === "") {
        phone.style.display = "block";
        btn.textContent = "🙈 پنهان کردن شماره تماس";
      } else {
        phone.style.display = "none";
        btn.textContent = "📞 نمایش شماره تماس";
      }
    });
  }

  // مدیریت دکمه علاقه‌مندی‌ها (AJAX)
  const favBtn = document.getElementById("favoriteBtn");
  if (favBtn) {
    favBtn.addEventListener("click", function(e) {
      e.preventDefault();
      const url = this.dataset.url;

      fetch(url, {
        method: 'POST',
        headers: {
          'X-CSRFToken': window.csrfToken || '',
          'Content-Type': 'application/json'
        }
      })
      .then(response => {
        if (!response.ok) {
          if (response.status === 401 || response.status === 403) {
            alert("لطفاً ابتدا وارد حساب کاربری خود شوید.");
            return;
          }
          throw new Error("Request failed");
        }
        return response.json();
      })
      .then(data => {
        if (data && data.status === 'ok') {
          const heartIcon = favBtn.querySelector(".heart-icon");

          if (data.is_favorite) {
            heartIcon.textContent = "❤️";
            favBtn.setAttribute("title", "حذف از علاقه‌مندی‌ها");
          } else {
            heartIcon.textContent = "🤍";
            favBtn.setAttribute("title", "افزودن به علاقه‌مندی‌ها");
          }
        }
      })
      .catch(err => {
        console.error("خطا در ارسال درخواست:", err);
      });
    });
  }

});

// تعویض عکس اصلی گالری
function changeImage(el, index) {
  document.getElementById("mainImage").src = el.src;
  document.querySelectorAll(".thumb").forEach(function(img) {
    img.classList.remove("active");
  });
  el.classList.add("active");

  const counter = document.getElementById("imageCounter");
  if (counter) {
    const total = document.querySelectorAll(".thumb").length;
    counter.textContent = toPersianDigits(index) + " از " + toPersianDigits(total);
  }
}

// تبدیل ارقام انگلیسی به فارسی
function toPersianDigits(num) {
  const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  return String(num).replace(/[0-9]/g, function(d) {
    return persian[d];
  });
}