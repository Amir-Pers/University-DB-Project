from django.urls import path
from . import views

app_name = "locations"


urlpatterns = [
    path("cities/", views.cities_by_province, name='cities')
]