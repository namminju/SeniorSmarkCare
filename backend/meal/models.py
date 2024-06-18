from django.db import models
from accounts.models import User
from django.dispatch import receiver
from django.db.models.signals import post_save

class Meal(models.Model):
    MEAL_CNT = [(1, 1), (2, 2), (3, 3)]
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    mealAlarmCnt = models.IntegerField(choices= MEAL_CNT, default=3)
    mealTime1 = models.TimeField(null=True, blank=True)
    mealTime2 = models.TimeField(null= True, blank=True)
    mealTime3 = models.TimeField(null=True, blank=True)

@receiver(post_save, sender=User)
def create_user_meal(sender, instance, created, **kwargs):
    if created:
        Meal.objects.create(user=instance)