from django.db import models
from accounts.models import User
from django.dispatch import receiver
from django.db.models.signals import post_save

class Exercise(models.Model):
    EXERCISE_CNT = [(1, 1), (2, 2), (3, 3), (4, 4), (5, 5)]
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    exerciseAlarmCnt = models.IntegerField(choices= EXERCISE_CNT, default=3)
    exerciseTime1 = models.TimeField(null=True, blank=True)
    exerciseTime2 = models.TimeField(null= True, blank=True)
    exerciseTime3 = models.TimeField(null=True, blank=True)
    exerciseTime4 = models.TimeField(null=True, blank=True)
    exerciseTime5 = models.TimeField(null=True, blank=True)

@receiver(post_save, sender=User)
def create_user_exercise(sender, instance, created, **kwargs):
    if created:
        Exercise.objects.create(user=instance)