document.addEventListener("DOMContentLoaded", () => {

    const vehicleTypeSelect = document.getElementById("vehicle_type");
    const brandSelect = document.getElementById("car_brand");
    const modelSelect = document.getElementById("car_model");

    if (!vehicleTypeSelect || !brandSelect || !modelSelect)
        return;

    // -------------------------
    // بارگذاری برندها
    // -------------------------

    vehicleTypeSelect.addEventListener("change", async function () {

        const type = this.value;

        brandSelect.innerHTML =
            '<option>در حال بارگذاری...</option>';

        modelSelect.innerHTML =
            '<option>ابتدا برند را انتخاب کنید...</option>';

        const category = this.value;

        const response =
            await fetch(`/vehicles/brands/?category=${encodeURIComponent(category)}`);

        const brands = await response.json();

        brandSelect.innerHTML =
            '<option value="">انتخاب برند...</option>';

        brands.forEach(brand => {

            brandSelect.innerHTML +=
                `<option value="${brand.id}">${brand.name}</option>`;

        });

    });

    // -------------------------
    // بارگذاری مدل ها
    // -------------------------

    brandSelect.addEventListener("change", async function () {

        const brandId = this.value;

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

    });

    // بارگذاری اولیه برندهای خودرو
    vehicleTypeSelect.dispatchEvent(new Event("change"));

});