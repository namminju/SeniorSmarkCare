from django.contrib import admin
from .models import *

admin.site.register(SymptomCategory)
admin.site.register(Symptom)
admin.site.register(DailySymptom)