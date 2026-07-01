from django.contrib import admin
from .models import User


class UserAdmin(admin.ModelAdmin):
    list_display=['userid', 'username', 'phone', 'reg_status', "account_status"]
    search_fields = ['username', 'phone', 'national_id']
    list_filter = ['reg_status', 'account_status']



admin.site.register(User, UserAdmin)