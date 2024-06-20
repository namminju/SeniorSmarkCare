from django.urls import path
from .views import *

urlpatterns = [
    path('record', SymtomView.as_view())
]