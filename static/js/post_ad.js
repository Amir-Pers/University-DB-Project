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

    // Address elements
    const addrDefaultRadio = document.getElementById('addr_type_default');
    const addrNewRadio = document.getElementById('addr_type_new');
    const defaultAddressBox = document.getElementById('default-address-box');
    const newAddressBox = document.getElementById('new-address-box');
    const stateSelect = document.getElementById('state');
    const citySelect = document.getElementById('city');

    // Sell type elements
    const sellTypeSelect = document.getElementById('sell_type');
    const cashGroup = document.getElementById('sell-fields-cash');
    const installmentGroup = document.getElementById('sell-fields-installment');
    const draftGroup = document.getElementById('sell-fields-draft');
    const agreementGroup = document.getElementById('sell-fields-agreement');

    // Image upload elements
    const imageInput = document.getElementById('images');
    const previewContainer = document.getElementById('image-preview-container');

    // ============================================================
    //  1. ADDRESS FIELDS TOGGLE
    // ============================================================
    function handleAddressFields() {
        if (addrNewRadio && addrNewRadio.checked) {
            newAddressBox.style.display = 'flex';
            defaultAddressBox.style.display = 'none';
            if (currentStep === 5) {
                stateSelect?.setAttribute('required', 'required');
                citySelect?.setAttribute('required', 'required');
            }
        } else if (defaultAddressBox && newAddressBox) {
            newAddressBox.style.display = 'none';
            defaultAddressBox.style.display = 'block';
            stateSelect?.removeAttribute('required');
            citySelect?.removeAttribute('required');
        }
    }

    if (addrDefaultRadio && addrNewRadio) {
        addrDefaultRadio.addEventListener('change', handleAddressFields);
        addrNewRadio.addEventListener('change', handleAddressFields);
    }

    // ============================================================
    //  2. SELL TYPE DYNAMIC FIELDS
    // ============================================================
    function handleSellTypeFields() {
        if (!sellTypeSelect) return;
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
                document.getElementById('price')?.setAttribute('required', 'required');
            }
        } else if (type === 'اقساطی') {
            installmentGroup.style.display = 'block';
            if (currentStep === 1) {
                ['pre_payment', 'installment_amount', 'payment_period', 'installment_count', 'delivery_time_inst'].forEach(id => {
                    document.getElementById(id)?.setAttribute('required', 'required');
                });
            }
        } else if (type === 'حواله') {
            draftGroup.style.display = 'block';
            if (currentStep === 1) {
                ['deposit_amount', 'final_price', 'delivery_time_draft'].forEach(id => {
                    document.getElementById(id)?.setAttribute('required', 'required');
                });
            }
        } else if (type === 'توافقی') {
            agreementGroup.style.display = 'block';
        }
    }

    if (sellTypeSelect) {
        sellTypeSelect.addEventListener('change', handleSellTypeFields);
        handleSellTypeFields();
    }

    // ============================================================
    //  3. WIZARD NAVIGATION & UI UPDATE
    // ============================================================
    function updateWizard() {
        stepItems.forEach(item => {
            const stepNum = parseInt(item.getAttribute('data-step'));
            const circle = item.querySelector('.step-circle');
            const label = item.querySelector('.step-label');

            if (stepNum === currentStep) {
                circle.className = 'step-circle step-circle-active';
                label.className = 'step-label step-label-active';
            } else if (stepNum < currentStep) {
                circle.className = 'step-circle step-circle-completed';
                label.className = 'step-label step-label-completed';
            } else {
                circle.className = 'step-circle step-circle-pending';
                label.className = 'step-label step-label-pending';
            }
        });

        stepCards.forEach(card => {
            const stepNum = parseInt(card.getAttribute('data-step'));
            const body = card.querySelector('.step-body');
            const statusIcon = card.querySelector('.step-header span');

            if (stepNum === currentStep) {
                card.classList.add('active-card');
                card.classList.remove('inactive-card');
                body.style.display = 'flex';
                if (statusIcon) statusIcon.textContent = '⏳';
                card.scrollIntoView({ behavior: 'smooth', block: 'center' });
            } else {
                card.classList.remove('active-card');
                card.classList.add('inactive-card');
                body.style.display = 'none';
                if (statusIcon) statusIcon.textContent = stepNum < currentStep ? '✅' : '🔽';
            }
        });

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

    btnNext?.addEventListener('click', function () {
        handleSellTypeFields();
        handleAddressFields();

        if (currentStep === 2) {
            ['vehicle_type', 'car_brand', 'car_model'].forEach(id => document.getElementById(id)?.setAttribute('required', 'required'));
        }
        if (currentStep === 3) {
            ['km_age', 'body_color', 'gearbox', 'fuel_type'].forEach(id => document.getElementById(id)?.setAttribute('required', 'required'));
        }

        if (validateStep(currentStep) && currentStep < totalSteps) {
            currentStep++;
            updateWizard();
        }
    });

    btnPrev?.addEventListener('click', function () {
        if (currentStep > 1) {
            currentStep--;
            updateWizard();
        }
    });

    // ============================================================
    //  4. IMAGE UPLOADER
    // ============================================================
    if (imageInput) {
        imageInput.addEventListener('change', function () {
            const files = Array.from(this.files);
            if (selectedFiles.length + files.length > 6) {
                alert("⚠️ حداکثر می‌توانید ۶ تصویر انتخاب کنید.");
                return;
            }
            files.forEach(file => {
                if (file.type.startsWith('image/')) {
                    selectedFiles.push(file);
                }
            });
            renderPreviews();
            syncFilesToInput();
        });
    }

    function renderPreviews() {
        if (!previewContainer) return;
        previewContainer.innerHTML = '';
        selectedFiles.forEach((file, index) => {
            const reader = new FileReader();
            reader.onload = function (e) {
                const div = document.createElement('div');
                div.className = 'img-preview-box';
                div.innerHTML = `
                    <img src="${e.target.result}" alt="پیش‌نمایش">
                    <span class="remove-img-btn" data-index="${index}">×</span>
                `;
                previewContainer.appendChild(div);
            };
            reader.readAsDataURL(file);
        });
    }

    previewContainer?.addEventListener('click', function (e) {
        if (e.target.classList.contains('remove-img-btn')) {
            const indexToRemove = parseInt(e.target.getAttribute('data-index'));
            selectedFiles.splice(indexToRemove, 1);
            renderPreviews();
            syncFilesToInput();
        }
    });

    function syncFilesToInput() {
        if (!imageInput) return;
        const dataTransfer = new DataTransfer();
        selectedFiles.forEach(file => dataTransfer.items.add(file));
        imageInput.files = dataTransfer.files;
    }

    // ============================================================
    //  5. SUMMARY BUILDER
    // ============================================================
    function buildSummary() {
        const container = document.getElementById('summary-container');
        if (!container) return;

        const type = document.getElementById('vehicle_type')?.value || '';
        const brandSelect = document.getElementById('car_brand');
        const modelSelect = document.getElementById('car_model');
        const brand = brandSelect?.options[brandSelect.selectedIndex]?.text || '';
        const model = modelSelect?.options[modelSelect.selectedIndex]?.text || '';
        const sellType = sellTypeSelect?.value || '';

        container.innerHTML = `
            <h4 style="color: var(--amber); margin-top:0;">📋 بررسی مشخصات نهایی</h4>
            <p>🔹 <strong>نوع وسیله:</strong> ${type} (${brand} - ${model})</p>
            <p>🔹 <strong>نوع واگذاری:</strong> ${sellType}</p>
            <p>🔹 <strong>تعداد عکس‌های پیوست:</strong> ${selectedFiles.length} عدد</p>
        `;
    }

    updateWizard();
});