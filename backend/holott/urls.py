from django.urls import path
from .views import *

urlpatterns = [
    path('mypage/', mypage, name = 'mypage'),
    path('', main, name = 'main'),
]