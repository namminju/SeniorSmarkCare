from .models import *
from .serializers import *
from rest_framework import generics, status
from rest_framework.permissions import IsAuthenticated

class SymtomView(generics.CreateAPIView):
    serializer_class = SymtomSerializer
    permission_classes = [IsAuthenticated]
    lookup_field = 'user'
    lookup_url_kwarg = 'user'

    def get_object(self):
        return DailySymtom.objects.get(user = self.request.user)
