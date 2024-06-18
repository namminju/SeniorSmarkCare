from .serializers import *
from .models import *
from .permissions import *
from rest_framework.response import Response
from rest_framework import status, generics
from rest_framework.permissions import IsAuthenticated, AllowAny

class SignupView(generics.CreateAPIView):
    serializer_class = SignupSerializer
    permission_classes = [AllowAny]
    def post(self, request):
        try:
            queryset = User.objects.all()
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            user = serializer.save()
            token, created = Token.objects.get_or_create(user=user)
            return Response({"message": "User created successfully", "token": token.key}, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)


class LoginView(generics.GenericAPIView):
    serializer_class = LoginSerializer
    permission_classes = [AllowAny]
    
    def post(self, request):
        try:
            serializer = self.get_serializer(data = request.data)
            serializer.is_valid(raise_exception = True)
            token = serializer.validated_data
            return Response({"token": token.key}, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)


class AddInfoView(generics.RetrieveUpdateAPIView):
    serializer_class = UserInfoSerializer
    queryset = UserExtra.objects.all()
    permission_classes = [CustomReadOnly]


class MypageView(generics.GenericAPIView):
    serializer_class = LoginSerializer
    permission_classes = [IsAuthenticated]
    
    def get(self, request):
        user = request.user
        serializer = LoginSerializer(user)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    """
    def put(self, request):
        user = request.user
        serializer = LoginSerializer(user, data= request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    """

