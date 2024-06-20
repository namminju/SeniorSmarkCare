from rest_framework import serializers
from .models import Disease

class PastDiseaseSerializer(serializers.ModelSerializer):
    pastDisease = serializers.MultipleChoiceField(choices=Disease.DISEASE_LIST)
    class Meta:
        model = Disease
        fields = ['pastDisease', 'hasSurgicalHistory']

class CurrentDiseaseSerializer(serializers.ModelSerializer):
    currentDisease = serializers.MultipleChoiceField(choices=Disease.DISEASE_LIST)
    class Meta:
        model = Disease
        fields = ['currentDisease',]
