from django.urls import path
from .views import *

urlpatterns = [
    path('alarm-cnt/<int:pk>', ExerciseCntView.as_view()),
    path('time/<int:pk>', ExerciseTimeView.as_view()),
]
