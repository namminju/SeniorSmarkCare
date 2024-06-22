import requests
from .serializers import *
from .models import *
from rest_framework.response import Response
from rest_framework import status, generics
from rest_framework.permissions import IsAuthenticated, AllowAny
from django.conf import settings
from rest_framework.views import APIView
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi

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
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            validated_data = serializer.validated_data
            return Response({"token": validated_data['token'], "user": validated_data['user'].id}, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)


class AddInfoView(generics.RetrieveUpdateAPIView):
    serializer_class = UserInfoSerializer
    queryset = UserExtra.objects.all()
    permission_classes = [IsAuthenticated]
    lookup_field = 'user'
    lookup_url_kwarg = 'user'
    
    def get_object(self):
        return UserExtra.objects.get(user = self.request.user)


class HospitalView(generics.RetrieveUpdateAPIView):
    serializer_class = HospitalCallSerializer
    queryset = UserExtra.objects.all()
    permission_classes = [IsAuthenticated]
    lookup_field = 'user'
    lookup_url_kwarg = 'user'
    
    def get_object(self):
        return UserExtra.objects.get(user = self.request.user)


class MypageView(generics.GenericAPIView):
    serializer_class = LoginSerializer
    permission_classes = [IsAuthenticated]
    
    def get(self, request):
        user = request.user
        serializer = LoginSerializer(user)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
class AddressCreateView(generics.CreateAPIView):
    serializer_class = UserAddressSerializer
    permission_classes = [IsAuthenticated]
    queryset = UserAddress.objects.all()

    def get_object(self):
        return UserAddress.objects.get(user = self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class AddressUpdateView(generics.RetrieveUpdateAPIView):
    serializer_class = UserAddressSerializer
    permission_classes = [IsAuthenticated]
    queryset = UserAddress.objects.all()

    def get_object(self):
        return UserAddress.objects.get(user = self.request.user)


class AddressSearchView(APIView):
    permission_classes = [IsAuthenticated]
    query_param = openapi.Parameter('query', openapi.IN_QUERY, description="Search query", type=openapi.TYPE_STRING)

    @swagger_auto_schema(manual_parameters=[query_param])
    def get(self, request):
        query = request.query_params.get('query')

        if not query:
            return Response({"error": "Query parameter is required"}, status=400)
        
        api_key = settings.GOOGLE_PLACES_API_KEY
        url = f"https://maps.googleapis.com/maps/api/place/autocomplete/json?input={query}&key={api_key}&language=ko"
        response = requests.get(url)
        
        if response.status_code != 200:
            return Response({"error": "Failed to fetch data from Google Places API"}, status=response.status_code)
        
        return Response(response.json())
    
class UserPhoneView(generics.RetrieveUpdateAPIView):
    serializer_class = UserPhoneSerializer
    queryset = User.objects.all()
    permission_classes = [IsAuthenticated]
    
    def get_object(self):
        return self.request.user
    