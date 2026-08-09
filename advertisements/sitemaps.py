from django.contrib.sitemaps import Sitemap
from .models import Advertisement


class AdvertisementSitemap(Sitemap):
    changefreq = "daily"
    priority = 0.5

    def items(self):
        return Advertisement.objects.filter(published=True)

    def lastmod(self, obj):
        return obj.created_date