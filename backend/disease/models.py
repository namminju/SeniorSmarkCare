from django.db import models
from accounts.models import User
from django.dispatch import receiver
from django.db.models.signals import post_save
from multiselectfield import MultiSelectField


class Disease(models.Model):
    DISEASE_LIST = [('HYPERTENSION', '고혈압'), ('HEART_DISEASE', '심장 질환'), ('DIABETES', '당뇨'), ('ALLERGY', '알레르기'), ('TUBERCULOSIS', '결핵'), ('HEPATITIS', '간염'), ('OTHERS', '기타'), ('NONE', '없음')]
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    pastDisease = MultiSelectField(choices=DISEASE_LIST, max_length=30, null=True, blank=True)
    currentDisease = MultiSelectField(choices=DISEASE_LIST, max_length= 30, null=True, blank=True)
    hasSurgicalHistory = models.BooleanField(default=False)



@receiver(post_save, sender=User)
def create_user_disease(sender, instance, created, **kwargs):
    if created:
        Disease.objects.create(user=instance)