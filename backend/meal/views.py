from .serializers import *
from .models import *
from rest_framework.response import Response
from rest_framework import status, generics
from rest_framework.permissions import IsAuthenticated

class MealTimeView(generics.RetrieveUpdateAPIView):
    serializer_class = MealTimeSerializer
    queryset = Meal.objects.all()
    permission_classes = [IsAuthenticated]

    def perform_update(self, serializer):
        serializer.save(user=self.request.user)


class MealCntView(generics.RetrieveUpdateAPIView):
    serializer_class = MealCntSerializer
    queryset = Meal.objects.all()
    permission_classes = [IsAuthenticated]

    def perform_update(self, serializer):
        serializer.save(user=self.request.user)