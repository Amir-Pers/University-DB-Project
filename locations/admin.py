from django.contrib import admin
from .models import Province, City, Address

class ProvinceAdmin(admin.ModelAdmin):
    list_display = ['province_id', 'name']
    search_fields = ['name']


class CityAdmin(admin.ModelAdmin):
    list_display = ['city_id', 'name', 'province']
    search_fields = ['name']
    list_filter = ['province']


class AddressAdmin(admin.ModelAdmin):
    list_display = ['address_id', 'city', 'neighborhood']
    search_fields = ("city__name", "neighborhood")
    list_filter = ("city__province",)


admin.site.register(Province, ProvinceAdmin)
admin.site.register(City, CityAdmin)
admin.site.register(Address, AddressAdmin)


