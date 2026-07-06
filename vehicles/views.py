from django.http import JsonResponse

from .models import VehicleModel, Brand


def vehicle_brands(request):

    category = request.GET.get("category")

    if not category:
        return JsonResponse([], safe=False)

    brands = (
        Brand.objects
        .filter(models__category=category)
        .distinct()
        .order_by("name")
    )

    data = [
        {
            "id": brand.brand_id,
            "name": brand.name,
        }
        for brand in brands
    ]

    return JsonResponse(data, safe=False)


def vehicle_models(request):
    
    brand_id = request.GET.get("brand")

    models = VehicleModel.objects.filter(brand_id=brand_id).order_by("name")

    data = [
        {
            "id" : model.model_id,
            "name": model.name,
        }
        for model in models
    ]

    return JsonResponse(data=data, safe=False)