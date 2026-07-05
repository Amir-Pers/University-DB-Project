from django.http import JsonResponse

from .models import VehicleModel


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