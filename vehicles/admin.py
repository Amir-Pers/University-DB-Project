from django.contrib import admin
from .models import (
    Brand,
    VehicleModel,
    Vehicle,
    Car,
    Motorcycle,
    HeavyVehicle,
)


class BrandAdmin(admin.ModelAdmin):
    list_display = ["brand_id", "name", "country"]
    search_fields = (
        "name",
        "country",
    )

class VehicleModelAdmin(admin.ModelAdmin):
    list_display = ['model_id' , 'brand', 'name']
    search_fields = ('name', 'brand__name')
    list_filter = ['brand']


class VehicleAdmin(admin.ModelAdmin):
    list_display = (
        "vehicle_id",
        "model",
        "production_year",
        "fuel_type",
        "transmission_type"
    )
    search_fields = ["model__name", "model__brand__name"]
    list_filter = ["production_year", "fuel_type", "transmission_type"]
    autocomplete_fields = ("model",)


class CarAdmin(admin.ModelAdmin):
    list_display = (
        "vehicle",
        "body_type",
        "engine",
        "enginepower",
        "cylinder_volume",
        "accelerate",
    )
    list_filter = ["body_type", ]
    search_fields = ["vehicle__model__name","vehicle__model__brand__name",]
    autocomplete_fields = ("vehicle",)

class MotorcycleAdmin(admin.ModelAdmin):
    list_display = ["vehicle" ,"class_field", "engine_cc", "gearbox", "weight"]
    list_filter = ("class_field", "gearbox")
    search_fields = ["vehicle__model__name", "vehicle__model__brand__name"]
    autocomplete_fields = ("vehicle",)


class HeavyVehicleAdmin(admin.ModelAdmin):
    list_display = ["vehicle","heavy_type","usage",]
    list_filter = ('heavy_type', )
    search_fields = ["vehicle__model__name", "vehicle__model__brand__name"]
    autocomplete_fields = ("vehicle",)



admin.site.register(Brand, BrandAdmin)
admin.site.register(VehicleModel, VehicleModelAdmin)
admin.site.register(Vehicle, VehicleAdmin)
admin.site.register(Car, CarAdmin)
admin.site.register(Motorcycle, MotorcycleAdmin)
admin.site.register(HeavyVehicle, HeavyVehicleAdmin)