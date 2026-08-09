from django.urls import path
from django.contrib.sitemaps.views import sitemap

from . import views
from .sitemaps import StaticViewSitemap
from advertisements.sitemaps import AdvertisementSitemap

app_name = "home"

sitemaps = {
    "static": StaticViewSitemap,
    "Advertisement": AdvertisementSitemap
}


urlpatterns = [
    path("", views.index, name="index"), 
    path("contact/", views.contact_view, name="contact"), 
    path("faq/", views.faq_view, name="faq"), 
    path("privacy/", views.privacy_view, name="privacy"), 
    path("terms/", views.terms_view, name="terms"), 
    path("sitemap.xml", sitemap,
        {"sitemaps": sitemaps},
        name="django.contrib.sitemaps.views.sitemap",
    ),
]
