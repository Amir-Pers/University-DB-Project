from django.shortcuts import render
# Create your views here.

def ad_detail_view(request):
    return render(request, 'advertisementes/ad_details.html')

