from django.urls import path
from .views import *

urlpatterns = [
    path('past/<int:pk>', PastDiseaseView.as_view()),
    path('current/<int:pk>', CurrentDiseaseView.as_view()),
]

