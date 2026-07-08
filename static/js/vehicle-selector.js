document.addEventListener("DOMContentLoaded", () => {

    const vehicleTypeSelect = document.getElementById("vehicle_type");
    const brandSelect = document.getElementById("car_brand");
    const modelSelect = document.getElementById("car_model");

    if (!vehicleTypeSelect || !brandSelect || !modelSelect)
        return;

    const initial = window.initialVehicle || {};

    // -------------------------
    // بارگذاری برندها
    // -------------------------

    vehicleTypeSelect.addEventListener("change", async function () {

        brandSelect.innerHTML =
            '<option>در حال بارگذاری...</option>';

        modelSelect.innerHTML =
            '<option>ابتدا برند را انتخاب کنید...</option>';

        const response =
            await fetch(`/vehicles/brands/?category=${encodeURIComponent(this.value)}`);

        const brands = await response.json();

        brandSelect.innerHTML =
            '<option value="">انتخاب برند...</option>';

        brands.forEach(brand => {

            brandSelect.innerHTML +=
                `<option value="${brand.id}">${brand.name}</option>`;

        });

        // اگر در حالت ویرایش هستیم
        if (initial.brandId) {

            brandSelect.value = initial.brandId;
            brandSelect.dispatchEvent(new Event("change"));

            // فقط یک بار انجام شود
            initial.brandId = null;
        }

    });

    // -------------------------
    // بارگذاری مدل ها
    // -------------------------

    brandSelect.addEventListener("change", async function () {

        const brandId = this.value;

        if (!brandId) {

            modelSelect.innerHTML =
                '<option value="">ابتدا برند را انتخاب کنید...</option>';

            return;
        }

        modelSelect.innerHTML =
            '<option>در حال بارگذاری...</option>';

        const response =
            await fetch(`/vehicles/models/?brand=${brandId}`);

        const models = await response.json();

        modelSelect.innerHTML =
            '<option value="">انتخاب مدل...</option>';

        models.forEach(model => {

            modelSelect.innerHTML +=
                `<option value="${model.id}">${model.name}</option>`;

        });

        // اگر در حالت ویرایش هستیم
        if (initial.modelId) {

            modelSelect.value = initial.modelId;

            // فقط یک بار انجام شود
            initial.modelId = null;
        }

    });

    // -------------------------
    // مقدار اولیه
    // -------------------------

    vehicleTypeSelect.value =
        initial.vehicleType || "car";

    vehicleTypeSelect.dispatchEvent(
        new Event("change")
    );

});