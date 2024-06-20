from django.urls import path
from .views import *

urlpatterns = [
    path('alarm-cnt/<int:pk>', MealCntView.as_view()),
    path('time/<int:pk>', MealTimeView.as_view()),
]

