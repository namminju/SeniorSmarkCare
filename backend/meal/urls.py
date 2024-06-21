from django.urls import path
from .views import *

urlpatterns = [
    path('alarm-cnt/', MealCntView.as_view()),
    path('time/', MealTimeView.as_view()),
]

