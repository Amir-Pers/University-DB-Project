from django.db import models

class ContactMessages(models.Model):
    class SubjectChoices(models.TextChoices):
        SUPPORT = 'support', 'پشتیبانی فنی'
        AD = 'ad', 'مشکل در آگهی'
        COOPERATION = 'cooperation', 'همکاری و تبلیغات'
        OTHER = 'other', 'سایر موارد'
    
    contact_message_id = models.AutoField(primary_key=True)
    full_name = models.CharField(max_length=150)
    phone = models.CharField(max_length=20)
    email = models.EmailField(max_length=254)  
    subject = models.CharField(
        max_length=30,
        choices=SubjectChoices.choices,
        default=SubjectChoices.OTHER
    )
    message = models.TextField()
    created_date = models.DateTimeField(auto_now_add=True)
    is_read = models.BooleanField(default=False)
    
    class Meta:
        managed = False  
        db_table = 'ContactMessages'  
    
    def __str__(self):
        return f"{self.full_name} - {self.get_subject_display()}"