from django.db import models
from accounts.models import User
from django.db.models.signals import post_migrate
from django.dispatch import receiver

class SymptomCategory(models.Model):
    CATEGORY_CHOICES = [
        ('HEAD', '머리'),
        ('UPPER_BODY', '상체'),
        ('LOWER_BODY', '하체'),
        ('HAND_FOOT', '손/발')
    ]
    name = models.CharField(choices=CATEGORY_CHOICES, max_length=20, unique=True)

    def __str__(self):
        return self.get_name_display()

class Symptom(models.Model):
    category = models.ForeignKey(SymptomCategory, on_delete=models.CASCADE)
    name = models.CharField(max_length=50)
    display_name = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.display_name} ({self.category.get_name_display()})"

class DailySymptom(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    symptom_date = models.DateField()
    head_symptoms = models.ManyToManyField(Symptom, related_name='head_symptoms', blank=True)
    upper_body_symptoms = models.ManyToManyField(Symptom, related_name='upper_body_symptoms', blank=True)
    lower_body_symptoms = models.ManyToManyField(Symptom, related_name='lower_body_symptoms', blank=True)
    hand_foot_symptoms = models.ManyToManyField(Symptom, related_name='hand_foot_symptoms', blank=True)

    def __str__(self):
        return f"{self.user.userName} - {self.symptom_date}"

@receiver(post_migrate)
def load_initial_symptoms(sender, **kwargs):
    if sender.name == 'symptom': 
        categories = {
            'HEAD': [('pressure', '압박감'), ('eye', '눈 부위 통증'), ('chinFace', '턱 및 얼굴 통증'), ('ear', '귀 통증'), ('acuteHeadache', '급성 두통'), ('chronicHeadache', '만성 두통'), ('other', '기타')],
            'UPPER_BODY': [('chestPain', '가슴 통증'), ('chestPressure', '가슴 압박'), ('heart', '심장 두근거림'), ('shoulder', '어깨 통증'), ('elbow', '팔꿈치 통증'), ('back', '등 및 허리 통증'), ('stomach', '복통'), ('other', '기타')],
            'LOWER_BODY': [('thigh', '허벅지 통증'), ('hip', '엉덩이 통증'), ('knee', '무릎 통증'), ('leg', '종아리 통증'), ('numbness', '하체 저림'), ('joint pain', '하체 관절 통증'), ('other', '기타')],
            'HAND_FOOT': [('numbness', '손/발 저림'), ('finger', '손가락 통증'), ('wrist', '손목 통증'), ('toe', '발가락 통증'), ('ankle', '발목 통증'), ('fatigue', '손/발 피로감'), ('joint pain', '손/발 관절 통증'), ('other', '기타')],
        }
        for category_name, symptoms in categories.items():
            category, created = SymptomCategory.objects.get_or_create(name=category_name)
            for symptom_name, display_name in symptoms:
                Symptom.objects.get_or_create(category=category, name=symptom_name, display_name=display_name)
