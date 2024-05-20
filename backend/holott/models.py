from django.db import models

class User(models.Model):
    userName = models.CharField(max_length=50)
    userBirth = models.DateField()
    userGender = models.CharField(max_length=12)
    userPhone = models.CharField(max_length=12)
    guardPhone = models.CharField(max_length=12)
    userPassword = models.CharField(max_length=16)
    userType = models.CharField(max_length=12)
    mealAlarmCnt = models.IntegerField(default=3)
    exerciseAlarmCnt = models.IntegerField(default=3)