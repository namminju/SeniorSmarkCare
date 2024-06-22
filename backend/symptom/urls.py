from django.urls import path
from .views import *

urlpatterns = [
    path('create/head', HeadSymptomCreateView.as_view()),
    path('create/upper_body', UpperBodySymptomCreateView.as_view()),
    path('create/lower_body', LowerBodySymptomCreateView.as_view()),
    path('create/hand_foot', HandFootSymptomCreateView.as_view()),
    path('list/', DailySymptomListView.as_view()),
    path('<str:category_name>/', CategorySymptomListView.as_view()),
]
