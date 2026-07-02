from django.urls import path, include
from . import views

urlpatterns = [
    path("", views.account_view, name="account"),
]
