from django.urls import path
from .views import *

urlpatterns = [
    path('', MedicalHistoryView.as_view()),
]