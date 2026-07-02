from django.urls import path, include
from . import views

urlpatterns = [
    path("<int:ad_id>/", views.advertisement_detail, name="detail"),
]
