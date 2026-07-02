from django.shortcuts import render

# Create your views here.

def account_view(request):
    return render(request, "accounts/account.html")