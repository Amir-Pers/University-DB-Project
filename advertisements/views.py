from django.shortcuts import render, get_object_or_404, redirect
from django.db.models import Prefetch
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.db import transaction
from django.views.decorators.http import require_POST

from .models import Advertisement, Image
from vehicles.models import Brand
from locations.models import Province
from .utils import get_post_ad_data, validate_post_ad, create_advertisement

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
    

    if request.method == "POST":

        data = get_post_ad_data(request)

        error = validate_post_ad(data=data, profile=profile)

        if error:
            messages.error(request, error)
            return redirect("advertisements:post_ad")
        
        with transaction.atomic():
            ad = create_advertisement(profile, data)
        
        messages.success(request, "اعتبارسنجی فرم با موفقیت انجام شد.")
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


@login_required
@require_POST
def delete_ad_view(request, ad_id):

    ad = get_object_or_404(
        Advertisement,
        ad_id=ad_id,
        userid=request.user.profile,
    )

    address = ad.address

    with transaction.atomic():

        for image in ad.images.all():
            if image.image:
                image.image.delete(save=False)

        ad.delete()

        address.delete()

    messages.success(request, "آگهی با موفقیت حذف شد.")
    return redirect("accounts:profile")

@login_required
def edit_ad_view(request, ad_id):

    profile = request.user.profile

    ad = get_object_or_404(
        Advertisement.objects.select_related(
            "vehicle__model__brand",
            "address__city__province",
        ),
        ad_id=ad_id,
        userid=profile,
    )

    context = {
        "profile": profile,
        "ad": ad,
        "edit_mode": True,

        "vehicle_type": ad.vehicle.model.category,
        "brand_id": ad.vehicle.model.brand_id,
        "model_id": ad.vehicle.model_id,

        "province_id": ad.address.city.province_id,
        "city_id": ad.address.city_id,

        "brands": Brand.objects.all(),

        "provinces": Province.objects.prefetch_related("cities"),

        "cities": (
            profile.default_address.city.province.cities.all()
            if profile.default_address
            else []
        ),

        "instalment": getattr(ad, "instalment", None),
        "remittance": getattr(ad, "remittance", None),

    }

    return render(
        request,
        "advertisements/post_ad.html",
        context,
    )