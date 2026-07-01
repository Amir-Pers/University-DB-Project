from django.db import models

class Province(models.Model):
    province_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'Province'
        ordering = ["name"]

    def __str__(self):
        return self.name


class City(models.Model):
    city_id = models.AutoField(primary_key=True)
    province = models.ForeignKey('Province', on_delete=models.CASCADE, related_name="cities",)
    name = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'City'
        ordering = ["name"]


    def __str__(self):
        return self.name


class Address(models.Model):
    address_id = models.AutoField(primary_key=True)
    city = models.ForeignKey('City', on_delete=models.CASCADE, related_name="addresses")
    neighborhood = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'Address'
        
    def __str__(self):
        if self.neighborhood:
            return f"{self.city.name} - {self.neighborhood}"
        return self.city.name