from django.shortcuts import render
from advertisements.models import Advertisement


def index(request):

    advertisements = (
        Advertisement.objects.filter(active_status=True, published=True)
        .select_related(
            "vehicle",
            "vehicle__model",
            "vehicle__model__brand",
            "userid",
            "address",
            "address__city",
        )
        .order_by("-created_date")
    )

    context = {
        "advertisements": advertisements,
    }

    return render(request, "home/index.html", context)