from django.urls import path
from . import views

app_name = "vehicles"

urlpatterns = [
    path("models/", views.vehicle_models, name="vehicle_models"),
]