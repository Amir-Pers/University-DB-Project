from django.shortcuts import render, get_object_or_404, redirect
from django.db.models import Prefetch
from django.contrib.auth.decorators import login_required
from django.contrib import messages

from .models import Advertisement, Image
from vehicles.models import Brand
from locations.models import Province


def advertisement_detail(request, ad_id):

    advertisement = (
        Advertisement.objects
        .select_related(
            "vehicle",
            "vehicle__model",
            "vehicle__model__brand",
            "userid",
            "address",
            "address__city",
        )
        .prefetch_related(
            Prefetch(
                "images",
                queryset=Image.objects.order_by("image_id"),
            )
        )
        .get(ad_id=ad_id)
    )

    return render(request, "advertisements/ad_detail.html",
        {
            "ad": advertisement,
        },
)


@login_required
def post_ad_view(request):

    profile = request.user.profile
    
    if not profile.reg_status:
        messages.warning(request,"ابتدا اطلاعات حساب خود را تکمیل کنید.")
        return redirect("accounts:profile")
    
    context = {
        "profile" : profile,

        "brands" : Brand.objects.all(),

        "provinces" : Province.objects.prefetch_related("cities").all(),

        "cities": (
            profile.default_address.city.province.cities.all()
            if profile.default_address
            else []
        )
    }

    
    return render(request, "advertisements/post_ad.html", context)