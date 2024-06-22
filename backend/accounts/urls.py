from django.urls import path
from .views import *
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('signup/', SignupView.as_view()),
    path('login/', LoginView.as_view()),
    path('addinfo/', AddInfoView.as_view()),
    path('mypage/', MypageView.as_view()),
    path('hospital/', HospitalView.as_view()),
    path('address/', AddressCreateView.as_view()),
    path('address/search/', AddressSearchView.as_view()),
    path('address/my', AddressUpdateView.as_view()),
    path('phone/', UserPhoneView.as_view()),
]

