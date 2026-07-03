from django.urls import path, include
from . import views

app_name = "home"

urlpatterns = [
    path("", views.index, name="index"), 
    path("contact/", views.contact_view, name="contact"), 
    path("faq/", views.faq_view, name="faq"), 
    path("privacy/", views.privacy_view, name="privacy"), 
    path("terms/", views.terms_view, name="terms"), 
]
