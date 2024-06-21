from .serializers import *
from .models import *
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated

class ExerciseTimeView(generics.RetrieveUpdateAPIView):
    serializer_class = ExerciseTimeSerializer
    queryset = Exercise.objects.all()
    permission_classes = [IsAuthenticated]
    lookup_field = 'user'
    lookup_url_kwarg = 'user'

    def get_object(self):
        return Exercise.objects.get(user = self.request.user)

    def perform_update(self, serializer):
        serializer.save(user=self.request.user)


class ExerciseCntView(generics.RetrieveUpdateAPIView):
    serializer_class = ExerciseCntSerializer
    queryset = Exercise.objects.all()
    permission_classes = [IsAuthenticated]
    lookup_field = 'user'
    lookup_url_kwarg = 'user'

    def get_object(self):
        return Exercise.objects.get(user = self.request.user)
    
    def perform_update(self, serializer):
        serializer.save(user=self.request.user)