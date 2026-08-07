document.addEventListener("DOMContentLoaded", function () {
  
  // مدیریت تب‌های سایدبار
  const tabs = document.querySelectorAll(".sidebar-tab");
  const contents = document.querySelectorAll(".tab-content");

  function switchTab(tabId) {
    tabs.forEach(t => t.classList.remove("active"));
    contents.forEach(c => c.classList.remove("active"));

    const activeTabButton = document.querySelector(`.sidebar-tab[data-tab="${tabId}"]`);
    const activeContent = document.getElementById(tabId);

    if (activeTabButton && activeContent) {
      activeTabButton.classList.add("active");
      activeContent.classList.add("active");
      localStorage.setItem("activeDashboardTab", tabId);
    }
  }

  const savedTab = localStorage.getItem("activeDashboardTab") || "my-ads";
  switchTab(savedTab);

  tabs.forEach(tab => {
    tab.addEventListener("click", function () {
      const targetTab = this.getAttribute("data-tab");
      switchTab(targetTab);
    });
  });

  // مدیریت حذف از علاقه‌مندی‌ها با دکمه اختصاصی
  const removeFavBtns = document.querySelectorAll(".remove-favorite-btn");
  
  removeFavBtns.forEach(btn => {
    btn.addEventListener("click", function (e) {
      e.preventDefault();
      const adId = this.getAttribute("data-ad-id");
      const card = document.getElementById(`fav-card-${adId}`);
      const originalText = this.innerHTML;
      
      this.innerHTML = "در حال حذف...";
      this.style.pointerEvents = "none";

      fetch(`/advertisements/favorite/${adId}/`, {
        method: 'POST',
        headers: {
          'X-CSRFToken': window.csrfToken || '',
          'Content-Type': 'application/json'
        }
      })
      .then(response => {
        if (!response.ok) {
          throw new Error("اختلال در سرور");
        }
        return response.json();
      })
      .then(data => {
        if (data && data.status === 'ok' && !data.is_favorite) {
          if (card) {
            card.classList.add("card-removing");
            
            card.addEventListener("animationend", function () {
              card.remove();
              updateFavoriteCount();
            });
          }
        } else {
          this.innerHTML = originalText;
          this.style.pointerEvents = "auto";
        }
      })
      .catch(err => {
        console.error("خطا در ارسال درخواست:", err);
        this.innerHTML = originalText;
        this.style.pointerEvents = "auto";
      });
    });
  });

  // به‌روزرسانی شمارنده آگهی‌ها در تب علاقه‌مندی‌ها و مدیریت Empty State
  function updateFavoriteCount() {
    const container = document.getElementById("favorites-list-container");
    if (!container) return;

    const remainingCards = container.querySelectorAll(".premium-ad-card");
    const countBadge = document.getElementById("fav-count-badge");

    if (countBadge) {
      countBadge.textContent = toPersianDigits(remainingCards.length) + " آگهی";
    }

    if (remainingCards.length === 0) {
      const emptyStateHTML = `
        <div id="fav-empty-state" class="fav-empty-state" style="opacity: 0; transform: translateY(10px);">
          <div class="empty-icon">🤍</div>
          <h4>لیست علاقه‌مندی‌های شما خالی است</h4>
          <p>شما هنوز هیچ آگهی را نشان نکرده‌اید.</p>
        </div>
      `;
      container.innerHTML = emptyStateHTML;
      
      setTimeout(() => {
        const emptyState = document.getElementById("fav-empty-state");
        if (emptyState) {
          emptyState.style.opacity = "1";
          emptyState.style.transform = "translateY(0)";
        }
      }, 50);
    }
  }

  // تبدیل ارقام انگلیسی به فارسی
  function toPersianDigits(num) {
    const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return String(num).replace(/[0-9]/g, function (d) {
      return persian[d];
    });
  }

});