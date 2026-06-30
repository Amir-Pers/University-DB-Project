from django.shortcuts import render
from django.http import HttpResponse
# Create your views here.

def http(request):
    return HttpResponse("<p>Salam</p>")


def home(request):
    return render(request, "index.html")