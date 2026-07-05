document.addEventListener("DOMContentLoaded", () => {

    const provinceSelect = document.getElementById("province");
    const citySelect = document.getElementById("city");

    if (!provinceSelect || !citySelect)
        return;

    provinceSelect.addEventListener("change", async function () {

        const provinceId = this.value;

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

    });

});