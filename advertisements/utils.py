from locations.models import City
from vehicles.models import Vehicle, VehicleModel, Brand, Motorcycle, Car
from advertisements.models import Advertisement, Image, Instalment
from locations.models import Address, Province, City
from django.utils import timezone
from .models import Remittance


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
        "production_year": request.POST.get("production_year"),

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
        "deleted_images": request.POST.get("deleted_images", ""),
    }




def validate_post_ad(data, profile, existing_images=0):

    required_fields = [
        data["sell_type"],
        data["vehicle_type"],
        data["brand_id"],
        data["model_id"],
        data["production_year"],
        data["km_age"],
        data["car_condition"],
        data["body_status"],
        data["ad_type"],
        data["body_color"],
        data["gearbox"],
        data["fuel_type"],
    ]

    if any(not value for value in required_fields):
        return "تمام فیلدهای ضروری را تکمیل کنید."


    valid_sell_types = {"نقدی", "اقساطی", "حواله", "توافقی"}

    if data["sell_type"] not in valid_sell_types:
        return "نوع فروش معتبر نیست."

    valid_vehicle_types = {"car", "motorcycle"}

    if data["vehicle_type"] not in valid_vehicle_types:
        return "نوع وسیله نقلیه معتبر نیست."


    try:
        km_age = int(data["km_age"])
    except (TypeError, ValueError):
        return "کارکرد خودرو معتبر نیست."


    if km_age < 0:
        return "کارکرد خودرو نمی‌تواند منفی باشد."

    if data["car_condition"] == "صفر" and km_age != 0:
        return "برای خودروی صفر، کارکرد باید صفر باشد."

    if data["car_condition"] == "کارکرده" and km_age == 0:
        return "برای خودروی کارکرده، کارکرد باید بیشتر از صفر باشد."


    if data["sell_type"] == "نقدی":

        if not data["price"]:
            return "قیمت فروش را وارد کنید."

    elif data["sell_type"] == "اقساطی":

        required_fields = [
            data["pre_payment"],
            data["installment_amount"],
            data["payment_period"],
            data["installment_count"],
            data["delivery_time_inst"],
        ]

        if any(not value for value in required_fields):
            return "اطلاعات فروش اقساطی کامل نیست."

    elif data["sell_type"] == "حواله":

        required_fields = [
            data["deposit_amount"],
            data["final_price"],
            data["delivery_time_draft"],
        ]

        if any(not value for value in required_fields):
            return "اطلاعات حواله کامل نیست."


    if data["address_mode"] == "default":

        if not profile.default_address:
            return "برای حساب شما آدرس پیش‌فرض ثبت نشده است."

    elif data["address_mode"] == "new":

        if not data["province_id"] or not data["city_id"]:
            return "استان و شهر را انتخاب کنید."

        try:
            province_id = int(data["province_id"])
        except (TypeError, ValueError):
            return "استان انتخاب شده معتبر نیست."

        city = City.objects.filter(pk=data["city_id"]).first()

        if city is None:
            return "شهر انتخاب شده معتبر نیست."

        if city.province_id != province_id:
            return "شهر انتخاب شده متعلق به استان انتخاب شده نیست."

    else:
        return "نوع آدرس معتبر نیست."

    vehicle = Vehicle.objects.filter(
    model_id=data["model_id"],
    production_year=data["production_year"],
    color_out=data["body_color"],
    color_in=data["cabin_color"] or None,
    transmission_type=data["gearbox"],
    fuel_type=data["fuel_type"],
    ).first()

    if vehicle is None:
        return "خودروی انتخاب شده در سیستم وجود ندارد."

    data["vehicle"] = vehicle


    images = data["images"]

    deleted_images = data["deleted_images"]

    deleted_count = 0

    if deleted_images:
        
        deleted_count = len([
        image_id
        for image_id in deleted_images.split(",")
        if image_id.strip()
        ])

    remaining_images = (
        existing_images
        - deleted_count
        + len(images)
    )

    if remaining_images < 1:
        return "حداقل یک تصویر برای آگهی انتخاب کنید."

    if remaining_images > 6:
        return "حداکثر 6 تصویر قابل بارگذاری است."

    allowed_types = {
        "image/jpeg",
        "image/png",
        "image/webp",
    }

    max_size = 1 * 1024 * 1024  # 1 MB

    for image in images:
        if image.content_type not in allowed_types:
            return "فرمت تصاویر باید JPG، PNG یا WEBP باشد."

        if image.size > max_size:
            return "حجم هر تصویر نباید بیشتر از 1 مگابایت باشد."

    return None


