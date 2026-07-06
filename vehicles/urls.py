from django.urls import path
from . import views

app_name = "vehicles"

urlpatterns = [
    path("brands/", views.vehicle_brands, name="vehicle_brands"),
    path("models/", views.vehicle_models, name="vehicle_models"),
]