document.addEventListener("DOMContentLoaded", function () {
  // ۱. کنترل پنل فیلتر پیشرفته
  const toggleBtn = document.getElementById("btnToggleAdvanced");
  const advancedPanel = document.getElementById("advancedFilterPanel");

  if (toggleBtn && advancedPanel) {
    toggleBtn.addEventListener("click", function () {
      advancedPanel.classList.toggle("open");
      toggleBtn.classList.toggle("active");
    });

    const urlParams = new URLSearchParams(window.location.search);
    if (
      urlParams.get("fType") ||
      urlParams.get("fBrand") ||
      urlParams.get("fPriceMin") ||
      urlParams.get("fPriceMax")
    ) {
      advancedPanel.classList.add("open");
      toggleBtn.classList.add("active");
    }
  }

  // ۲. کنترل دکمه ریست فیلتر
  const resetBtn = document.getElementById("btnResetFilter");
  if (resetBtn) {
    resetBtn.addEventListener("click", function (e) {
      e.preventDefault();
      // خواندن آدرس از خود دکمه یا هدایت به صفحه اصلی
      const resetUrl = resetBtn.getAttribute("href") || window.location.pathname;
      window.location.href = resetUrl;
    });
  }

  // ۳. مقداردهی تعداد آگهی‌ها (در صورتی که مقدار توسط متغیر JS یا HTML تنظیم نشده باشد)
  const resultCount = document.getElementById("resultCount");
  if (resultCount && window.totalFilteredCount !== undefined) {
    resultCount.textContent = window.totalFilteredCount + " آگهی";
  }
});