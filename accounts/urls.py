from django.urls import path, include
from . import views

app_name = "accounts"

urlpatterns = [
    path("", views.profile_view, name="profile"),
    path("login", views.login_view, name="login"),
    path("register", views.register_view, name="register"),
]
