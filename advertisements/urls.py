from django.urls import path, include
from . import views

urlpatterns = [
    path("ad_detail/", views.ad_detail_view, name="ad_detail"),
]
