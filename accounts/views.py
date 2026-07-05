from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User as AuthUser
from django.db import transaction
from django.db.models import Q
from django.utils import timezone

from .models import User
from locations.models import Address, Province, City

@login_required
def profile_view(request):

    profile = request.user.profile

    if request.method == "POST":

        first_name = request.POST.get("first_name", "").strip()
        last_name = request.POST.get("last_name", "").strip()
        username = request.POST.get('username', '').strip()
        national_id = request.POST.get('national_id', "").strip()
        
        if len(username) < 3:
            messages.error(request, "نام کاربری باید حداقل ۳ کاراکتر باشد.")
            return redirect("accounts:profile")

        if User.objects.filter(username=username).exclude(userid=profile.userid).exists():
            if User.objects.filter(username=username).exclude(userid=profile.userid).exists():
                messages.error(request, "این نام کاربری قبلاً انتخاب شده است.")
                return redirect("accounts:profile")
            
        if not national_id.isdigit() or len(national_id) != 10:
            messages.error(request, "کد ملی باید از ۱۰ رقم تشکیل شده باشد.")
            return redirect("accounts:profile")
        
        if User.objects.filter(national_id=national_id).exclude(userid=profile.userid).exists():
            messages.error(request, "این کد ملی قبلاً ثبت شده است.")
            return redirect("accounts:profile")


        with transaction.atomic():

            request.user.first_name = first_name
            request.user.last_name = last_name
            request.user.save()

            profile.username = username

            if not profile.reg_status:
                profile.national_id = national_id
                profile.reg_status = True
                profile.register_date = timezone.now()


            profile.save()
        
        

        messages.success(request, "اطلاعات حساب کاربری با موفقیت ذخیره شد.")
        return redirect("accounts:profile")


    context = {
        "profile": profile,
        'provinces' : Province.objects.prefetch_related("cities").all(),

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


    return render(request, "accounts/profile.html", context)


def login_view(request):
    if request.user.is_authenticated:
        return redirect("accounts:profile")
    
    if request.method == 'POST':
        username = request.POST.get('phone')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)
            messages.success(request, "با موفقیت وارد شدید.")
            
            return redirect("accounts:profile")

        messages.error(request, "شماره موبایل یا رمز عبور اشتباه است.")
    
    return render(request, "accounts/login.html")


@login_required
def logout_view(request):
    logout(request)
    messages.success(request, "با موفقیت از حساب کاربری خارج شدید.")
    return redirect("home:index")


def register_view(request):
    if request.user.is_authenticated:
        return redirect("accounts:profile")
    
    if request.method == 'POST':

        phone = request.POST.get('phone', "").strip()
        password1 = request.POST.get("password1")
        password2 = request.POST.get("password2")

        if password1 != password2:
            messages.error(request, "رمزهای عبور یکسان نیستند.")
            return redirect("accounts:register")

        if len(password1) < 8:
            messages.error(request, "رمز عبور باید حداقل ۸ کاراکتر باشد.")
            return redirect("accounts:register")
        
        if User.objects.filter(phone=phone).exists():
            messages.error(request, "این شماره موبایل قبلاً ثبت شده است.")
            return redirect("accounts:register")
        
        if AuthUser.objects.filter(username=phone).exists():
            messages.error(request, "این شماره موبایل قبلاً ثبت شده است.")
            return redirect("accounts:register")
        
        
        with transaction.atomic():
            auth_user = AuthUser.objects.create_user(username=phone, password=password1)
            User.objects.create(user_auth=auth_user, phone=phone, reg_status=False)

        messages.success(request, "ثبت‌نام با موفقیت انجام شد. اکنون وارد حساب کاربری خود شوید.")

        return redirect("accounts:login")
    

    return render(request, "accounts/register.html")