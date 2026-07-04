from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required


@login_required
def profile_view(request):
    context = {
        "profile": request.user.profile,
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
    return render(request, "accounts/register.html")