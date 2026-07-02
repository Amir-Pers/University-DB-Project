from django.db.models import Prefetch
from django.shortcuts import render

from advertisements.models import Advertisement, Image
from vehicles.models import Car, Motorcycle


def index(request):

    advertisements = (
        Advertisement.objects.filter(
            active_status=True,
            published=True,
        )
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
        .order_by("-created_date")
    )

    total_ads = advertisements.count()

    car_count = Car.objects.filter(
        vehicle__advertisements__published=True,
        vehicle__advertisements__active_status=True,
    ).count()

    motorcycle_count = Motorcycle.objects.filter(
        vehicle__advertisements__published=True,
        vehicle__advertisements__active_status=True,
    ).count()

    context = {
        "advertisements": advertisements,
        "total_ads": total_ads,
        "car_count": car_count,
        "motorcycle_count": motorcycle_count,
    }

    return render(request, "home/index.html", context)