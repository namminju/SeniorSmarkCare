from django.db import models
from accounts.models import User
from multiselectfield import MultiSelectField
from django.dispatch import receiver
from django.db.models.signals import post_save
from datetime import date

class DailySymtom(models.Model):
    HEAD = [('pressure', '압박감'), ('eye', '눈 부위 통증'), ('chinFace', '턱 및 얼굴 통증'), ('ear', '귀 통증'), ('acuteHeadache', '급성 두통'), ('chronicHeadache', '만성 두통'), ('other', '기타')]
    UPPER_BODY = [('chest', '가슴 통증'), ('stomach', '복통'), ('indigestion', '소화불량'), ('other', '기타 ')]
    LOWER_BODY = [('thigh', '허벅지 통증'), ('other', '기타')]
    HAND_FOOT = [('numbness', '손/발 저림'), ('other', '기타')]

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    symtomDate = models.DateField(null=True, blank=True)
    symtomHead = MultiSelectField(choices=HEAD, max_length = 100, null=True, blank=True)
    symtomUpperBody = MultiSelectField(choices=UPPER_BODY, max_length=100, null=True, blank=True)
    symtomLowerBody = MultiSelectField(choices=LOWER_BODY, null=True, max_length=100, blank=True)
    symtomHandFoot = MultiSelectField(choices=HAND_FOOT, max_length=100, null = True, blank = True)

@receiver(post_save, sender=User)
def create_daily_symtom(sender, instance, created, **kwargs):
    if created:
        DailySymtom.objects.create(user=instance, symtomDate = date.today())