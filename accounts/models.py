from django.db import models
from django.contrib.auth.models import User as AuthUser
from locations.models import Address

class User(models.Model):
    userid = models.AutoField(primary_key=True)

    user_auth = models.OneToOneField(
        AuthUser,
        on_delete=models.CASCADE,
        db_column="user_auth_id",
        blank=True,
        null=True,
        related_name="profile",
    )

    default_address = models.ForeignKey(
    Address,
    on_delete=models.SET_NULL,
    db_column="address_id",
    blank=True,
    null=True,
    related_name="default_users",
    )

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