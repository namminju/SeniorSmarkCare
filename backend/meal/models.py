from django.db import models
from accounts.models import User

class Meal(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, primary_key=True)

    mealAlarmCnt = models.IntegerField()
    mealTime1 = models.TimeField(null=True, blank=True)
    mealTime2 = models.TimeField(null= True, blank=True)
    mealTime3 = models.TimeField(null=True, blank=True)