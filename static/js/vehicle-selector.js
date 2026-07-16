document.addEventListener("DOMContentLoaded", () => {

    // تشخیص صفحه
    const isPostAd = document.getElementById("vehicle_type") !== null;
    const isHome = document.getElementById("fType") !== null;

    if (!isPostAd && !isHome)
        return;

    // انتخاب المنت‌های مناسب
    const vehicleTypeSelect = isPostAd
        ? document.getElementById("vehicle_type")
        : document.getElementById("fType");

    const brandSelect = isPostAd
        ? document.getElementById("car_brand")
        : document.getElementById("fBrand");

    const modelSelect = isPostAd
        ? document.getElementById("car_model")
        : document.getElementById("fModel");

    // فقط در صفحه ثبت آگهی وجود دارد
    const initial = window.initialVehicle || {};

    // -------------------------
    // بارگذاری برندها
    // -------------------------

    vehicleTypeSelect.addEventListener("change", async function () {

        const category = this.value;

        if (!category) {

            brandSelect.innerHTML =
                '<option value="">برند: همه</option>';

            if (modelSelect) {
                modelSelect.innerHTML =
                    '<option value="">مدل: همه</option>';
            }

            return;
        }

        brandSelect.innerHTML =
            '<option>در حال بارگذاری...</option>';

        if (modelSelect) {
            modelSelect.innerHTML = isPostAd
                ? '<option value="">ابتدا برند را انتخاب کنید...</option>'
                : '<option value="">مدل: همه</option>';
        }

        const response = await fetch(
            `/vehicles/brands/?category=${encodeURIComponent(category)}`
        );

        const brands = await response.json();

        brandSelect.innerHTML = isPostAd
            ? '<option value="">انتخاب برند...</option>'
            : '<option value="">برند: همه</option>';

        brands.forEach(brand => {

            brandSelect.innerHTML +=
                `<option value="${brand.id}">${brand.name}</option>`;

        });

        // حالت ویرایش آگهی
        if (isPostAd && initial.brandId) {

            brandSelect.value = initial.brandId;
            brandSelect.dispatchEvent(new Event("change"));

            initial.brandId = null;
        }

        // صفحه اصلی (برگشت فیلترها بعد از جستجو)
        if (isHome && window.selectedBrandId) {

            brandSelect.value = window.selectedBrandId;
            brandSelect.dispatchEvent(new Event("change"));

            window.selectedBrandId = null;
        }

    });

    // -------------------------
    // بارگذاری مدل‌ها
    // -------------------------

    brandSelect.addEventListener("change", async function () {

        const brandId = this.value;

        if (!brandId) {

            modelSelect.innerHTML = isPostAd
                ? '<option value="">ابتدا برند را انتخاب کنید...</option>'
                : '<option value="">مدل: همه</option>';

            return;
        }

        modelSelect.innerHTML =
            '<option>در حال بارگذاری...</option>';

        const response = await fetch(
            `/vehicles/models/?brand=${brandId}`
        );

        const models = await response.json();

        modelSelect.innerHTML = isPostAd
            ? '<option value="">انتخاب مدل...</option>'
            : '<option value="">مدل: همه</option>';

        models.forEach(model => {

            modelSelect.innerHTML +=
                `<option value="${model.id}">${model.name}</option>`;

        });

        // حالت ویرایش
        if (isPostAd && initial.modelId) {

            modelSelect.value = initial.modelId;
            initial.modelId = null;
        }

        // صفحه اصلی
        if (isHome && window.selectedModelId) {

            modelSelect.value = window.selectedModelId;
            window.selectedModelId = null;
        }

    });

    // -------------------------
    // مقدار اولیه
    // -------------------------

    if (isPostAd) {

        vehicleTypeSelect.value =
            initial.vehicleType || "car";

    } else {

        vehicleTypeSelect.value =
            window.selectedType || "";

    }

    vehicleTypeSelect.dispatchEvent(
        new Event("change")
    );

});