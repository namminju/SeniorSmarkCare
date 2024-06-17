from .serializers import *
from .models import *
from rest_framework.response import Response
from rest_framework import status, generics

class MealView(generics.RetrieveUpdateAPIView):
    serializer_class = Meal
    queryset = Meal.objects.all()
    
