document.addEventListener("DOMContentLoaded", () => {

    document.querySelectorAll(".toggle-ad-status").forEach(toggle => {

        toggle.addEventListener("change", async function () {

            const previousState = !this.checked;

            try {

                const response = await fetch(
                    `/advertisements/toggle-status/${this.dataset.adId}/`,
                    {
                        method: "POST",
                        headers: {
                            "X-CSRFToken": getCookie("csrftoken"),
                        },
                    }
                );

                const data = await response.json();

                if (!data.success) {

                    this.checked = previousState;
                    alert("خطا در بروزرسانی وضعیت آگهی.");

                }

            } catch (error) {

                this.checked = previousState;
                alert("ارتباط با سرور برقرار نشد.");

            }

        });

    });

});


function getCookie(name) {

    let cookieValue = null;

    if (document.cookie && document.cookie !== "") {

        const cookies = document.cookie.split(";");

        for (let cookie of cookies) {

            cookie = cookie.trim();

            if (cookie.startsWith(name + "=")) {

                cookieValue = decodeURIComponent(
                    cookie.substring(name.length + 1)
                );

                break;
            }
        }
    }

    return cookieValue;
}