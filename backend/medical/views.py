from rest_framework import generics
from .models import MedicalHistory
from .serializers import MedicalHistorySerializer
from rest_framework.permissions import IsAuthenticated

class MedicalHistoryView(generics.ListCreateAPIView):
    serializer_class = MedicalHistorySerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return MedicalHistory.objects.filter(user=self.request.user).order_by('-reservationDate')
    

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

