from django.shortcuts import render, get_object_or_404
from django.db.models import Prefetch

from .models import Advertisement, Image


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