from django.db import models


class Brand(models.Model):
    brand_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    country = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'Brand'
        ordering = ["name"]

    def __str__(self):
        return self.name


class VehicleModel(models.Model):
    model_id = models.AutoField(primary_key=True)
    brand = models.ForeignKey(Brand, on_delete=models.CASCADE, related_name="models")
    name = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'Model'
        ordering = ["brand", 'name']

    def __str__(self):
        return f"{self.brand.name} {self.name}"


class Vehicle(models.Model):
    vehicle_id = models.AutoField(primary_key=True)
    model = models.ForeignKey(VehicleModel, on_delete=models.CASCADE, related_name="vehicles",)
    production_year = models.IntegerField(blank=True, null=True)
    color_out = models.CharField(max_length=50)
    color_in = models.CharField(max_length=50, blank=True, null=True)
    transmission_type = models.CharField(max_length=50, blank=True, null=True)
    fuel_type = models.CharField(max_length=50)
    consumption = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'Vehicle'

    def __str__(self):
        return f"{self.model.name}({self.production_year})"


class Car(models.Model):
    vehicle = models.OneToOneField('Vehicle', on_delete=models.CASCADE, primary_key=True, related_name="car")
    body_type = models.CharField(max_length=50)
    engine = models.CharField(max_length=100, blank=True, null=True)
    cylinder_volume = models.IntegerField(blank=True, null=True)
    enginepower = models.IntegerField(blank=True, null=True)
    torque = models.IntegerField(blank=True, null=True)
    accelerate = models.DecimalField(max_digits=4, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'Car'

    def __str__(self):
        return str(self.vehicle)


class Motorcycle(models.Model):
    vehicle = models.OneToOneField('Vehicle', on_delete=models.CASCADE, primary_key=True, related_name="motorcycle",)
    class_field = models.CharField(db_column='class', max_length=50, blank=True, null=True)  # Field renamed because it was a Python reserved word.
    engine = models.CharField(max_length=100, blank=True, null=True)
    engine_cc = models.IntegerField(blank=True, null=True)
    gearbox = models.CharField(max_length=50, blank=True, null=True)
    weight = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'Motorcycle'

    def __str__(self):
        return str(self.vehicle)


class HeavyVehicle(models.Model):
    vehicle = models.OneToOneField('Vehicle', on_delete=models.CASCADE, primary_key=True, related_name="heavy_vehicle")
    heavy_type = models.CharField(max_length=50)
    usage = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'HeavyVehicle'

    def __str__(self):
        return str(self.vehicle)