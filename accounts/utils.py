from django.shortcuts import  redirect, get_object_or_404
from django.contrib.auth import update_session_auth_hash
from django.contrib import messages
from django.db import transaction
from django.utils import timezone

from .models import User
from locations.models import Address, Province, City


def handle_identity_form(request, profile):

    first_name = request.POST.get("first_name", "").strip()
    last_name = request.POST.get("last_name", "").strip()
    username = request.POST.get("username", "").strip()
    national_id = request.POST.get("national_id", "").strip()

    if len(username) < 3:
        messages.error(request, "نام کاربری باید حداقل ۳ کاراکتر باشد.")
        return redirect("accounts:profile")

    if User.objects.filter(username=username).exclude(userid=profile.userid).exists():
        messages.error(request, "این نام کاربری قبلاً انتخاب شده است.")
        return redirect("accounts:profile")

    with transaction.atomic():

        request.user.first_name = first_name
        request.user.last_name = last_name
        request.user.save()

        profile.username = username

        if not profile.reg_status:

            if not national_id.isdigit() or len(national_id) != 10:
                messages.error(request, "کد ملی باید از ۱۰ رقم تشکیل شده باشد.")
                return redirect("accounts:profile")

            if User.objects.filter(national_id=national_id).exclude(userid=profile.userid).exists():
                messages.error(request, "این کد ملی قبلاً ثبت شده است.")
                return redirect("accounts:profile")

            profile.national_id = national_id
            profile.reg_status = True
            profile.register_date = timezone.now()

        profile.save()

    messages.success(request, "اطلاعات حساب کاربری با موفقیت ذخیره شد.")
    return redirect("accounts:profile")


def handle_address_form(request, profile):

    province_id = request.POST.get("province")
    city_id = request.POST.get("city")
    neighborhood = request.POST.get("neighborhood", "").strip()

    if not province_id or not city_id:
        messages.error(request, "استان و شهر را انتخاب کنید.")
        return redirect("accounts:profile")

    city = get_object_or_404(City, pk=city_id)

    if city.province_id != int(province_id):
        messages.error(request, "شهر انتخاب شده متعلق به استان انتخاب شده نیست.")
        return redirect("accounts:profile")

    if profile.default_address:
        address = profile.default_address
        address.city = city
        address.neighborhood = neighborhood
        address.save()

    else:
        address = Address.objects.create(
            city=city,
            neighborhood=neighborhood
        )

        profile.default_address = address
        profile.save()

    messages.success(request, "اطلاعات حساب کاربری با موفقیت ذخیره شد.")
    return redirect("accounts:profile")


def handle_password_form(request):

    current_password = request.POST.get("current_password")
    new_password = request.POST.get("new_password")
    confirm_password = request.POST.get("confirm_password")

    if not current_password or not new_password or not confirm_password:
        messages.error(request, "تمام فیلدهای تغییر رمز عبور را تکمیل کنید.")
        return redirect("accounts:profile")

    if not request.user.check_password(current_password):
        messages.error(request, "رمز عبور فعلی اشتباه است.")
        return redirect("accounts:profile")

    if request.user.check_password(new_password):
        messages.error(request, "رمز عبور جدید باید با رمز عبور فعلی متفاوت باشد.")
        return redirect("accounts:profile")

    if new_password != confirm_password:
        messages.error(request, "رمز عبور جدید و تکرار آن یکسان نیستند.")
        return redirect("accounts:profile")

    if len(new_password) < 8:
        messages.error(request, "رمز عبور باید حداقل ۸ کاراکتر باشد.")
        return redirect("accounts:profile")

    request.user.set_password(new_password)
    request.user.save()

    update_session_auth_hash(request, request.user)

    messages.success(request, "رمز عبور با موفقیت تغییر کرد.")
    return redirect("accounts:profile")


def get_profile_context(profile):

    return {
        "profile": profile,
        "provinces": Province.objects.prefetch_related("cities").all(),

        "selected_province": (
            profile.default_address.city.province.province_id
            if profile.default_address
            else None
        ),

        "selected_city": (
            profile.default_address.city.city_id
            if profile.default_address
            else None
        ),

        "cities": (
            profile.default_address.city.province.cities.all()
            if profile.default_address
            else []
        ),
    }