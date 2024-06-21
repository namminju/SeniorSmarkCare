from django.urls import path
from .views import *

urlpatterns = [
    path('alarm-cnt/', ExerciseCntView.as_view()),
    path('time/', ExerciseTimeView.as_view()),
]
