document.addEventListener("DOMContentLoaded", function () {


    function toPersianDigits(value) {

        const persianDigits = "۰۱۲۳۴۵۶۷۸۹";

        return String(value).replace(/[0-9]/g, function (digit) {
            return persianDigits[digit];
        });
    }



    function toEnglishDigits(value) {

        const persianDigits = "۰۱۲۳۴۵۶۷۸۹";
        const arabicDigits = "٠١٢٣٤٥٦٧٨٩";

        return String(value)

            .replace(/[۰-۹]/g, function (digit) {
                return persianDigits.indexOf(digit);
            })

            .replace(/[٠-٩]/g, function (digit) {
                return arabicDigits.indexOf(digit);
            });
    }




    function formatNumber(value) {


        if (
            value === null ||
            value === undefined ||
            value === ""
        ) {
            return "";
        }


        let number = toEnglishDigits(value);


        number = number.replace(/[^\d]/g, "");


        if (!number) {
            return "";
        }



        number = number.replace(
            /\B(?=(\d{3})+(?!\d))/g,
            ","
        );



        return toPersianDigits(number);

    }



    function setupNumberInput(input) {


        if (!input) {
            return;
        }



        input.addEventListener(
            "input",
            function () {


                this.value =
                    formatNumber(this.value);


                this.setSelectionRange(
                    this.value.length,
                    this.value.length
                );


            }
        );




        input.addEventListener(
            "blur",
            function () {

                this.value =
                    formatNumber(this.value);

            }
        );


    }



    document
    .querySelectorAll(".persian-number")
    .forEach(function(input){

        setupNumberInput(input);
        
        if (input.value) {
        input.value = formatNumber(input.value);
    }

    });



    document
    .querySelectorAll("form")
    .forEach(function(form){


        form.addEventListener(
            "submit",
            function(){


                form
                .querySelectorAll(".persian-number")
                .forEach(function(input){



                    input.value =
                        toEnglishDigits(input.value)
                        .replace(/[^\d]/g,"");



                });


            }
        );


    });





    window.toPersianDigits = toPersianDigits;
    window.toEnglishDigits = toEnglishDigits;
    window.formatNumber = formatNumber;


});