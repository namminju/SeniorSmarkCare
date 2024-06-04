from django.urls import path
from .views import *
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('signup/', SignupView.as_view()),
    path('login/', auth_views.LoginView.as_view(template_name = 'login.html'), name = 'login'),
]