def create_images(advertisement, images):
    for image in images:
        Image.objects.create(
            ad=advertisement,
            image=image,
            upload_date=timezone.now(),
        )



def create_instalment(advertisement, data):

    if data["sell_type"] != "اقساطی":
        return

    Instalment.objects.create(
        ad=advertisement,
        first_payment=data["pre_payment"],
        second_payment=None,
        payment_per_instalment=data["installment_amount"],
        payment_count=data["installment_count"],
        payment_period=data["payment_period"],
        delivery_date=data["delivery_time_inst"],
    )



def create_remittance(advertisement, data):

    if data["sell_type"] != "حواله":
        return

    Remittance.objects.create(
        advertisement=advertisement,
        deposit_amount=data["deposit_amount"],
        final_price=data["final_price"],
        delivery_time=data["delivery_time_draft"],
    )


def create_advertisement(profile, data):

    if data["address_mode"] == "default":

        default_address = profile.default_address

        address = Address.objects.create(
            city=default_address.city,
            neighborhood=default_address.neighborhood,
        )

    else:

        city = City.objects.get(pk=data["city_id"])

        address = Address.objects.create(
            city=city,
            neighborhood=data["neighborhood"],
        )


    vehicle = data["vehicle"]

    title = f"{vehicle.model.brand.name} {vehicle.model.name}"

    if data["tip"]:
        title += f" {data['tip']}"


    advertisement = Advertisement.objects.create(
        vehicle=vehicle,
        userid=profile,
        address=address,

        title=title,

        sell_type=data["sell_type"],
        price=data["price"] if data["sell_type"] == "نقدی" else None,

        descriptions=data["descriptions"],

        published=False,
        created_date=timezone.now(),
        updated_date=timezone.now(),

        ad_type=data["ad_type"],
        car_condition=data["car_condition"],
        body_status=data["body_status"],
        km_age=data["km_age"],

        active_status=True,
    )

    create_images(advertisement, data["images"])
    create_instalment(advertisement, data)
    create_remittance(advertisement, data)
    
    return advertisement



def update_advertisement(advertisement, data):

    vehicle = data["vehicle"]

    title = f"{vehicle.model.brand.name} {vehicle.model.name}"

    if data["tip"]:
        title += f" {data['tip']}"

    advertisement.vehicle = vehicle

    advertisement.title = title

    advertisement.sell_type = data["sell_type"]

    advertisement.price = (
        data["price"]
        if data["sell_type"] == "نقدی"
        else None
    )

    advertisement.descriptions = data["descriptions"]

    advertisement.ad_type = data["ad_type"]
    advertisement.car_condition = data["car_condition"]
    advertisement.body_status = data["body_status"]
    advertisement.km_age = data["km_age"]

    advertisement.updated_date = timezone.now()

    advertisement.published = False

    deleted_images = data["deleted_images"]
    
    if deleted_images:

        image_ids = [
            int(image_id)
            for image_id in deleted_images.split(",")
            if image_id.strip()
        ]

        images = Image.objects.filter(
            ad=advertisement,
            image_id__in=image_ids,
        )

        for image in images:

            if image.image:
                image.image.delete(save=False)

            image.delete()
    
    if data["images"]: 
        create_images(advertisement, data["images"])

    if data["address_mode"] == "default":

        default_address = advertisement.userid.default_address

        advertisement.address.city = default_address.city
        advertisement.address.neighborhood = default_address.neighborhood

    else:

        city = City.objects.get(pk=data["city_id"])

        advertisement.address.city = city
        advertisement.address.neighborhood = data["neighborhood"]

    
    if data["sell_type"] == "اقساطی":

        Instalment.objects.update_or_create(
            ad=advertisement,
            defaults={
                "first_payment": data["pre_payment"],
                "second_payment": None,
                "payment_per_instalment": data["installment_amount"],
                "payment_count": data["installment_count"],
                "payment_period": data["payment_period"],
                "delivery_date": data["delivery_time_inst"],
            },
        )

        Remittance.objects.filter(
            advertisement=advertisement
        ).delete() 



    elif data["sell_type"] == "حواله":

        Remittance.objects.update_or_create(
            advertisement=advertisement,
            defaults={
                "deposit_amount": data["deposit_amount"],
                "final_price": data["final_price"],
                "delivery_time": data["delivery_time_draft"],
            },
        )

        Instalment.objects.filter(
            ad=advertisement
        ).delete()

    else:

        Instalment.objects.filter(
            ad=advertisement
        ).delete()

        Remittance.objects.filter(
            advertisement=advertisement
        ).delete()



    advertisement.address.save()

    advertisement.save()