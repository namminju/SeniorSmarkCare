from .serializers import *
from .models import *
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated

class MealTimeView(generics.RetrieveUpdateAPIView):
    serializer_class = MealTimeSerializer
    queryset = Meal.objects.all()
    permission_classes = [IsAuthenticated]
    lookup_field = 'user'
    lookup_url_kwarg = 'user'

    def get_object(self):
        return Meal.objects.get(user = self.request.user)
    def perform_update(self, serializer):
        serializer.save(user=self.request.user)


class MealCntView(generics.RetrieveUpdateAPIView):
    serializer_class = MealCntSerializer
    queryset = Meal.objects.all()
    permission_classes = [IsAuthenticated]
    lookup_field = 'user'
    lookup_url_kwarg = 'user'

    def get_object(self):
        return Meal.objects.get(user = self.request.user)
    
    def perform_update(self, serializer):
        serializer.save(user=self.request.user)