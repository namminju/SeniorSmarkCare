from .models import User
from django.contrib.auth.password_validation import validate_password # Django의 기본 pw 검증 도구
from rest_framework.validators import UniqueValidator
from rest_framework.authtoken.models import Token
from rest_framework import serializers

class SignupSerializer(serializers.ModelSerializer):
    userName = serializers.CharField(
        required = True,
        validators = [UniqueValidator(queryset=User.objects.all())]
    )
    password1 = serializers.CharField(
        write_only=True,
        required=True,
        validators=[validate_password], # 비밀번호에 대한 검증
    )
    password2 = serializers.CharField( # 비밀번호 확인을 위한 필드
        write_only=True,
        required=True,
    )

    class Meta:
        model = User
        fields = [
            'userName', 'userPhone', 'password1', 'password2'
        ]

    def validate(self, data):
        if data['password1'] != data['password2']:
            raise serializers.ValidationError("Passwords don't match")
        return data

    def create(self, validated_data):
        user = User.objects.create_user(
            userName = validated_data['userName'],
            userPhone = validated_data['userPhone'],
        )
        user.set_password(validated_data['password1'])
        user.save()
        token = Token.objects.create(user = user)
        return user
