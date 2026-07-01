from django.db import models


class User(models.Model):
    userid = models.AutoField(primary_key=True)
    phone = models.CharField(max_length=20, unique=True)
    reg_status = models.BooleanField(default=False)
    account_status = models.BooleanField(default=True)
    register_date = models.DateTimeField(blank=True, null=True)
    national_id = models.CharField(max_length=10, blank=True, null=True)
    username = models.CharField(max_length=50, unique=True, blank=True, null=True)

    class Meta:
        managed = False
        db_table = "User"
        verbose_name = "User"
        verbose_name_plural = "Users"

    def __str__(self):
        return self.username or self.phone