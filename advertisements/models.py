from django.db import models

from accounts.models import User
from locations.models import Address
from vehicles.models import Vehicle


class Advertisement(models.Model):
    ad_id = models.AutoField(primary_key=True)
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE, related_name="advertisements")
    userid = models.ForeignKey(User, on_delete=models.CASCADE, db_column='userid', related_name="advertisements")
    address = models.ForeignKey(Address, on_delete=models.CASCADE, related_name="advertisements")
    title = models.CharField(max_length=255,)
    sell_type = models.CharField(max_length=60)
    price = models.DecimalField(max_digits=18, decimal_places=0, blank=True, null=True)
    descriptions = models.TextField(blank=True, null=True)
    published = models.BooleanField(default=False)
    created_date = models.DateTimeField(blank=True, null=True)
    updated_date = models.DateTimeField(blank=True, null=True)
    ad_type = models.CharField(max_length=50, blank=True, null=True)
    car_condition = models.CharField(max_length=50, blank=True, null=True)
    remittance_time = models.CharField(max_length=50, blank=True, null=True)
    km_age = models.IntegerField(blank=True, null=True)
    body_status = models.CharField(max_length=50, blank=True, null=True)
    free_zone = models.BooleanField(default=False)
    active_status = models.BooleanField(default=True)

    class Meta:
        managed = False
        db_table = 'Advertisement'

    def __str__(self):
        return self.title


class Image(models.Model):
    image_id = models.AutoField(primary_key=True)
    ad = models.ForeignKey(Advertisement, on_delete=models.CASCADE, related_name="images")
    # url = models.CharField(max_length=500)
    image = models.ImageField(
        upload_to="cars/",
        db_column="url",
        max_length=500,
    )
    upload_date = models.DateTimeField(blank=True, null=True)


    class Meta:
        managed = False
        db_table = 'Image'

    def __str__(self):
        return f"Image #{self.image_id} - {self.ad.title}"


class Video(models.Model):
    video_id = models.AutoField(primary_key=True)
    ad = models.ForeignKey(Advertisement, on_delete=models.CASCADE, related_name="videos")
    url = models.CharField(max_length=500)
    upload_date = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'Video'

    def __str__(self):
        return f"Video #{self.video_id} - {self.ad.title}"


class Instalment(models.Model):
    ad = models.OneToOneField(Advertisement, on_delete=models.CASCADE, primary_key=True, related_name="instalment")
    first_payment = models.DecimalField(max_digits=18, decimal_places=0)
    second_payment = models.DecimalField(max_digits=18, decimal_places=0, blank=True, null=True)
    payment_per_instalment = models.DecimalField(max_digits=18, decimal_places=0)
    payment_count = models.IntegerField()
    payment_period = models.CharField(max_length=50)
    delivery_date = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'Instalment'

    def __str__(self):
        return f"Instalment - {self.ad.title}"