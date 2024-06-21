import logging
from .models import Disease
from .serializers import PastDiseaseSerializer, CurrentDiseaseSerializer
from rest_framework import generics, status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

logger = logging.getLogger('diseaase')

class PastDiseaseView(generics.RetrieveUpdateAPIView):
    serializer_class = PastDiseaseSerializer
    queryset = Disease.objects.all()
    permission_classes = [IsAuthenticated]
    lookup_field = 'user'
    lookup_url_kwarg = 'user'

    def get_object(self):
        return Disease.objects.get(user = self.request.user)
    
    def update(self, request, *args, **kwargs):
        logger.debug(f"Updating PastDisease for request data: {request.data}")
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        mutable_data = request.data.copy()  # QueryDict를 복사하여 mutable로 만듦
        serializer = self.get_serializer(instance, data=mutable_data, partial=partial)
        if serializer.is_valid():
            logger.debug(f"Serializer valid with data: {serializer.validated_data}")
            self.perform_update(serializer)
            return Response(serializer.data)
        else:
            logger.debug(f"Serializer errors: {serializer.errors}")
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class CurrentDiseaseView(generics.RetrieveUpdateAPIView):
    serializer_class = CurrentDiseaseSerializer
    queryset = Disease.objects.all()
    permission_classes = [IsAuthenticated]
    lookup_field = 'user'
    lookup_url_kwarg = 'user'

    def get_object(self):
        return Disease.objects.get(user = self.request.user)

    def update(self, request, *args, **kwargs):
        logger.debug(f"Updating CurrentDisease for request data: {request.data}")
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        mutable_data = request.data.copy()  # QueryDict를 복사하여 mutable로 만듦
        serializer = self.get_serializer(instance, data=mutable_data, partial=partial)
        if serializer.is_valid():
            logger.debug(f"Serializer valid with data: {serializer.validated_data}")
            self.perform_update(serializer)
            return Response(serializer.data)
        else:
            logger.debug(f"Serializer errors: {serializer.errors}")
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
