from locations.models import City


def get_post_ad_data(request):
    sell_type = request.POST.get("sell_type")

    return {
        "sell_type": sell_type,
        "price": request.POST.get("price"),
        "pre_payment": request.POST.get("pre_payment"),
        "installment_amount": request.POST.get("installment_amount"),
        "payment_period": request.POST.get("payment_period"),
        "installment_count": request.POST.get("installment_count"),
        "delivery_time_inst": request.POST.get("delivery_time_inst"),
        "deposit_amount": request.POST.get("deposit_amount"),
        "final_price": request.POST.get("final_price"),
        "delivery_time_draft": request.POST.get("delivery_time_draft"),

        "vehicle_type": request.POST.get("vehicle_type"),
        "brand_id": request.POST.get("car_brand"),
        "model_id": request.POST.get("car_model"),
        "tip": request.POST.get("car_tip"),

        "km_age": request.POST.get("km_age"),
        "car_condition": request.POST.get("car_condition"),
        "body_status": request.POST.get("body_status"),
        "ad_type": request.POST.get("ad_type"),

        "body_color": request.POST.get("body_color"),
        "cabin_color": request.POST.get("cabin_color"),
        "gearbox": request.POST.get("gearbox"),
        "fuel_type": request.POST.get("fuel_type"),

        "descriptions": request.POST.get("descriptions", "").strip(),

        "address_mode": request.POST.get("address_mode"),
        "province_id": request.POST.get("state"),
        "city_id": request.POST.get("city"),
        "neighborhood": request.POST.get("neighborhood", "").strip(),

        "images": request.FILES.getlist("images"),
    }





def validate_post_ad(data, profile):

    required = [
        data["sell_type"],
        data["vehicle_type"],
        data["brand_id"],
        data["model_id"],
        data["km_age"],
        data["car_condition"],
        data["body_status"],
        data["ad_type"],
        data["body_color"],
        data["gearbox"],
        data["fuel_type"],
    ]

    if any(not value for value in required):
        return "تمام فیلدهای ضروری را تکمیل کنید."

    # -------- نوع فروش --------

    if data["sell_type"] == "نقدی":

        if not data["price"]:
            return "قیمت فروش را وارد کنید."

    elif data["sell_type"] == "اقساطی":

        required = [
            data["pre_payment"],
            data["installment_amount"],
            data["payment_period"],
            data["installment_count"],
            data["delivery_time_inst"],
        ]

        if any(not value for value in required):
            return "اطلاعات فروش اقساطی کامل نیست."

    elif data["sell_type"] == "حواله":

        required = [
            data["deposit_amount"],
            data["final_price"],
            data["delivery_time_draft"],
        ]

        if any(not value for value in required):
            return "اطلاعات حواله کامل نیست."


    if data["address_mode"] == "default":

        if not profile.default_address:
            return "برای حساب شما آدرس پیش‌فرض ثبت نشده است."

    elif data["address_mode"] == "new":

        if not data["province_id"] or not data["city_id"]:
            return "استان و شهر را انتخاب کنید."

        city = City.objects.filter(pk=data["city_id"]).first()

        if city is None:
            return "شهر انتخاب شده معتبر نیست."

        if city.province_id != int(data["province_id"]):
            return "شهر انتخاب شده متعلق به استان انتخاب شده نیست."

    return None
