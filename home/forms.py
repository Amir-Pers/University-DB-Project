from django.forms import ModelForm
from django import forms
import re
from .models import ContactMessages

class ContactMessagesForm(ModelForm):

    class Meta:
        model = ContactMessages
        fields = ["full_name", "phone" ,'email', 'subject', 'message']

    def clean_phone(self):
        phone = self.cleaned_data.get('phone')
        if not re.match(r'^09\d{9}$', phone):
            raise forms.ValidationError('شماره تماس باید با 09 شروع شده و ۱۱ رقم باشد.')
        return phone

    import re

    def clean_full_name(self):
        name = self.cleaned_data.get('full_name')
        
        if len(name) < 3:
            raise forms.ValidationError('نام و نام خانوادگی باید حداقل ۳ کاراکتر باشد.')
        
        if not re.match(r'^[A-Za-z\u0600-\u06FF\s]+$', name):
            raise forms.ValidationError('نام و نام خانوادگی باید فقط شامل حروف (فارسی یا انگلیسی) باشد.')
        
        return name