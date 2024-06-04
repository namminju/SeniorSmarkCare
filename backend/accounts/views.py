from .serializers import SignupSerializer
from .models import User
from django.contrib.auth import login
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView

class SignupView(APIView):
    def post(self, request):
        try:
            queryset = User.objects.all()
            serializer_class = SignupSerializer
            return Response({"message": "User created successfully"}, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
