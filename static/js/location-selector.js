document.addEventListener("DOMContentLoaded", () => {

    const provinceSelect =
        document.getElementById("province") ||
        document.getElementById("state");

    const citySelect =
        document.getElementById("city");

    if (!provinceSelect || !citySelect)
        return;

    const initial = window.initialAddress || {};

    // -------------------------
    // بارگذاری شهرها
    // -------------------------

    provinceSelect.addEventListener("change", async function () {

        const provinceId = this.value;

        if (!provinceId) {

            citySelect.innerHTML =
                '<option value="">انتخاب شهر...</option>';

            return;
        }

        citySelect.innerHTML =
            '<option value="">در حال بارگذاری...</option>';

        const response = await fetch(
            `/locations/cities/?province=${provinceId}`
        );

        const cities = await response.json();

        citySelect.innerHTML =
            '<option value="">انتخاب شهر...</option>';

        cities.forEach(city => {

            citySelect.innerHTML +=
                `<option value="${city.id}">${city.name}</option>`;

        });

        // اگر در حالت ویرایش هستیم
        if (initial.cityId) {

            citySelect.value = initial.cityId;

            // فقط یک بار انجام شود
            initial.cityId = null;
        }

    });

    // -------------------------
    // مقدار اولیه
    // -------------------------

    if (initial.provinceId) {

        provinceSelect.value = initial.provinceId;

        provinceSelect.dispatchEvent(
            new Event("change")
        );

    }

});