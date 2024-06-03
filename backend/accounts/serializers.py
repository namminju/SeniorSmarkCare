from rest_framework import serializers
from .models import User
from django.core.validators import RegexValidator

class SignupSerializer(serializers.ModelSerializer):
    password1 = serializers.CharField(write_only=True)
    password2 = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = '__all__'

    def validate(self, data):
        if data['password1'] != data['password2']:
            raise serializers.ValidationError("Passwords don't match")
        return data

    def create(self, validated_data):
        user = User.objects.create_user(
            userName=validated_data['userName'],
            userPhone=validated_data['userPhone'],
            password=validated_data['password1'],
            userBirth=validated_data.get('userBirth'),
            userGender=validated_data.get('userGender'),
            userType=validated_data.get('userType'),
            mealAlarmCnt=validated_data.get('mealAlarmCnt', 3),
            exerciseAlarmCnt=validated_data.get('exerciseAlarmCnt', 3),
            guardPhone=validated_data.get('guardPhone'),
        )
        return user
