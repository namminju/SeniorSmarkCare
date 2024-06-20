from .models import *
from rest_framework import serializers

class SymtomSerializer(serializers.ModelSerializer):
    class Meta:
        model = DailySymtom
        fields = ['symtomDate', 'symtomHead', 'symtomUpperBody', 'symtomLowerBody', 'symtomHandFoot']
    
    def creat(self, validated_data):
        return DailySymtom.objects.create(**validated_data)