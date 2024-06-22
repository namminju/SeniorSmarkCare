from django.db import models
from accounts.models import User
from django.dispatch import receiver
from django.db.models.signals import post_save

class MedicalHistory(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    reservationDate = models.DateField()
    reservationTime = models.TimeField()
    isDone = models.BooleanField(default=False)

