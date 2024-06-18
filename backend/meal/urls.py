from django.urls import path
from .views import *
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('alarm-cnt/<int:pk>', MealCntView.as_view()),
    path('set-time/<int:pk>', MealTimeView.as_view()),
]

