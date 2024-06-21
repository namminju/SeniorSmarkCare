from django.urls import path
from .views import *

urlpatterns = [
    path('past/', PastDiseaseView.as_view()),
    path('current/', CurrentDiseaseView.as_view()),
]

