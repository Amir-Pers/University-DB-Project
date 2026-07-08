document.addEventListener("DOMContentLoaded", () => {

    const deletedInput = document.getElementById("deleted-images");

    if (!deletedInput)
        return;

    const deletedImages = [];

    document.querySelectorAll(".remove-existing-image").forEach(button => {

        button.addEventListener("click", function () {

            const imageId = this.dataset.imageId;

            deletedImages.push(imageId);

            deletedInput.value = deletedImages.join(",");

            this.closest(".existing-image").remove();

        });

    });

});