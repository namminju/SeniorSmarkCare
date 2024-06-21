from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from .models import DailySymptom
from .serializers import *

class HeadSymptomCreateView(generics.CreateAPIView):
    serializer_class = HeadSymptomSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class UpperBodySymptomCreateView(generics.CreateAPIView):
    serializer_class = UpperBodySymptomSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class LowerBodySymptomCreateView(generics.CreateAPIView):
    serializer_class = LowerBodySymptomSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class HandFootSymptomCreateView(generics.CreateAPIView):
    serializer_class = HandFootSymptomSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class DailySymptomListView(generics.ListAPIView):
    serializer_class = DailySymptomSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return DailySymptom.objects.filter(user=user).order_by('symptom_date')