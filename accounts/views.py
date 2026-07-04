from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.contrib import messages

# Create your views here.

def profile_view(request):
    return render(request, "accounts/profile.html")

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
            next_url = request.GET.get("next")
            
            if next_url:
                return redirect(next_url)
            
            return redirect("accounts:profile")

        messages.error(request, "شماره موبایل یا رمز عبور اشتباه است.")
    
    return render(request, "accounts/login.html")

def register_view(request):
    return render(request, "accounts/register.html")