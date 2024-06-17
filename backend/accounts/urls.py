from django.urls import path
from .views import *
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('signup/', SignupView.as_view()),
    path('login/', LoginView.as_view()),
    path('addinfo/<int:pk>', AddInfoView.as_view()),
]

