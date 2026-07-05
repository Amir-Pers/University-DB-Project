document.addEventListener("DOMContentLoaded", function () {
    // ============================================================
    //  STATE & CONSTANTS
    // ============================================================
    let currentStep = 1;
    const totalSteps = 7;
    let selectedFiles = [];

    // DOM references
    const stepCards = document.querySelectorAll('.wizard-step-card');
    const stepItems = document.querySelectorAll('.step-item');
    const btnNext = document.getElementById('btn-next');
    const btnPrev = document.getElementById('btn-prev');
    const btnSubmitFinal = document.getElementById('btn-submit-final');

    // ============================================================
    //  1.  ADDRESS FIELDS TOGGLE
    // ============================================================
    const addrDefaultRadio = document.getElementById('addr_type_default');
    const addrNewRadio = document.getElementById('addr_type_new');
    const defaultAddressBox = document.getElementById('default-address-box');
    const newAddressBox = document.getElementById('new-address-box');
    const stateSelect = document.getElementById('state');
    const citySelect = document.getElementById('city');

    function handleAddressFields() {
        if (addrNewRadio.checked) {
            newAddressBox.style.display = 'flex';
            defaultAddressBox.style.display = 'none';
            if (currentStep === 5) {
                stateSelect.setAttribute('required', 'required');
                citySelect.setAttribute('required', 'required');
            }
        } else {
            newAddressBox.style.display = 'none';
            defaultAddressBox.style.display = 'block';
            stateSelect.removeAttribute('required');
            citySelect.removeAttribute('required');
        }
    }

    addrDefaultRadio.addEventListener('change', handleAddressFields);
    addrNewRadio.addEventListener('change', handleAddressFields);

    // ============================================================
    //  2.  SELL TYPE DYNAMIC FIELDS
    // ============================================================
    const sellTypeSelect = document.getElementById('sell_type');
    const cashGroup = document.getElementById('sell-fields-cash');
    const installmentGroup = document.getElementById('sell-fields-installment');
    const draftGroup = document.getElementById('sell-fields-draft');
    const agreementGroup = document.getElementById('sell-fields-agreement');

    function handleSellTypeFields() {
        const type = sellTypeSelect.value;

        // Hide all groups
        cashGroup.style.display = 'none';
        installmentGroup.style.display = 'none';
        draftGroup.style.display = 'none';
        agreementGroup.style.display = 'none';

        // Remove required from all inputs inside groups
        const allSellInputs = document.querySelectorAll('.sell-type-group input, .sell-type-group select');
        allSellInputs.forEach(input => input.removeAttribute('required'));

        // Show selected group and set required attributes
        if (type === 'نقدی') {
            cashGroup.style.display = 'block';
            if (currentStep === 1) {
                document.getElementById('price').setAttribute('required', 'required');
            }
        } else if (type === 'اقساطی') {
            installmentGroup.style.display = 'block';
            if (currentStep === 1) {
                document.getElementById('pre_payment').setAttribute('required', 'required');
                document.getElementById('installment_amount').setAttribute('required', 'required');
                document.getElementById('payment_period').setAttribute('required', 'required');
                document.getElementById('installment_count').setAttribute('required', 'required');
                document.getElementById('delivery_time_inst').setAttribute('required', 'required');
            }
        } else if (type === 'حواله') {
            draftGroup.style.display = 'block';
            if (currentStep === 1) {
                document.getElementById('deposit_amount').setAttribute('required', 'required');
                document.getElementById('final_price').setAttribute('required', 'required');
                document.getElementById('delivery_time_draft').setAttribute('required', 'required');
            }
        } else if (type === 'توافقی') {
            agreementGroup.style.display = 'block';
        }
    }

    sellTypeSelect.addEventListener('change', handleSellTypeFields);
    handleSellTypeFields(); // initial call

    // ============================================================
    //  3.  WIZARD NAVIGATION & UI UPDATE
    // ============================================================
    function updateWizard() {
        // Update step indicators (circles and labels)
        stepItems.forEach(item => {
            const stepNum = parseInt(item.getAttribute('data-step'));
            const circle = item.querySelector('.step-circle');
            const label = item.querySelector('.step-label');

            if (stepNum === currentStep) {
                circle.style.background = 'var(--amber)';
                circle.style.borderColor = 'var(--amber)';
                circle.style.color = 'var(--btn-text)';
                label.style.color = 'var(--amber)';
                label.style.fontWeight = '700';
            } else if (stepNum < currentStep) {
                circle.style.background = 'var(--amber-soft)';
                circle.style.borderColor = 'var(--amber)';
                circle.style.color = 'var(--amber)';
                label.style.color = 'var(--text)';
            } else {
                circle.style.background = 'var(--bg2)';
                circle.style.borderColor = 'var(--line)';
                circle.style.color = 'var(--muted)';
                label.style.color = 'var(--muted)';
            }
        });

        // Show/hide step cards and update status icon
        stepCards.forEach(card => {
            const stepNum = parseInt(card.getAttribute('data-step'));
            const body = card.querySelector('.step-body');
            const statusIcon = card.querySelector('.step-header span');

            if (stepNum === currentStep) {
                card.style.borderColor = 'var(--amber)';
                card.style.opacity = '1';
                body.style.display = 'flex';
                if (statusIcon) statusIcon.textContent = '⏳';
                card.scrollIntoView({ behavior: 'smooth', block: 'center' });
            } else {
                card.style.borderColor = 'var(--line)';
                body.style.display = 'none';
                if (stepNum < currentStep) {
                    card.style.opacity = '0.85';
                    if (statusIcon) statusIcon.textContent = '✅';
                } else {
                    card.style.opacity = '0.5';
                    if (statusIcon) statusIcon.textContent = '🔽';
                }
            }
        });

        // Show/hide navigation buttons
        btnPrev.style.display = (currentStep === 1) ? 'none' : 'inline-block';
        if (currentStep === totalSteps) {
            btnNext.style.display = 'none';
            btnSubmitFinal.style.display = 'inline-block';
            buildSummary();
        } else {
            btnNext.style.display = 'inline-block';
            btnSubmitFinal.style.display = 'none';
        }
    }

    function validateStep(step) {
        const activeCard = document.querySelector(`.wizard-step-card[data-step="${step}"]`);
        if (!activeCard) return true;

        const inputs = activeCard.querySelectorAll('input[required], select[required]');
        let isValid = true;
        inputs.forEach(input => {
            if (!input.checkValidity()) {
                input.reportValidity();
                isValid = false;
            }
        });
        return isValid;
    }

    // Next button
    btnNext.addEventListener('click', function () {
        // Ensure dynamic fields are up-to-date
        handleSellTypeFields();
        handleAddressFields();

        // Set required attributes for step 2 & 3 (they are set dynamically, but ensure they exist)
        if (currentStep === 2) {
            document.getElementById('vehicle_type').setAttribute('required', 'required');
            document.getElementById('car_brand').setAttribute('required', 'required');
            document.getElementById('car_model').setAttribute('required', 'required');
        }
        if (currentStep === 3) {
            document.getElementById('km_age').setAttribute('required', 'required');
            document.getElementById('body_color').setAttribute('required', 'required');
            document.getElementById('gearbox').setAttribute('required', 'required');
            document.getElementById('fuel_type').setAttribute('required', 'required');
        }

        if (validateStep(currentStep)) {
            if (currentStep < totalSteps) {
                currentStep++;
                updateWizard();
            }
        }
    });

    // Previous button
    btnPrev.addEventListener('click', function () {
        if (currentStep > 1) {
            currentStep--;
            updateWizard();
        }
    });

    // ============================================================
    //  4.  IMAGE UPLOADER
    // ============================================================
    const imageInput = document.getElementById('images');
    const previewContainer = document.getElementById('image-preview-container');

    imageInput.addEventListener('change', function () {
        const files = Array.from(this.files);
        if (selectedFiles.length + files.length > 10) {
            alert("⚠️ شما حداکثر مجاز به انتخاب ۱۰ عکس برای آگهی خود هستید.");
            return;
        }
        files.forEach(file => {
            if (file.type.startsWith('image/')) {
                selectedFiles.push(file);
                renderPreviews();
            }
        });
        syncFilesToInput();
    });

    function renderPreviews() {
        previewContainer.innerHTML = '';
        selectedFiles.forEach((file, index) => {
            const reader = new FileReader();
            reader.onload = function (e) {
                const div = document.createElement('div');
                div.style.cssText =
                    'position: relative; width: 85px; height: 85px; border-radius: 8px; overflow: hidden; border: 1px solid var(--line);';
                div.innerHTML = `
                    <img src="${e.target.result}" style="width: 100%; height: 100%; object-fit: cover;">
                    <span class="remove-img-btn" data-index="${index}" 
                          style="position: absolute; top: 4px; right: 4px; background: rgba(0,0,0,0.7); color: #fff; 
                                 width: 18px; height: 18px; border-radius: 50%; display: flex; align-items: center; 
                                 justify-content: center; font-size: 12px; font-weight: bold; cursor: pointer; transition: 0.2s;">
                        ×
                    </span>
                `;
                previewContainer.appendChild(div);
            };
            reader.readAsDataURL(file);
        });
    }

    // Remove image on click
    previewContainer.addEventListener('click', function (e) {
        if (e.target.classList.contains('remove-img-btn')) {
            const indexToRemove = parseInt(e.target.getAttribute('data-index'));
            selectedFiles.splice(indexToRemove, 1);
            renderPreviews();
            syncFilesToInput();
        }
    });

    function syncFilesToInput() {
        const dataTransfer = new DataTransfer();
        selectedFiles.forEach(file => dataTransfer.items.add(file));
        imageInput.files = dataTransfer.files;
    }

    // ============================================================
    //  5.  SUMMARY BUILDER (final step)
    // ============================================================
    function buildSummary() {
        const container = document.getElementById('summary-container');
        const type = document.getElementById('vehicle_type').value;
        const brand = document.getElementById('car_brand').options[document.getElementById('car_brand').selectedIndex]?.text || '';
        const model = document.getElementById('car_model').options[document.getElementById('car_model').selectedIndex]?.text || '';
        const sellType = sellTypeSelect.value;

        container.innerHTML = `
            <h4 style="color: var(--amber); margin-top:0;">📋 بررسی مشخصات نهایی</h4>
            <p>🔹 <strong>نوع وسیله:</strong> ${type} (${brand} - ${model})</p>
            <p>🔹 <strong>نوع واگذاری:</strong> ${sellType}</p>
            <p>🔹 <strong>تعداد عکس‌های پیوست:</strong> ${selectedFiles.length} عدد</p>
        `;
    }

    // ============================================================
    //  INIT
    // ============================================================
    updateWizard();
});