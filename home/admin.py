from django.contrib import admin
from .models import ContactMessages
# Register your models here.

class ContactMessagesAdmin(admin.ModelAdmin):
    list_display = ["subject", "full_name", "email", "is_read", "created_date"]
    list_filter = ["subject", "is_read"]
    search_fields = ["message", "email", "full_name"]
    ordering = ["-created_date"]

admin.site.register(ContactMessages, ContactMessagesAdmin)