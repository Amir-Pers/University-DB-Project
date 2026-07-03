from django.db.models import Prefetch, Q
from django.shortcuts import render
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

from advertisements.models import Advertisement, Image
from vehicles.models import Car, Motorcycle, Brand


def index(request):
    search = request.GET.get('fSearch', '').strip()
    ad_type = request.GET.get('fType', '')
    brand_id_str = request.GET.get('fBrand', '')
    price_min = request.GET.get('fPriceMin', '')
    price_max = request.GET.get('fPriceMax', '')

    try:
        selected_brand_id = int(brand_id_str) if brand_id_str else None
    except ValueError:
        selected_brand_id = None

    type_choices = [
        {'value': '', 'label': 'نوع: همه', 'is_selected': not ad_type},
        {'value': 'car', 'label': 'خودرو', 'is_selected': ad_type == 'car'},
        {'value': 'moto', 'label': 'موتورسیکلت', 'is_selected': ad_type == 'moto'},
    ]

    # ---- پایه کوئری ----
    qs = Advertisement.objects.filter(
        active_status=True,
        published=True,
    ).select_related(
        "vehicle",
        "vehicle__model",
        "vehicle__model__brand",
        "userid",
        "address",
        "address__city",
    ).prefetch_related(
        Prefetch(
            "images",
            queryset=Image.objects.order_by("image_id"),
        )
    ).order_by("-created_date")

    if search:
        qs = qs.filter(
            Q(vehicle__model__brand__name__icontains=search) |
            Q(vehicle__model__name__icontains=search)
        )

    if selected_brand_id is not None:
        qs = qs.filter(vehicle__model__brand_id=selected_brand_id)

    if ad_type == 'car':
        qs = qs.filter(vehicle__car__isnull=False)
    elif ad_type == 'moto':
        qs = qs.filter(vehicle__motorcycle__isnull=False)

    if price_min:
        try:
            min_toman = int(float(price_min)) * 1_000_000
            qs = qs.filter(price__gte=min_toman)
        except ValueError:
            pass

    if price_max:
        try:
            max_toman = int(float(price_max)) * 1_000_000
            qs = qs.filter(price__lte=max_toman)
        except ValueError:
            pass

    total_filtered = qs.count()

    paginator = Paginator(qs, 12)
    page_number = request.GET.get('page', 1)
    try:
        page_obj = paginator.page(page_number)
    except PageNotAnInteger:
        page_obj = paginator.page(1)
    except EmptyPage:
        page_obj = paginator.page(paginator.num_pages)

    advertisements = page_obj.object_list

    total_ads = Advertisement.objects.filter(
        active_status=True, published=True
    ).count()

    car_count = Car.objects.filter(
        vehicle__advertisements__published=True,
        vehicle__advertisements__active_status=True,
    ).distinct().count()

    motorcycle_count = Motorcycle.objects.filter(
        vehicle__advertisements__published=True,
        vehicle__advertisements__active_status=True,
    ).distinct().count()

    brands = Brand.objects.all().order_by('name')
    brand_list = []
    for brand in brands:
        brand_list.append({
            'brand': brand,
            'is_selected': (selected_brand_id == brand.brand_id)
        })

    context = {
        "advertisements": advertisements,
        "total_ads": total_ads,
        "car_count": car_count,
        "motorcycle_count": motorcycle_count,
        "brand_list": brand_list,           
        "type_choices": type_choices,       
        "total_filtered": total_filtered,
        "page_obj": page_obj,
    }

    return render(request, "home/index.html", context)