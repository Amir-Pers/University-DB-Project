from django.contrib import admin
from .models import Advertisement, Image, Video, Instalment
# Register your models here.


class ImageInline(admin.TabularInline):
    model = Image
    extra = 1


class VideoInline(admin.TabularInline):
    model = Video
    extra = 1


class InstalmentInline(admin.StackedInline):
    model = Instalment
    extra = 0
    max_num = 1

class AdvertisementAdmin(admin.ModelAdmin):
    list_display = ["ad_id", "title", "userid__username", "ad_type", "active_status",
                    "published", "created_date", "updated_date"]
    search_fields = ("title", "userid__username", 
                    "vehicle__model__name", "vehicle__model__brand__name",)
    list_filter = ["sell_type", "car_condition", "ad_type", 'published', "free_zone", "active_status", ]
    autocomplete_fields = ("userid", "vehicle", "address",)
    inlines = (ImageInline, VideoInline, InstalmentInline,)
    ordering = ["-created_date"]


class ImageAdmin(admin.ModelAdmin):
    list_display = ("image_id", "ad","url","upload_date",)
    ordering = ["-upload_date"]


class VideoAdmin(admin.ModelAdmin):
    list_display = ("video_id", "ad", "url", "upload_date",)
    ordering = ["-upload_date"]


class InstalmentAdmin(admin.ModelAdmin):
    list_display = ("ad", "first_payment", "payment_per_instalment", "payment_count",)


admin.site.register(Advertisement, AdvertisementAdmin)
admin.site.register(Image, ImageAdmin)
admin.site.register(Video, VideoAdmin)
admin.site.register(Instalment)
