from .serializers import *
from .models import User
from rest_framework.response import Response
from rest_framework import status
from rest_framework import generics

class SignupView(generics.CreateAPIView):
    serializer_class = SignupSerializer
    def post(self, request):
        try:
            queryset = User.objects.all()
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response({"message": "User created successfully"}, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)


class LoginView(generics.GenericAPIView):
    serializer_class = LoginSerializer
    def post(self, request):
        try:
            serializer = self.get_serializer(data = request.data)
            serializer.is_valid(raise_exception = True)
            token = serializer.validated_data
            return Response({"token": token.key}, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)

         